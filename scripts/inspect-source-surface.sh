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
require_tools gh tar gzip sort mktemp
for name in UPSTREAM_REPOSITORY UPSTREAM_PROVIDER UPSTREAM_SOURCE_COMMIT; do
    require_value "$name"
done
[[ "$UPSTREAM_PROVIDER" == "github" ]] || die "Unsupported upstream provider"
[[ "$UPSTREAM_REPOSITORY" =~ ^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$ ]] || \
    die "Invalid GitHub repository"
[[ "$UPSTREAM_SOURCE_COMMIT" =~ ^[0-9a-f]{40}$ ]] || die "Invalid source commit"

mkdir -p -- "$repo_root/.local/runtime"
scan_root="$(mktemp -d "$repo_root/.local/runtime/source-scan.XXXXXX")"
cleanup() {
    [[ "$scan_root" == "$repo_root"/.local/runtime/source-scan.* ]] || \
        die "Unexpected source-scan path"
    rm -rf -- "$scan_root"
}
trap cleanup EXIT

archive="$scan_root/source.tar.gz"
gh api "repos/${UPSTREAM_REPOSITORY}/tarball/${UPSTREAM_SOURCE_COMMIT}" > "$archive"
gzip -t "$archive"
findings="$(tar -xzf "$archive" \
    --to-command="$repo_root/scripts/lib/scan-source-member.sh" | sort -u || true)"

if $machine; then
    [[ -n "$findings" ]] && printf '%s\n' "$findings" || \
        echo "NO_EXTERNAL_OR_ACTION_VIEW_SURFACE_FOUND"
else
    echo "SOURCE_SURFACE_SCAN=COMPLETE"
    echo "Potential external-navigation and URL surfaces:"
    [[ -n "$findings" ]] && printf '%s\n' "$findings" || echo "(none found)"
    echo "The source archive was inspected transiently and removed without execution."
fi
