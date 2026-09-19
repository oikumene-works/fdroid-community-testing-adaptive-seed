#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd -- "$repo_root"

echo "Guarded F-Droid community testing bootstrap"
git status --short --branch 2>/dev/null || echo "Git repository not initialized"
if git remote -v 2>/dev/null | rg -q .; then
    echo "Git remote: configured; no external action is implied"
else
    echo "Git remote: none"
fi
echo "This bootstrap did not start ADB or an emulator."

handoff="docs/next-session.md"
[[ -s "$handoff" ]] || {
    echo "Missing or empty next-session handoff: $handoff" >&2
    exit 1
}
echo
echo "--- Next Session ---"
cat -- "$handoff"

if [[ -s cases/active-case ]]; then
    IFS= read -r active_case < cases/active-case
    [[ "$active_case" =~ ^[a-z0-9][a-z0-9-]*$ ]] || {
        echo "Invalid active-case pointer" >&2
        exit 1
    }
    echo "Active case: $active_case"
    sed -n '1,120p' "cases/$active_case/case.md"
else
    echo "Active case: none"
fi

echo "Read AGENTS.md, docs/next-session.md, docs/session-continuity.md,"
echo "docs/protocol.md, and the complete active case records before acting."
