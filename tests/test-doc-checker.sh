#!/bin/bash
# Self-test for check-repo-docs.sh
# Verifies the checker catches each banned pattern and passes clean repos.
#
# Usage: bash tests/test-doc-checker.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CHECKER="$SCRIPT_DIR/../scripts/check-repo-docs.sh"
FIXTURES="$SCRIPT_DIR/doc-check-fixtures"
PASS=0
FAIL=0

run_test() {
    local name="$1"
    local fixture="$2"
    local expect="$3"  # "pass" or "fail"

    if bash "$CHECKER" "$fixture" > /dev/null 2>&1; then
        actual="pass"
    else
        actual="fail"
    fi

    if [ "$actual" = "$expect" ]; then
        echo "  ✓ $name (expected $expect, got $actual)"
        PASS=$((PASS + 1))
    else
        echo "  ✗ $name (expected $expect, got $actual)"
        FAIL=$((FAIL + 1))
    fi
}

echo "Doc Checker Self-Test"
echo "====================="
echo ""

run_test "clean repo passes"              "$FIXTURES/pass"              "pass"
run_test "bad security email fails"       "$FIXTURES/fail-security"     "fail"
run_test "aspirational pip install fails"  "$FIXTURES/fail-pip"          "fail"
run_test "stale @main reference fails"    "$FIXTURES/fail-main"         "fail"
run_test "@main in requirements.txt fails" "$FIXTURES/fail-requirements" "fail"

echo ""
echo "====================="
echo "Results: $PASS passed, $FAIL failed"

if [ "$FAIL" -gt 0 ]; then
    echo "SELF-TEST FAILED"
    exit 1
else
    echo "SELF-TEST PASSED"
fi
