# Platform Limits

The supported reference host is Linux with Bash, Bubblewrap, a graphical
Android emulator, and the Android SDK command-line tools. Scripts assume GNU
userland behavior in several places.

macOS and Windows are not supported by the initial release. WSL may run the
offline checks, but graphical emulator, KVM, USB/device discovery, networking,
and filesystem semantics need a separately tested profile.

The reference AVD is AOSP Android 14/API 34, x86_64, Pixel 7 profile, with
snapshots disabled. Apps requiring another ABI, Google Play services, special
hardware, device-owner privileges, telephony, biometric enrollment, or a
physical-device-only feature are outside the default lane.

The initial lane excludes apps declaring `INTERNET` or sensitive permissions.
The repository contains no traffic-capture, TLS interception, malware-analysis,
or coordinated-vulnerability-disclosure workflow.

GitHub is the implemented upstream source adapter and GitLab is the implemented
F-Droid merge-request adapter. Other providers require a reviewed adapter; do
not substitute scraped or approximate identifiers.
