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
    2>/dev/null | grep -v 'git+' | grep -v 'simplify' | grep -v 'Once published' | grep -v 'will simplify' || true)

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
    2>/dev/null || true)

if [ -n "$AT_MAIN" ]; then
    echo "  ✗ Found @main references (should use pinned tags):"
    echo "$AT_MAIN" | sed 's/^/    /'
    ERRORS=$((ERRORS + 1))
else
    echo "  ✓ No @main references found"
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
