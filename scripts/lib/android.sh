#!/usr/bin/env bash
# shellcheck source-path=SCRIPTDIR
# shellcheck disable=SC2153,SC2154

# shellcheck source=common.sh
source "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)/common.sh"

load_android_config() {
    local config_file="$repo_root/.local/config/android.env"
    [[ -f "$config_file" ]] || die "Run ./scripts/init-workspace.sh and review local Android config"
    # Local operator configuration is trusted.
    # shellcheck source=/dev/null
    source "$config_file"

    for name in AVD_NAME AVD_IMAGE_PACKAGE AVD_DEVICE_PROFILE \
        EXPECTED_ANDROID_API EMULATOR_PORT ADB_SERVER_PORT \
        ANDROID_BUILD_TOOLS_VERSION; do
        require_value "$name"
    done
    [[ "$EMULATOR_PORT" =~ ^[0-9]+$ && "$ADB_SERVER_PORT" =~ ^[0-9]+$ ]] || \
        die "Android ports must be numeric"
    ((EMULATOR_PORT >= 5554 && EMULATOR_PORT <= 5682 && EMULATOR_PORT % 2 == 0)) || \
        die "EMULATOR_PORT must be an even console port from 5554 through 5682"

    android_sdk_root="${ANDROID_SDK_ROOT:-${ANDROID_HOME:-}}"
    if [[ -z "$android_sdk_root" ]]; then
        android_sdk_root="$(cd -- "$(dirname -- "$(command -v emulator)")/.." && pwd)"
    fi
    [[ -d "$android_sdk_root" ]] || die "Android SDK root does not exist: $android_sdk_root"

    export ANDROID_SDK_ROOT="$android_sdk_root"
    export ANDROID_HOME="$android_sdk_root"
    export ANDROID_USER_HOME="$repo_root/.local/android/user-home"
    export ANDROID_AVD_HOME="$repo_root/.local/android/avd"
    export ADB_SERVER_PORT
    export ANDROID_ADB_SERVER_PORT="$ADB_SERVER_PORT"
    expected_serial="emulator-$EMULATOR_PORT"
}

prepare_android_directories() {
    mkdir -p -- "$ANDROID_USER_HOME" "$ANDROID_AVD_HOME" "$repo_root/.local/runtime"
}

adb_isolated() {
    adb -P "$ADB_SERVER_PORT" "$@"
}

verify_exact_emulator() {
    local serial_state qemu avd_output avd_name api
    serial_state="$(adb_isolated devices | awk -v serial="$expected_serial" \
        '$1 == serial {print $2}')"
    [[ "$serial_state" == "device" ]] || die "Expected emulator is not ready: $expected_serial"
    qemu="$(adb_isolated -s "$expected_serial" shell getprop ro.kernel.qemu | tr -d '\r')"
    [[ "$qemu" == "1" ]] || die "Target is not an emulator: $expected_serial"
    # Read the complete response before selecting its first line. Piping a
    # multi-line console response through `head` can fail under `pipefail`.
    avd_output="$(adb_isolated -s "$expected_serial" emu avd name | tr -d '\r')"
    avd_name="${avd_output%%$'\n'*}"
    [[ "$avd_name" == "$AVD_NAME" ]] || die "Unexpected AVD: $avd_name"
    api="$(adb_isolated -s "$expected_serial" shell getprop ro.build.version.sdk | tr -d '\r')"
    [[ "$api" == "$EXPECTED_ANDROID_API" ]] || die "Unexpected Android API: $api"
}
