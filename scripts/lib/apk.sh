#!/usr/bin/env bash
# shellcheck source-path=SCRIPTDIR
# shellcheck disable=SC2034,SC2153,SC2154

# shellcheck source=common.sh
source "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)/common.sh"

inspect_apk() {
    local input_apk="$1"
    local build_tools_dir config_file sdk_root system_dir badging manifest_tree
    local actual_permissions expected_permissions actual_features native_code

    inspected_apk_sha256="$(sha256sum "$input_apk" | cut -d' ' -f1)"
    [[ "$inspected_apk_sha256" == "$UPSTREAM_APK_SHA256" ]] || \
        die "APK SHA-256 mismatch: $inspected_apk_sha256"

    local -a sandbox=(
        bwrap --unshare-all --die-with-parent --new-session
        --ro-bind /usr /usr --proc /proc --dev /dev --tmpfs /tmp
    )
    for system_dir in /bin /lib /lib64 /etc; do
        [[ -e "$system_dir" ]] && sandbox+=(--ro-bind "$system_dir" "$system_dir")
    done
    config_file="$repo_root/.local/config/android.env"
    [[ -f "$config_file" ]] || die "Run ./scripts/init-workspace.sh and review local Android config"
    # Local operator configuration is trusted.
    # shellcheck source=/dev/null
    source "$config_file"
    require_value ANDROID_BUILD_TOOLS_VERSION
    sdk_root="${ANDROID_SDK_ROOT:-${ANDROID_HOME:-}}"
    if [[ -z "$sdk_root" ]]; then
        sdk_root="$(cd -- "$(dirname -- "$(command -v emulator)")/.." && pwd)"
    fi
    build_tools_dir="$sdk_root/build-tools/$ANDROID_BUILD_TOOLS_VERSION"
    [[ -x "$build_tools_dir/aapt" && -x "$build_tools_dir/apksigner" && \
        -x "$build_tools_dir/zipalign" ]] || \
        die "Configured Android build tools are missing: $build_tools_dir"
    sandbox+=(--ro-bind "$build_tools_dir" /build-tools --ro-bind "$input_apk" /input.apk)

    apk_tool() {
        timeout 60 "${sandbox[@]}" "$@"
    }

    badging="$(apk_tool /build-tools/aapt dump badging /input.apk)"
    rg -Fq "package: name='${APP_ID}' versionCode='${VERSION_CODE}' versionName='${VERSION_NAME}'" \
        <<<"$badging" || die "APK package or version mismatch"
    rg -Fxq "sdkVersion:'${EXPECTED_MIN_SDK}'" <<<"$badging" || \
        die "Minimum SDK mismatch"
    rg -Fxq "targetSdkVersion:'${EXPECTED_TARGET_SDK}'" <<<"$badging" || \
        die "Target SDK mismatch"

    actual_permissions="$(apk_tool /build-tools/aapt dump permissions /input.apk \
        | sed -n "s/^uses-permission[^:]*: name='\([^']*\)'.*/\1/p" | sort -u)"
    inspected_permissions="$actual_permissions"
    if [[ "$EXPECTED_APK_PERMISSIONS" == "PENDING_APK_QUALIFICATION" ]]; then
        inspected_permission_match=PENDING
    else
        expected_permissions="$(permission_lines "$EXPECTED_APK_PERMISSIONS" | sort -u)"
        if [[ "$actual_permissions" == "$expected_permissions" ]]; then
            inspected_permission_match=PASS
        else
            inspected_permission_match=FAIL
        fi
    fi

    inspected_cert_sha256="$(apk_tool /build-tools/apksigner verify --print-certs /input.apk \
        | sed -n 's/^Signer #1 certificate SHA-256 digest: //p' \
        | tr '[:upper:]' '[:lower:]')"
    [[ "$inspected_cert_sha256" == "$EXPECTED_SIGNING_CERT_SHA256" ]] || \
        die "Signing certificate mismatch: $inspected_cert_sha256"
    apk_tool /build-tools/zipalign -c -p 4 /input.apk >/dev/null || \
        die "APK ZIP alignment check failed"

    actual_features="$(sed -n \
        "s/^uses-\(implied-\)\{0,1\}feature[^:]*: name='\([^']*\)'.*/\2/p" \
        <<<"$badging" | sort -u)"
    inspected_features="$(paste -sd, <<<"$actual_features")"
    [[ -n "$inspected_features" ]] || inspected_features=NONE
    native_code="$(sed -n 's/^native-code: //p' <<<"$badging" | tr "'" '\n' \
        | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e '/^$/d' | sort -u)"
    inspected_native_code="$(paste -sd, <<<"$native_code")"
    [[ -n "$inspected_native_code" ]] || inspected_native_code=NONE

    manifest_tree="$(apk_tool /build-tools/aapt dump xmltree /input.apk AndroidManifest.xml)"
    inspected_manifest_tree_sha256="$(printf '%s\n' "$manifest_tree" \
        | sha256sum | cut -d' ' -f1)"
    inspected_components="$(rg \
        '^[[:space:]]*E: (activity|activity-alias|service|receiver|provider)( |$)|^[[:space:]]*A: android:(name|exported|permission|authorities)' \
        <<<"$manifest_tree" | sed -n 'l' || true)"
    inspected_manifest_relevant="$(rg \
        '^[[:space:]]*E: (permission|uses-permission|uses-feature|queries|activity|activity-alias|service|receiver|provider|intent-filter|action|category|data)( |$)|^[[:space:]]*A: android:(name|exported|permission|protectionLevel|authorities|grantUriPermissions|scheme|host|mimeType)' \
        <<<"$manifest_tree" | sed -n 'l' || true)"
    if [[ "$EXPECTED_APK_FEATURES" == "PENDING_APK_QUALIFICATION" || \
        "$EXPECTED_APK_NATIVE_CODE" == "PENDING_APK_QUALIFICATION" || \
        "$EXPECTED_APK_MANIFEST_XMLTREE_SHA256" == "PENDING_APK_QUALIFICATION" ]]; then
        inspected_surface_match=PENDING
    elif [[ "$inspected_features" == "$EXPECTED_APK_FEATURES" && \
        "$inspected_native_code" == "$EXPECTED_APK_NATIVE_CODE" && \
        "$inspected_manifest_tree_sha256" == "$EXPECTED_APK_MANIFEST_XMLTREE_SHA256" ]]; then
        inspected_surface_match=PASS
    else
        inspected_surface_match=FAIL
    fi
}

