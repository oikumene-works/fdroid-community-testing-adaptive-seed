#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
scanner="$repo_root/scripts/lib/scan-source-member.sh"
passed=0

run_scan() {
    local member="$1"
    local input="$2"
    TAR_FILENAME="$member" "$scanner" <<<"$input"
}

output="$(run_scan repo/src/net/client.ts 'fetch("https://example.invalid/api")')"
rg -Fq 'src/net/client.ts:' <<<"$output"
passed=$((passed + 1))

output="$(run_scan repo/lib/share.dart 'Browser.open(url: target); Share.share(text);')"
rg -Fq 'lib/share.dart:' <<<"$output"
passed=$((passed + 1))

output="$(run_scan repo/package.json '{"dependencies":{"@capacitor/share":"1.0.0"}}')"
rg -Fq 'package.json:' <<<"$output"
passed=$((passed + 1))

output="$(run_scan repo/android/app/src/main/AndroidManifest.xml \
    '<provider android:exported="true" android:permission="example.permission" />')"
rg -Fq 'AndroidManifest.xml:' <<<"$output"
passed=$((passed + 1))

output="$(run_scan repo/assets/readme.txt 'fetch("https://example.invalid")')"
[[ -z "$output" ]]
passed=$((passed + 1))

echo "Expanded source-surface scanner tests passed: $passed"
