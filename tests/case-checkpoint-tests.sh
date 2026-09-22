#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
test_root="$(mktemp -d)"
trap 'rm -rf -- "$test_root"' EXIT
fixture="$test_root/repo"
mkdir -p "$fixture/scripts" "$fixture/templates" "$fixture/cases"
mkdir -p "$fixture/scripts/lib"
cp "$repo_root/scripts/lib/common.sh" "$fixture/scripts/lib/"
cp "$repo_root/scripts/create-case.sh" "$repo_root/scripts/check-case-records.sh" \
    "$fixture/scripts/"
cp "$repo_root/templates/"* "$fixture/templates/"
chmod +x "$fixture/scripts/"*.sh

"$fixture/scripts/create-case.sh" pending-app-12345 >/dev/null
output="$("$fixture/scripts/check-case-records.sh")"
rg -Fq 'Inactive pending case checkpoint: pending-app-12345' <<<"$output"
printf '%s\n' pending-app-12345 >"$fixture/cases/active-case"
if "$fixture/scripts/check-case-records.sh" >/dev/null 2>&1; then
    echo "Unresolved inactive case unexpectedly passed as active" >&2
    exit 1
fi

# A fully qualified synthetic record may retain product findings. Real actions
# remain forbidden by EXAMPLE_ONLY; this tests local record validation only.
cp "$repo_root/examples/fictional/case.env" "$fixture/cases/pending-app-12345/case.env"
cp "$repo_root/examples/fictional/claims.md" "$repo_root/examples/fictional/qualification.md" \
    "$fixture/cases/pending-app-12345/"
sed -i 's/^CASE_ID=.*/CASE_ID=pending-app-12345/; s/^CLAIM_REVIEW_STATUS=.*/CLAIM_REVIEW_STATUS=FINDINGS_RECORDED/' \
    "$fixture/cases/pending-app-12345/case.env"
sed -i 's/^CLAIM_REVIEW_STATUS=.*/CLAIM_REVIEW_STATUS=FINDINGS_RECORDED/' \
    "$fixture/cases/pending-app-12345/claims.md"
review_sha="$(sha256sum "$fixture/cases/pending-app-12345/claims.md" | cut -d' ' -f1)"
sed -i "s/^EXPECTED_CLAIM_REVIEW_SHA256=.*/EXPECTED_CLAIM_REVIEW_SHA256=$review_sha/" \
    "$fixture/cases/pending-app-12345/case.env"
"$fixture/scripts/check-case-records.sh" >/dev/null
printf '%s\n' 'changed scope after review' >> "$fixture/cases/pending-app-12345/claims.md"
if "$fixture/scripts/check-case-records.sh" >/dev/null 2>&1; then
    echo "Active record accepted an unreviewed scope change" >&2
    exit 1
fi

echo "Inactive checkpoint, qualified findings and active-record tamper tests passed: 4"
