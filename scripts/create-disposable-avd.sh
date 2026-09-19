#!/usr/bin/env bash
set -euo pipefail
# shellcheck source-path=SCRIPTDIR
# shellcheck disable=SC2154

# shellcheck source=lib/android.sh
source "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)/lib/android.sh"
cd -- "$repo_root"

require_tools emulator avdmanager
load_android_config
prepare_android_directories
image_path="$ANDROID_SDK_ROOT/${AVD_IMAGE_PACKAGE//;/\/}"

if emulator -list-avds | rg -Fxq "$AVD_NAME"; then
    echo "Project-local AVD already exists: $AVD_NAME"
    exit 0
fi
[[ -d "$image_path" ]] || die "Installed AOSP image is missing: $image_path"

printf 'no\n' | avdmanager create avd --name "$AVD_NAME" \
    --package "$AVD_IMAGE_PACKAGE" --device "$AVD_DEVICE_PROFILE"
echo "Created project-local AVD: $AVD_NAME"
echo "This script did not download an image, start ADB, or boot the emulator."
