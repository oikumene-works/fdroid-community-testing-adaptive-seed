#!/usr/bin/env bash
set -euo pipefail
# shellcheck source-path=SCRIPTDIR
# shellcheck disable=SC2154

# shellcheck source=lib/common.sh
source "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)/lib/common.sh"
cd -- "$repo_root"

machine=false
case_args=()
while (($#)); do
    case "$1" in
        --machine) machine=true; shift ;;
        --case)
            (($# >= 2)) || die "--case requires a case ID"
            case_args+=("$1" "$2")
            shift 2
            ;;
        *) die "Unknown argument: $1" ;;
    esac
done

resolve_case "${case_args[@]}"
load_case
require_tools gh jq base64 sha256sum mktemp sort rg sed
for name in UPSTREAM_REPOSITORY UPSTREAM_PROVIDER UPSTREAM_SOURCE_COMMIT \
    PUBLIC_CLAIM_PATHS; do
    require_value "$name"
done
[[ "$UPSTREAM_PROVIDER" == "github" ]] || die "Unsupported upstream provider"
[[ "$UPSTREAM_REPOSITORY" =~ ^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$ ]] || \
    die "Invalid GitHub repository"
[[ "$UPSTREAM_SOURCE_COMMIT" =~ ^[0-9a-f]{40}$ ]] || die "Invalid source commit"
[[ "$PUBLIC_CLAIM_PATHS" != "NONE" ]] || die "At least one claim path is required"

mkdir -p -- "$repo_root/.local/runtime"
claims_root="$(mktemp -d "$repo_root/.local/runtime/public-claims.XXXXXX")"
cleanup() {
    [[ "$claims_root" == "$repo_root"/.local/runtime/public-claims.* ]] || \
        die "Unexpected claim-scan path"
    rm -rf -- "$claims_root"
}
trap cleanup EXIT

while IFS= read -r claim_path; do
    [[ "$claim_path" =~ ^[-A-Za-z0-9_.@/+\ ]+$ ]] || die "Invalid claim path"
    [[ "$claim_path" != /* && "$claim_path" != *".."* ]] || die "Unsafe claim path"
    encoded="$(jq -rn --arg value "$claim_path" '$value | @uri')"
    output="$claims_root/$(printf '%s' "$claim_path" | sha256sum | cut -d' ' -f1)"
    gh api "repos/${UPSTREAM_REPOSITORY}/contents/${encoded}?ref=${UPSTREAM_SOURCE_COMMIT}" \
        --jq .content | base64 --decode > "$output"
    printf '%s\t%s\n' "$claim_path" "$(sha256sum "$output" | cut -d' ' -f1)"
done < <(csv_lines "$PUBLIC_CLAIM_PATHS" | sort) > "$claims_root/files.tsv"

if $machine; then
    cat "$claims_root/files.tsv"
    exit 0
fi

echo "PUBLIC_CLAIM_SCAN=COMPLETE"
cat "$claims_root/files.tsv"
echo "Potential universal claims for manual review:"
found=false
while IFS=$'\t' read -r claim_path claim_sha256; do
    output="$claims_root/$(printf '%s' "$claim_path" | sha256sum | cut -d' ' -f1)"
    matches="$(rg -n -i \
        '\b(always|never|none|nothing|no |every|all|only|without|unchanged|untouched)\b' \
        "$output" | sed -n 'l' || true)"
    if [[ -n "$matches" ]]; then
        found=true
        echo "--- $claim_path ($claim_sha256)"
        printf '%s\n' "$matches"
    fi
done < "$claims_root/files.tsv"
$found || echo "(none found by the bounded pattern scan)"
