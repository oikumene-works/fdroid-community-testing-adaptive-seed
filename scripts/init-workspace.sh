#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd -- "$repo_root"

mkdir -p -- .local/config .local/downloads .local/evidence .local/runtime \
    .local/cases .local/android/avd .local/android/user-home cases
if [[ ! -e .local/config/android.env ]]; then
    cp -- config/android.env.example .local/config/android.env
    echo "Created .local/config/android.env; review it before Android use."
else
    echo "Kept existing .local/config/android.env."
fi

echo "Local ignored directories are ready."
echo "This script did not download software, start ADB, or start an emulator."
