#!/bin/bash
# QGH-3704: Public documentation consistency checker
# Run against cloned public repos to catch stale patterns.
#
# Usage: bash check-doc-consistency.sh /path/to/github-repos
#
# Fails if any banned pattern is found in public-facing docs.

set -euo pipefail

BASE="${1:-.}"
ERRORS=0

# Canonical values
SECURITY_EMAIL="security@qontos.io"
SDK_TAG="v0.2.0"
SIM_TAG="v0.1.0"

echo "QONTOS Public Doc Consistency Check"
echo "===================================="
echo ""

# ---------------------------------------------------------------
# Check 1: Security email consistency
# ---------------------------------------------------------------
echo "--- Check 1: Security email ---"
STALE_SECURITY=$(grep -rn 'security@' \
    "$BASE"/{.github,qontos,qontos-sim,qontos-examples,qontos-benchmarks,qontos-research}/*.md \
    "$BASE"/{.github,qontos,qontos-sim,qontos-examples,qontos-benchmarks,qontos-research}/**/*.md \
    2>/dev/null | grep -v "$SECURITY_EMAIL" | grep -v 'node_modules' || true)

if [ -n "$STALE_SECURITY" ]; then
    echo "  ✗ Found non-canonical security email references:"
    echo "$STALE_SECURITY" | sed 's/^/    /'
    ERRORS=$((ERRORS + 1))
else
    echo "  ✓ All security references use $SECURITY_EMAIL"
fi

# ---------------------------------------------------------------
# Check 2: No aspirational pip install (bare package names)
# ---------------------------------------------------------------
echo ""
echo "--- Check 2: No aspirational pip install ---"
ASPIRATIONAL=$(grep -rn 'pip install qontos\b\|pip install qontos-sim\b\|pip install qontos-bench\b' \
    "$BASE"/{.github,qontos,qontos-sim,qontos-examples,qontos-benchmarks,qontos-research}/*.md \
    "$BASE"/{.github,qontos,qontos-sim,qontos-examples,qontos-benchmarks,qontos-research}/**/*.md \
    2>/dev/null | grep -v 'git+' | grep -v 'simplify' | grep -v 'Once published' | grep -v 'will simplify' | grep -v 'Never write' | grep -v 'CONTRIBUTING' || true)

if [ -n "$ASPIRATIONAL" ]; then
    echo "  ✗ Found aspirational pip install (packages not on PyPI yet):"
    echo "$ASPIRATIONAL" | sed 's/^/    /'
    ERRORS=$((ERRORS + 1))
else
    echo "  ✓ No aspirational pip install commands found"
fi

# ---------------------------------------------------------------
# Check 3: No @main install references
# ---------------------------------------------------------------
echo ""
echo "--- Check 3: No @main install references ---"
AT_MAIN=$(grep -rn '@main' \
    "$BASE"/{.github,qontos,qontos-sim,qontos-examples,qontos-benchmarks,qontos-research}/*.md \
    "$BASE"/{.github,qontos,qontos-sim,qontos-examples,qontos-benchmarks,qontos-research}/*.txt \
    "$BASE"/{.github,qontos,qontos-sim,qontos-examples,qontos-benchmarks,qontos-research}/*.toml \
    2>/dev/null | grep -v 'Never use' | grep -v 'CONTRIBUTING' || true)

if [ -n "$AT_MAIN" ]; then
    echo "  ✗ Found @main references (should use pinned tags):"
    echo "$AT_MAIN" | sed 's/^/    /'
    ERRORS=$((ERRORS + 1))
else
    echo "  ✓ No @main references found"
fi

# ---------------------------------------------------------------
# Check 4: Support email consistency
# ---------------------------------------------------------------
echo ""
echo "--- Check 4: Support email ---"
SUPPORT_EMAIL="enterprise@qontos.io"
STALE_SUPPORT=$(grep -rn 'enterprise@\|support@' \
    "$BASE"/{.github,qontos,qontos-sim,qontos-examples,qontos-benchmarks,qontos-research}/*.md \
    "$BASE"/{.github,qontos,qontos-sim,qontos-examples,qontos-benchmarks,qontos-research}/**/*.md \
    2>/dev/null | grep -v "$SUPPORT_EMAIL" | grep -v 'node_modules' | grep -v 'qontos@zhyra.xyz' | grep -v 'rameshtamilselvan' || true)

if [ -n "$STALE_SUPPORT" ]; then
    echo "  ✗ Found non-canonical enterprise/support email references:"
    echo "$STALE_SUPPORT" | sed 's/^/    /'
    ERRORS=$((ERRORS + 1))
else
    echo "  ✓ Enterprise support references are consistent"
fi

# ---------------------------------------------------------------
# Check 5: Pinned tag consistency across repos
# ---------------------------------------------------------------
echo ""
echo "--- Check 5: Pinned tag versions ---"
TAG_ISSUES=""

# SDK tag should be consistent
SDK_REFS=$(grep -rc "@${SDK_TAG}" \
    "$BASE"/{qontos-sim,qontos-examples}/ \
    2>/dev/null | awk -F: '{s+=$2} END {print s+0}')
if [ "${SDK_REFS:-0}" -lt 1 ]; then
    TAG_ISSUES="${TAG_ISSUES}\n  SDK tag ${SDK_TAG} not found in sim/examples deps"
fi

# Sim tag should be consistent
SIM_REFS=$(grep -rc "@${SIM_TAG}" \
    "$BASE"/qontos-examples/ \
    2>/dev/null | awk -F: '{s+=$2} END {print s+0}')
if [ "${SIM_REFS:-0}" -lt 1 ]; then
    TAG_ISSUES="${TAG_ISSUES}\n  Sim tag ${SIM_TAG} not found in examples deps"
fi

if [ -n "$TAG_ISSUES" ]; then
    echo "  ✗ Tag inconsistencies:"
    echo -e "$TAG_ISSUES" | sed 's/^/    /'
    ERRORS=$((ERRORS + 1))
else
    echo "  ✓ SDK ${SDK_TAG} and Sim ${SIM_TAG} referenced consistently"
fi

# ---------------------------------------------------------------
# Check 6: No stale homepage/docs URLs
# ---------------------------------------------------------------
echo ""
echo "--- Check 6: No stale URLs ---"
STALE_URLS=$(grep -rn 'qontos\.dev\|docs\.qontos\.' \
    "$BASE"/{.github,qontos,qontos-sim,qontos-examples,qontos-benchmarks,qontos-research}/*.md \
    "$BASE"/{.github,qontos,qontos-sim,qontos-examples,qontos-benchmarks,qontos-research}/**/*.md \
    2>/dev/null || true)

if [ -n "$STALE_URLS" ]; then
    echo "  ⚠ Found docs URLs that may not resolve yet (verify manually):"
    echo "$STALE_URLS" | head -5 | sed 's/^/    /'
    # Warning only, not a hard failure
else
    echo "  ✓ No potentially stale docs URLs found"
fi

# ---------------------------------------------------------------
# Summary
# ---------------------------------------------------------------
echo ""
echo "===================================="
if [ "$ERRORS" -gt 0 ]; then
    echo "FAIL: $ERRORS consistency issue(s) found"
    exit 1
else
    echo "PASS: All public docs are consistent"
fi
