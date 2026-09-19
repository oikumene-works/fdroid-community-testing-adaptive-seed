#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd -- "$repo_root"

failed=false
while IFS= read -r document; do
    while IFS= read -r raw; do
        target="${raw#](}"
        target="${target%)}"
        target="${target%%#*}"
        case "$target" in
            "" | http://* | https://* | mailto:*) continue ;;
        esac
        if [[ ! -e "$(dirname -- "$document")/$target" ]]; then
            echo "Broken local link: $document -> $target" >&2
            failed=true
        fi
    done < <(rg -o '\]\([^ )#]+(?:#[^ )]+)?\)' "$document" || true)
done < <(find . -path './.git' -prune -o -path './.local' -prune -o \
    -type f -name '*.md' -print)
$failed && exit 1
echo "Local Markdown links passed."
