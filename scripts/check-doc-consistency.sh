#!/bin/bash
# Cross-repo documentation consistency checker (v2).
# Scans all public repos for banned patterns.
# Uses the same find+grep logic as check-repo-docs.sh for parity.
#
# Usage: bash check-doc-consistency.sh /path/to/github-repos

set -euo pipefail

BASE="${1:-.}"
ERRORS=0

SECURITY_EMAIL="security@qontos.io"
SDK_TAG="v0.2.0"
SIM_TAG="v0.1.0"

REPOS=".github qontos qontos-sim qontos-examples qontos-benchmarks qontos-research"

# Build file list across all repos (same find logic as check-repo-docs.sh)
FILES=""
for repo in $REPOS; do
    if [ -d "$BASE/$repo" ]; then
        REPO_FILES=$(find "$BASE/$repo" -maxdepth 3 \
            \( -name '*.md' -o -name '*.txt' -o -name '*.toml' -o -name 'requirements*.txt' \) \
            -not -path '*/.git/*' -not -path '*/node_modules/*' 2>/dev/null || true)
        FILES="$FILES
$REPO_FILES"
    fi
done
FILES=$(echo "$FILES" | grep -v '^$' | sort -u)
FILE_COUNT=$(echo "$FILES" | grep -c . || echo 0)

echo "QONTOS Cross-Repo Doc Consistency (v2)"
echo "======================================="
echo "Scanning $FILE_COUNT files across 6 repos"

# ---------------------------------------------------------------
# Check 1: Security email (same logic as check-repo-docs.sh)
# ---------------------------------------------------------------
echo ""
echo "--- Check 1: Security email ---"
BAD_SEC=$(echo "$FILES" | xargs grep -n 'security@' 2>/dev/null \
    | grep -v "$SECURITY_EMAIL" | grep -v 'CONTRIBUTING' || true)
if [ -n "$BAD_SEC" ]; then
    echo "  ✗ Non-canonical security email:"
    echo "$BAD_SEC" | sed 's/^/    /'
    ERRORS=$((ERRORS + 1))
else
    echo "  ✓ OK"
fi

# ---------------------------------------------------------------
# Check 2: No aspirational pip install (same logic)
# ---------------------------------------------------------------
echo ""
echo "--- Check 2: Aspirational pip install ---"
BAD_PIP=$(echo "$FILES" | xargs grep -n 'pip install qontos\b\|pip install qontos-sim\b\|pip install qontos-bench\b' 2>/dev/null \
    | grep -v 'git+' | grep -v 'simplify' | grep -v 'Once published' | grep -v 'will simplify' \
    | grep -v 'Never write' | grep -v 'CONTRIBUTING' || true)
if [ -n "$BAD_PIP" ]; then
    echo "  ✗ Aspirational install:"
    echo "$BAD_PIP" | sed 's/^/    /'
    ERRORS=$((ERRORS + 1))
else
    echo "  ✓ OK"
fi

# ---------------------------------------------------------------
# Check 3: No @main references (same logic)
# ---------------------------------------------------------------
echo ""
echo "--- Check 3: @main references ---"
BAD_MAIN=$(echo "$FILES" | xargs grep -n '@main' 2>/dev/null \
    | grep -v 'Never use' | grep -v 'CONTRIBUTING' || true)
if [ -n "$BAD_MAIN" ]; then
    echo "  ✗ @main reference:"
    echo "$BAD_MAIN" | sed 's/^/    /'
    ERRORS=$((ERRORS + 1))
else
    echo "  ✓ OK"
fi

# ---------------------------------------------------------------
# Check 4: Pinned tag consistency
# ---------------------------------------------------------------
echo ""
echo "--- Check 4: Pinned tag versions ---"
TAG_ISSUES=""
SDK_REFS=$(echo "$FILES" | xargs grep -c "@${SDK_TAG}" 2>/dev/null | awk -F: '{s+=$NF} END {print s+0}')
SIM_REFS=$(echo "$FILES" | xargs grep -c "@${SIM_TAG}" 2>/dev/null | awk -F: '{s+=$NF} END {print s+0}')
if [ "${SDK_REFS:-0}" -lt 1 ]; then
    TAG_ISSUES="${TAG_ISSUES}\n  SDK tag ${SDK_TAG} not found in downstream deps"
fi
if [ "${SIM_REFS:-0}" -lt 1 ]; then
    TAG_ISSUES="${TAG_ISSUES}\n  Sim tag ${SIM_TAG} not found in downstream deps"
fi
if [ -n "$TAG_ISSUES" ]; then
    echo "  ✗ Tag inconsistencies:"
    echo -e "$TAG_ISSUES" | sed 's/^/    /'
    ERRORS=$((ERRORS + 1))
else
    echo "  ✓ SDK ${SDK_TAG} and Sim ${SIM_TAG} referenced consistently"
fi

# ---------------------------------------------------------------
# Summary
# ---------------------------------------------------------------
echo ""
echo "======================================="
if [ "$ERRORS" -gt 0 ]; then
    echo "FAIL: $ERRORS consistency issue(s) found"
    exit 1
else
    echo "PASS: All public docs are consistent"
fi
