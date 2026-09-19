#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
test_root="$(mktemp -d)"
trap 'rm -rf -- "$test_root"' EXIT
fixture="$test_root/repo"
fake_bin="$test_root/bin"
fake_sdk="$test_root/sdk"
mkdir -p "$fixture/scripts/lib" "$fixture/cases/pending-case" \
    "$fixture/.local/config" "$fake_bin" "$fake_sdk/build-tools/test"
cp "$repo_root/scripts/lib/common.sh" "$fixture/scripts/lib/common.sh"
cp "$repo_root/scripts/lib/apk.sh" "$fixture/scripts/lib/apk.sh"
cp "$repo_root/scripts/qualify-case-apk.sh" "$fixture/scripts/qualify-case-apk.sh"
chmod +x "$fixture/scripts/qualify-case-apk.sh"
printf '%s\n' '.local/' >"$fixture/.gitignore"
printf '%s\n' 'reviewed claims' >"$fixture/cases/pending-case/claims.md"
claims_sha="$(sha256sum "$fixture/cases/pending-case/claims.md" | cut -d' ' -f1)"
apk_sha="$(printf 'synthetic apk bytes' | sha256sum | cut -d' ' -f1)"
cat >"$fixture/cases/pending-case/case.env" <<EOF
CASE_ID=pending-case
EXAMPLE_ONLY=false
APP_ID=org.example.pending
VERSION_NAME=1.0.0
VERSION_CODE=1
EXPECTED_MIN_SDK=29
EXPECTED_TARGET_SDK=34
EXPECTED_APK_PERMISSIONS=PENDING_APK_QUALIFICATION
EXPECTED_APK_FEATURES=PENDING_APK_QUALIFICATION
EXPECTED_APK_NATIVE_CODE=PENDING_APK_QUALIFICATION
EXPECTED_APK_MANIFEST_XMLTREE_SHA256=PENDING_APK_QUALIFICATION
EXPECTED_SIGNING_CERT_SHA256=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
UPSTREAM_APK_SHA256=$apk_sha
CODE_QUALITY_APK_URL=https://example.invalid/pending.apk
CLAIM_REVIEW_FILE=claims.md
EXPECTED_CLAIM_REVIEW_SHA256=$claims_sha
CLAIM_REVIEW_STATUS=PASS
EOF
cat >"$fixture/scripts/recheck-case.sh" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
echo READ_ONLY_RECHECK=PASS
EOF
chmod +x "$fixture/scripts/recheck-case.sh"

cat >"$fake_bin/curl" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
output=""
while (($#)); do
    case "$1" in
        --output) output="$2"; shift 2 ;;
        *) shift ;;
    esac
done
printf 'synthetic apk bytes' >"$output"
EOF
cat >"$fake_bin/aapt" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
case "$1 $2" in
    'dump badging')
        cat <<'OUT'
package: name='org.example.pending' versionCode='1' versionName='1.0.0'
sdkVersion:'29'
targetSdkVersion:'34'
uses-feature: name='android.hardware.touchscreen'
uses-implied-feature: name='android.hardware.faketouch'
native-code: 'arm64-v8a' 'x86_64'
OUT
        ;;
    'dump permissions')
        printf "%s\n" "uses-permission: name='android.permission.VIBRATE'"
        ;;
    'dump xmltree')
        cat <<'OUT'
E: manifest (line=1)
  E: uses-permission (line=2)
    A: android:name="android.permission.VIBRATE"
  E: application (line=3)
    E: activity (line=4)
      A: android:name="org.example.pending.MainActivity"
      A: android:exported=true
OUT
        ;;
    *) exit 4 ;;
esac
EOF
cat >"$fake_bin/apksigner" <<'EOF'
#!/usr/bin/env bash
printf '%s\n' 'Signer #1 certificate SHA-256 digest: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
EOF
cat >"$fake_bin/zipalign" <<'EOF'
#!/usr/bin/env bash
exit 0
EOF
cat >"$fake_bin/bwrap" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
input=""
while (($#)); do
    case "$1" in
        --ro-bind)
            [[ "$3" != /input.apk ]] || input="$2"
            shift 3
            ;;
        --proc | --dev | --tmpfs) shift 2 ;;
        --unshare-all | --die-with-parent | --new-session) shift ;;
        /build-tools/*)
            tool="$MOCK_FAKE_BIN/${1##*/}"
            shift
            args=()
            for arg in "$@"; do
                [[ "$arg" != /input.apk ]] || arg="$input"
                args+=("$arg")
            done
            exec "$tool" "${args[@]}"
            ;;
        *) exit 5 ;;
    esac
done
EOF
chmod +x "$fake_bin"/*
cp "$fake_bin/aapt" "$fake_bin/apksigner" "$fake_bin/zipalign" \
    "$fake_sdk/build-tools/test/"
printf '%s\n' 'ANDROID_BUILD_TOOLS_VERSION=test' >"$fixture/.local/config/android.env"

git -C "$fixture" init -q
git -C "$fixture" -c user.name=Test -c user.email=test.invalid add .
git -C "$fixture" -c user.name=Test -c user.email=test.invalid commit -qm fixture

output="$(PATH="$fake_bin:$PATH" MOCK_FAKE_BIN="$fake_bin" ANDROID_SDK_ROOT="$fake_sdk" \
    "$fixture/scripts/qualify-case-apk.sh" --case pending-case \
    --approval qualify-apk:pending-case)"
rg -Fq 'APK_QUALIFICATION=RECONCILIATION_REQUIRED' <<<"$output"
rg -Fq 'APK_PERMISSIONS=android.permission.VIBRATE' <<<"$output"
rg -Fq 'APK_USES_FEATURES=android.hardware.faketouch,android.hardware.touchscreen' <<<"$output"
rg -Fq 'APK_NATIVE_CODE=arm64-v8a,x86_64' <<<"$output"
rg -Fq 'E: activity' <<<"$output"
[[ -z "$(find "$fixture/.local/downloads" -type f -name '*.apk' -print)" ]]

echo "Pending qualification and complete built-surface test passed: 1"
