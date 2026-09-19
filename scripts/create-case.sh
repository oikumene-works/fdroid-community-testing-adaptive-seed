#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd -- "$repo_root"

case_id="${1:-}"
[[ "$case_id" =~ ^[a-z0-9][a-z0-9-]*$ ]] || {
    echo "Usage: $0 CASE_ID" >&2
    exit 1
}
destination="cases/$case_id"
[[ ! -e "$destination" ]] || {
    echo "Case already exists: $destination" >&2
    exit 1
}

mkdir -p -- "$destination"
cp -- templates/case.env templates/case.md templates/claims.md \
    templates/qualification.md templates/report.md templates/public-comment.md \
    "$destination/"
template_marker="CHANGE""ME"
sed -i "s/^CASE_ID=${template_marker}$/CASE_ID=${case_id}/" "$destination/case.env"

echo "Created $destination with every executable and public gate closed."
echo "Fill exact public facts; do not activate until claims and qualification pass."
