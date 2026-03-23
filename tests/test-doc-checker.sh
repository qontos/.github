#!/bin/bash
# Self-test for BOTH doc checkers:
#   1. check-repo-docs.sh (per-repo, vendored)
#   2. check-doc-consistency.sh (cross-repo, org-level)
#
# Verifies both catch the same banned patterns and pass clean repos.
# Fails if either checker drifts from the shared policy.
#
# Usage: bash tests/test-doc-checker.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_CHECKER="$SCRIPT_DIR/../scripts/check-repo-docs.sh"
CROSS_CHECKER="$SCRIPT_DIR/../scripts/check-doc-consistency.sh"
FIXTURES="$SCRIPT_DIR/doc-check-fixtures"
PASS=0
FAIL=0

run_test() {
    local name="$1"
    local checker="$2"
    local fixture="$3"
    local expect="$4"  # "pass" or "fail"

    if bash "$checker" "$fixture" > /dev/null 2>&1; then
        actual="pass"
    else
        actual="fail"
    fi

    if [ "$actual" = "$expect" ]; then
        echo "  ✓ $name"
        PASS=$((PASS + 1))
    else
        echo "  ✗ $name (expected $expect, got $actual)"
        FAIL=$((FAIL + 1))
    fi
}

echo "Doc Checker Parity Test"
echo "======================="

# --- Per-repo checker (check-repo-docs.sh) ---
echo ""
echo "--- Per-repo checker ---"
run_test "repo: clean passes"              "$REPO_CHECKER" "$FIXTURES/pass"              "pass"
run_test "repo: bad security fails"        "$REPO_CHECKER" "$FIXTURES/fail-security"     "fail"
run_test "repo: bare pip install fails"    "$REPO_CHECKER" "$FIXTURES/fail-pip"          "fail"
run_test "repo: @main in .md fails"        "$REPO_CHECKER" "$FIXTURES/fail-main"         "fail"
run_test "repo: @main in req.txt fails"    "$REPO_CHECKER" "$FIXTURES/fail-requirements" "fail"
run_test "repo: stale notebook pip fails"  "$REPO_CHECKER" "$FIXTURES/fail-notebook"     "fail"

# --- Cross-repo checker (check-doc-consistency.sh) ---
# The cross-repo checker expects repos as subdirectories, so we wrap
# fixtures inside a fake repo structure.
echo ""
echo "--- Cross-repo checker ---"

# Build a minimal cross-repo tree for testing
CROSS_TMP=$(mktemp -d)
trap "rm -rf $CROSS_TMP" EXIT

# Clean case: all repos have valid docs with pinned tags
for repo in .github qontos qontos-sim qontos-examples qontos-benchmarks qontos-research; do
    mkdir -p "$CROSS_TMP/$repo"
    echo "Report to security@qontos.io" > "$CROSS_TMP/$repo/SECURITY.md"
    echo "pip install git+https://github.com/qontos/qontos.git@v0.2.0" > "$CROSS_TMP/$repo/README.md"
done
# Ensure tag references exist for the tag-consistency check
echo "git+https://github.com/qontos/qontos.git@v0.2.0" > "$CROSS_TMP/qontos-sim/requirements.txt"
echo "git+https://github.com/qontos/qontos-sim.git@v0.1.0" > "$CROSS_TMP/qontos-examples/requirements.txt"
run_test "cross: clean passes" "$CROSS_CHECKER" "$CROSS_TMP" "pass"

# Bad security email in one repo
echo "Report to security@wrong.com" > "$CROSS_TMP/qontos/SECURITY.md"
run_test "cross: bad security fails" "$CROSS_CHECKER" "$CROSS_TMP" "fail"
echo "Report to security@qontos.io" > "$CROSS_TMP/qontos/SECURITY.md"  # restore

# @main in requirements.txt
echo "git+https://github.com/qontos/qontos.git@main" > "$CROSS_TMP/qontos-examples/requirements.txt"
run_test "cross: @main in req.txt fails" "$CROSS_CHECKER" "$CROSS_TMP" "fail"
rm "$CROSS_TMP/qontos-examples/requirements.txt"  # restore

# Bare pip install
echo "pip install qontos" > "$CROSS_TMP/qontos-sim/README.md"
run_test "cross: bare pip install fails" "$CROSS_CHECKER" "$CROSS_TMP" "fail"

echo ""
echo "======================="
echo "Results: $PASS passed, $FAIL failed"

if [ "$FAIL" -gt 0 ]; then
    echo "PARITY TEST FAILED"
    exit 1
else
    echo "PARITY TEST PASSED"
fi
