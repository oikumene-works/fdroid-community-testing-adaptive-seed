# Built-APK qualification — Battleship 1.0.12

PASS after Codex reviewed the newly observed merged surface. No runtime result.
The operator's bounded verification instruction covers this qualification;
it ran from clean a48e9f7938d2243e47fb8f2fe85fef179776e4ca on 2026-09-22.
Stock live recheck passed all exact pins and artifact HEAD returned 200.
Helper start marker 06:16:21Z; journal final write 06:16:34.723Z (about 14 seconds,
including recheck/download/parsing/deletion; active/wait time not separated).
An independent file inventory then found no file under .local/downloads.

## Binary evidence

- Package com.cocode.battleship; version 1.0.12 / 1000012; minimum/target SDK 24/36.
- APK SHA-256: 8109f17500a1d8ab69fb717355b10b69ced22920c92e5114d4fbdd86a5ecc6ba.
- Verified signing certificate SHA-256:
  6120b56d569c8ccb013f5fa08dd08790194ba2c390fa97e12e0eb36ef1599e21.
- Signature verification and ZIP alignment passed in the stock no-network,
  read-only Bubblewrap parser sandbox with build tools 36.0.0.
- Requested permissions: android.permission.VIBRATE and
  com.cocode.battleship.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION.
- Features: NONE. Native ABIs: arm64-v8a,armeabi-v7a,x86,x86_64.
- Normalized manifest tree SHA-256:
  72f8c897bde6c849536effc715c267b6a67e1fd909b6b1490cfc48a06ff2d020.

## Reconciliation

The helper returned RECONCILIATION_REQUIRED because built expectations were
pending. The explicit review here sets PASS; it was not inherited from 1.0.11.
MainActivity is exported for MAIN/LAUNCHER. The app-scoped dynamic-receiver
permission is signature protected (protectionLevel 0x2), not a dangerous or
network permission. AndroidX startup provider is non-exported with app-scoped
authority and EmojiCompat, ProcessLifecycle and ProfileInstaller initializers.
ProfileInstallReceiver is exported but caller-guarded by android.permission.DUMP;
its install/skip/save/benchmark actions are excluded from our UI test. DUMP is
not requested by the app. Window extension/sidecar library declarations remain.
No additional activity, service, network/sensitive requested permission,
document/share intent or URI grant was found in the inspected merged surface.

These are the same bounded component patterns reconciled in the previous case's
qualification.md, freshly observed here. The manifest digest is new; exact byte
identity to the old manifest is not claimed. Native ABIs include the selected
x86_64 image. Individual native-code behavior and reproducible building were
not independently audited. No sandbox-escape test was performed.

The safe synthetic offline scope remains unchanged, with product findings open.
The downloaded APK was removed by the helper. Temporary review/qualification
journals remain only under ignored case storage until execution cleanup.
No AVD, emulator, ADB command, installation, upload, push or posting occurred
in this qualification slice. Next: clean qualified checkpoint, then activation
and the already-authorized bounded runtime/cleanup slice.
