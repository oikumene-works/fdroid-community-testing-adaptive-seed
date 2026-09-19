#!/usr/bin/env bash
set -euo pipefail
# shellcheck source-path=SCRIPTDIR
# shellcheck disable=SC2034

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=scripts/lib/common.sh
source "$repo_root/scripts/lib/common.sh"
cd -- "$repo_root"

require_tools mktemp sha256sum
rg -Fxq 'EXAMPLE_ONLY=true' examples/fictional/case.env || \
    die "Fictional example lost its permanent execution guard"
mkdir -p -- .local/runtime
test_root="$(mktemp -d "$repo_root/.local/runtime/fictional-dry-run.XXXXXX")"
cleanup() {
    [[ "$test_root" == "$repo_root"/.local/runtime/fictional-dry-run.* ]] || \
        die "Unexpected fictional dry-run path"
    rm -rf -- "$test_root"
}
trap cleanup EXIT

printf '%s\n' 'synthetic claim review' >"$test_root/claims.md"
printf '%s\n' 'synthetic qualification' >"$test_root/qualification.md"
case_dir="$test_root"
CASE_ID=fictional-dry-run
EXAMPLE_ONLY=true
CLAIM_REVIEW_FILE=claims.md
EXPECTED_CLAIM_REVIEW_SHA256="$(sha256sum "$test_root/claims.md" | cut -d' ' -f1)"
CLAIM_REVIEW_STATUS=PASS
APK_QUALIFICATION_FILE=qualification.md
EXPECTED_APK_QUALIFICATION_SHA256="$(sha256sum "$test_root/qualification.md" | cut -d' ' -f1)"
APK_QUALIFICATION_STATUS=NOT_STARTED
echo "[PURE LOCAL READ] Inspect the synthetic selection, claim review, and planned checklist."
echo "[IGNORED-LOCAL WRITE] Create and remove only this bounded dry-run fixture."
if (require_real_case) >/dev/null 2>&1; then
    die "Fictional execution guard unexpectedly passed"
fi
echo "DENIAL=fictional case cannot activate, download, execute, or post"

EXAMPLE_ONLY=false
CLAIM_REVIEW_STATUS=CLARIFICATION_REQUIRED
if (require_claim_gate) >/dev/null 2>&1; then
    die "Clarification-required claim gate unexpectedly passed"
fi
echo "DENIAL=unresolved public claim blocks executable gates"

CLAIM_REVIEW_STATUS=PASS
require_claim_gate
if (require_qualification_gate) >/dev/null 2>&1; then
    die "Incomplete qualification gate unexpectedly passed"
fi
echo "DENIAL=pending built surface blocks execution"

if (require_approval_token execute wrong-token) >/dev/null 2>&1; then
    die "Incorrect approval token unexpectedly passed"
fi
echo "DENIAL=script token cannot substitute for exact human authorization"

echo "LATER_GATES=network-read,executable-download,android-mutation,report-review,external-mutation"
echo "FICTIONAL_DRY_RUN=PASS"
echo "No network, candidate, Android tool, credential, upload, or external mutation was used."
