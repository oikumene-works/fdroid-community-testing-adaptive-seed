#!/usr/bin/env bash
# shellcheck disable=SC2034
set -euo pipefail
# shellcheck source-path=SCRIPTDIR

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=scripts/lib/common.sh
source "$repo_root/scripts/lib/common.sh"

mkdir -p -- "$repo_root/.local/runtime"
test_root="$(mktemp -d "$repo_root/.local/runtime/guard-test.XXXXXX")"
cleanup() {
    [[ "$test_root" == "$repo_root"/.local/runtime/guard-test.* ]] || \
        die "Unexpected guard-test path"
    rm -rf -- "$test_root"
}
trap cleanup EXIT

printf '%s\n' 'TEST_SAFETY_STATUS=PASS' 'CLAIM_REVIEW_STATUS=PASS' 'synthetic claim review' > "$test_root/claims.md"
printf '%s\n' 'synthetic qualification' > "$test_root/qualification.md"
case_dir="$test_root"
CASE_ID=synthetic-guard-test
EXAMPLE_ONLY=true
CLAIM_REVIEW_FILE=claims.md
EXPECTED_CLAIM_REVIEW_SHA256="$(sha256sum "$test_root/claims.md" | cut -d' ' -f1)"
CLAIM_REVIEW_STATUS=PASS
TEST_SAFETY_STATUS=PASS
APK_QUALIFICATION_FILE=qualification.md
EXPECTED_APK_QUALIFICATION_SHA256="$(sha256sum "$test_root/qualification.md" | cut -d' ' -f1)"
APK_QUALIFICATION_STATUS=PASS
EXPECTED_APK_PERMISSIONS=NONE
EXPECTED_APK_FEATURES=NONE
EXPECTED_APK_NATIVE_CODE=NONE
EXPECTED_APK_MANIFEST_XMLTREE_SHA256=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa

if (require_real_case) >/dev/null 2>&1; then
    die "Example-only guard unexpectedly passed"
fi
EXAMPLE_ONLY=false

CLAIM_REVIEW_STATUS=CLARIFICATION_REQUIRED
if (require_claim_gate) >/dev/null 2>&1; then
    die "Clarification-required claim guard unexpectedly passed"
fi
CLAIM_REVIEW_STATUS=PASS
require_claim_gate

# Decisions must be reviewed together, not inferred from an env status alone.
review_decisions() {
    printf '%s\n' "TEST_SAFETY_STATUS=$TEST_SAFETY_STATUS" \
        "CLAIM_REVIEW_STATUS=$CLAIM_REVIEW_STATUS" \
        'Synthetic scope; known missing optional feature retained as a finding.' \
        > "$test_root/claims.md"
    EXPECTED_CLAIM_REVIEW_SHA256="$(sha256sum "$test_root/claims.md" | cut -d' ' -f1)"
}
for claim_status in PASS FINDINGS_RECORDED; do
    CLAIM_REVIEW_STATUS="$claim_status"
    TEST_SAFETY_STATUS=PASS
    review_decisions
    require_claim_gate
    for safety_status in BLOCKED NOT_REVIEWED invalid ''; do
        TEST_SAFETY_STATUS="$safety_status"
        review_decisions
        if (require_claim_gate) >/dev/null 2>&1; then
            die "Unsafe/unreviewed state passed: $claim_status / $safety_status"
        fi
    done
done
TEST_SAFETY_STATUS=PASS
for claim_status in CLARIFICATION_REQUIRED invalid ''; do
    CLAIM_REVIEW_STATUS="$claim_status"
    review_decisions
    if (require_claim_gate) >/dev/null 2>&1; then
        die "Unclassified review unexpectedly passed"
    fi
done
CLAIM_REVIEW_STATUS=FINDINGS_RECORDED
review_decisions
unset TEST_SAFETY_STATUS
if (require_claim_gate) >/dev/null 2>&1; then
    die "Legacy review without safety decision passed"
fi
TEST_SAFETY_STATUS=PASS
CLAIM_REVIEW_STATUS=PASS
if (require_claim_gate) >/dev/null 2>&1; then
    die "Env-only decision edit passed"
fi
review_decisions
printf '%s\n' 'unreviewed scope change' >> "$test_root/claims.md"
if (require_claim_gate) >/dev/null 2>&1; then
    die "Stale review digest passed"
fi
review_decisions
printf '%s\n' 'TEST_SAFETY_STATUS=PASS' >> "$test_root/claims.md"
EXPECTED_CLAIM_REVIEW_SHA256="$(sha256sum "$test_root/claims.md" | cut -d' ' -f1)"
if (require_claim_gate) >/dev/null 2>&1; then
    die "Duplicate safety decision passed"
fi
review_decisions
require_claim_gate

APK_QUALIFICATION_STATUS=NOT_STARTED
if (require_qualification_gate) >/dev/null 2>&1; then
    die "Incomplete qualification guard unexpectedly passed"
fi
APK_QUALIFICATION_STATUS=PASS
require_qualification_gate

if (require_approval_token execute wrong-token) >/dev/null 2>&1; then
    die "Incorrect approval token unexpectedly passed"
fi
require_approval_token execute "execute:${CASE_ID}"

echo "Guard tests passed without network, APK, emulator, or ADB access."
