# Built-APK Qualification

**Status: NOT STARTED — BUILT SURFACE PENDING**

## Exact candidate

Record the MR head, build job, APK URL, expected and observed APK SHA-256,
application ID, version name/code, SDK bounds, signing-certificate SHA-256,
source permission set, and initially pending built-APK fields.

## Qualification observations

Record each host-side parser result and whether Bubblewrap confinement, timeout,
certificate verification, and ZIP alignment checks completed. Include observed
permissions, features, native code, normalized manifest-tree digest, components,
and relevant manifest lines. Reconcile them against source and public claims;
do not copy an unexpected surface blindly into a passing record.

## Cleanup checkpoint

Record machine-generated UTC start and completion, operator approval, APK
deletion, temporary-directory deletion, upload state, and that no emulator or
ADB action occurred. The helper's pending-state result is
`RECONCILIATION_REQUIRED`. Set this record to `PASS` only after exact
reconciliation, case-field replacement, and clean verification.