print_apk_surface() {
    local permissions_csv
    permissions_csv="$(paste -sd, <<<"$inspected_permissions")"
    [[ -n "$permissions_csv" ]] || permissions_csv=NONE
    echo "APK_SHA256=$inspected_apk_sha256"
    echo "SIGNING_CERT_SHA256=$inspected_cert_sha256"
    echo "APK_PERMISSIONS=$permissions_csv"
    echo "APK_PERMISSION_EXPECTATION=$inspected_permission_match"
    echo "APK_USES_FEATURES=$inspected_features"
    echo "APK_NATIVE_CODE=$inspected_native_code"
    echo "APK_MANIFEST_XMLTREE_SHA256=$inspected_manifest_tree_sha256"
    echo "APK_BUILT_SURFACE_EXPECTATION=$inspected_surface_match"
    echo "APK_COMPONENT_SURFACE_BEGIN"
    printf '%s\n' "${inspected_components:-(none)}"
    echo "APK_COMPONENT_SURFACE_END"
    echo "APK_MANIFEST_RELEVANT_BEGIN"
    printf '%s\n' "${inspected_manifest_relevant:-(none)}"
    echo "APK_MANIFEST_RELEVANT_END"
}

require_apk_permission_match() {
    [[ "$inspected_permission_match" == PASS && "$inspected_surface_match" == PASS ]] || \
        die "Merged APK permission or built surface does not match the reconciled case record"
}
