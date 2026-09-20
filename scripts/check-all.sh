#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd -- "$repo_root"

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    git diff --check
    git diff --cached --check
fi

mapfile -t scripts < <(
    printf '%s\n' seed
    find scripts tests -type f -name '*.sh' -print | sort
)
shellcheck -x "${scripts[@]}"
for script in "${scripts[@]}"; do
    bash -n "$script"
    [[ -x "$script" ]] || {
        echo "Script is not executable: $script" >&2
        exit 1
    }
done

check_line_limit() {
    local path="$1"
    local maximum="$2"
    local count
    count="$(awk 'END {print NR}' "$path")"
    ((count <= maximum)) || {
        echo "Line limit exceeded: $path ($count > $maximum)" >&2
        exit 1
    }
}
check_line_limit AGENTS.md 80
check_line_limit README.md 120
check_line_limit docs/next-session.md 160
while IFS= read -r path; do check_line_limit "$path" 220; done < <(find docs -name '*.md' -print)
while IFS= read -r path; do check_line_limit "$path" 140; done < <(find templates -name '*.md' -print)

forbidden="$(find . -path './.git' -prune -o -path './.local' -prune -o \
    -type f \( -name '*.apk' -o -name '*.aab' -o -name '*.apks' -o \
    -name '*.zip' -o -name '*.log' -o -name '*.pcap' -o -name '*.pcapng' -o \
    -name '*.har' -o -name '*.keystore' -o -name '*.jks' -o -name '*.pem' \) -print)"
[[ -z "$forbidden" ]] || {
    echo "Forbidden public artifacts:" >&2
    printf '%s\n' "$forbidden" >&2
    exit 1
}

template_marker="CHANGE""ME"
if rg -n -F "$template_marker" --glob '!templates/**' --glob '!cases/**' \
    --glob '!.git/**' --glob '!.local/**'; then
    echo "Unresolved template value outside templates." >&2
    exit 1
fi
if rg -n '/home/[^ /]+|/Users/[^ /]+|[A-Za-z]:\\Users\\|jwennstrom' \
    --glob '!scripts/check-all.sh' --glob '!.git/**' --glob '!.local/**'; then
    echo "Workstation-specific path or identity found." >&2
    exit 1
fi
if rg -n 'AKIA[0-9A-Z]{16}|glpat-[A-Za-z0-9_-]{20,}|gh[pousr]_[A-Za-z0-9]{20,}' \
    --glob '!scripts/check-all.sh' --glob '!.git/**' --glob '!.local/**'; then
    echo "Possible credential found." >&2
    exit 1
fi

./tests/check-links.sh
./scripts/check-case-records.sh
./tests/guard-tests.sh
./tests/case-checkpoint-tests.sh
./tests/workflow-tests.sh
./tests/apk-qualification-tests.sh
./tests/source-scan-tests.sh
./tests/readiness-tests.sh
./tests/seed-grow-tests.sh

if [[ "${REQUIRE_NO_REMOTE:-0}" == "1" ]] && git remote -v 2>/dev/null | rg -q .; then
    echo "A Git remote is configured but REQUIRE_NO_REMOTE=1." >&2
    exit 1
fi

echo "Offline repository and guard checks passed."
echo "Tests may create and remove bounded ignored-local fixtures; no network or Android action occurred."
