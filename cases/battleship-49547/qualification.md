# Built-APK qualification

Status: PASS after manual reconciliation. No activation or runtime test.
TEST_SAFETY_STATUS remains PASS; CLAIM_REVIEW_STATUS remains FINDINGS_RECORDED.

## Authority and exact execution

On 2026-09-22 the operator explicitly authorized a fresh exact-state recheck
and, if eligible, download of the recorded APK, seed qualification and deletion.
Android start, application installation and publication were explicitly excluded.
The stock helper ran from clean committed HEAD
`29be0405a1883c107233325d182c7cca4d0912d1` with the exact case guard.

Both the preliminary recheck and the helper's immediate recheck passed. MR head
`f2577e78cab813fde78b11d16b7c7b05dd88ea69`, pipeline `2867295579`, build job
`16624306623`, metadata, upstream tag/source/release digest, source and public
claim surfaces, labels and latest non-system note matched case.env. APK HEAD
returned HTTP 200; artifact expiry was 2026-10-21T10:45:26.817Z.
Only the exact CODE_QUALITY_APK_URL in case.env was downloaded, once.

The helper ran approximately 2026-09-22T02:54:05.715Z–02:54:18.199Z (12.484 s),
from the transient journal's filesystem birth and final modification timestamps.
This interval includes its live recheck, download, parsers and deletion. Those
subphases and active/waiting review time were not separately instrumented.
An independent directory inspection at 02:54:32Z found no downloaded file.

## Locally verified binary facts

| Check | Observed result |
| --- | --- |
| APK SHA-256 | `27c558552dc9cbd00fbb34c619aab72dbc21bd870d68a48f4cc4bc9f7b32a0d9` |
| Package / version | `com.cocode.battleship` / `1.0.11` / `1000011` |
| Minimum / target SDK | 24 / 36 |
| Verified signer certificate SHA-256 | `6120b56d569c8ccb013f5fa08dd08790194ba2c390fa97e12e0eb36ef1599e21` |
| ZIP alignment | `zipalign -c -p 4` passed |
| Requested permissions | `android.permission.VIBRATE`, `com.cocode.battleship.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION` |
| Reported uses-features | NONE |
| Native ABIs | `arm64-v8a,armeabi-v7a,x86,x86_64` |
| Normalized manifest-tree SHA-256 | `4e92601eaa64a8d9b91b648a093d910e31962ddc67142f090011961ae63b72c1` |

The signer verifier completed successfully; this is more than reading a
certificate label. The APK digest equals the pinned release asset expectation.
This is not an independent rebuild or proof of all executable behavior.

## Merged-surface reconciliation

The helper correctly returned RECONCILIATION_REQUIRED with pending expectations;
PASS is the subsequent documented review decision, not its automatic output.
The original app manifest is not the complete merged manifest:

- MainActivity is exported with MAIN/LAUNCHER, as expected.
- The app-scoped dynamic-receiver permission is declared with protectionLevel
  0x2 (signature) and requested by the app. This matches the pattern in the
  [AndroidX Core manifest](https://raw.githubusercontent.com/androidx/androidx/androidx-main/core/core/src/main/AndroidManifest.xml).
  [Android permission documentation](https://developer.android.com/guide/topics/manifest/permission-element)
  explains the same-certificate boundary. This is not a dangerous user-data
  permission or an INTERNET permission.
- androidx.startup.InitializationProvider has exported=false and authority
  com.cocode.battleship.androidx-startup. Its metadata names EmojiCompatInitializer,
  ProcessLifecycleInitializer and ProfileInstallerInitializer. The observed
  non-exported surface matches the documented
  [App Startup pattern](https://developer.android.com/topic/libraries/app-startup).
- androidx.profileinstaller.ProfileInstallReceiver is exported, guarded by
  android.permission.DUMP. Its four actions are INSTALL_PROFILE, SKIP_FILE,
  SAVE_PROFILE and BENCHMARK_OPERATION under androidx.profileinstaller.action.
  [AndroidX documentation](https://developer.android.com/reference/androidx/profileinstaller/ProfileInstallReceiver)
  describes this tool-facing receiver and its DUMP guard. DUMP is a caller
  restriction here, not a permission requested by Battleship. Do not invoke
  these tooling actions in the synthetic game checklist.
- The reported surface contains no service, additional activity, document/share
  intent, URL scheme/host, queries element or URI-grant declaration. Window
  extension/sidecar library names also appear. No network or dangerous requested
  permission was observed.
- The four native ABIs include the intended x86_64 lane. Presence of native
  code was previously unknown, not asserted absent. Individual native libraries,
  their provenance and runtime compatibility were not audited by this helper.

The pinned Gradle files declare AndroidX Core 1.18.0, Activity/Compose, Lifecycle
and Navigation. The additions are consistent with that dependency family.
Current official documentation/source supports interpretation of the observed
manifest controls; it does not independently attest the exact dependency bytes.
No unresolved identity or manifest-access conflict was found within this bounded
qualification. The same synthetic offline scope remains applicable. Earlier
source-only game-mode, placement, backup and documentation findings remain open.

## Environment, cleanup and limits

Existing Linux tools sufficed: Android build tools 36.0.0 and Bubblewrap 0.11.1.
All APK parsers used the stock Bubblewrap --unshare-all boundary, read-only system,
build-tools and input mounts, and ephemeral /tmp. A preliminary sandbox launch
and the actual parser calls succeeded. No adversarial sandbox-escape test or
independent network-isolation audit was performed.

The observed missing prerequisite was a local build-tools selection. Only
`.local/config/android.env` was added, mode 600, containing
ANDROID_BUILD_TOOLS_VERSION=36.0.0 and an explanatory comment. It is deliberately
incomplete for Android execution. The existing mode-600 seed profile is retained.
No shared state/profile was copied, SDK component installed, license accepted,
AVD created or portable seed code changed.

The helper removed its APK. The temporary case journal was removed after these
sanitized facts were recorded. No raw source/API/build trace, APK, fixture,
emulator or isolated ADB session remains for this case. Reference case ports
were unbound; unrelated host ADB processes were not targeted. No emulator or ADB command,
installation, activation, upload, posting or push occurred. The only historical
external mutation remains upstream issue #55.

All functional checklist items remain Not tested, including launch, gameplay,
audio/haptics, persistence, permission enforcement, backup/restore and crash/ANR
behavior. Device cleanup is also untested because no device state was created.
Qualification PASS is a bounded static checkpoint, not a product/security verdict.
