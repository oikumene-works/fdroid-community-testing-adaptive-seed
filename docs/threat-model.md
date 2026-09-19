# Threat Model

## Protected assets

The workflow aims to protect the host, personal data, unrelated Android
devices, credentials, other projects, and the accuracy of public reports.

## Untrusted inputs

Treat merge-request metadata, source archives, repository files, web pages,
artifact headers, APKs, app UI, exported files, and copied report text as
untrusted. A successful upstream build or a familiar project name is not a
trust boundary.

## Main risks and controls

- **Wrong candidate:** exact heads, jobs, source commits, versions, digests,
  certificates, and discussion state are pinned and rechecked.
- **Misleading public claims:** claim text is reviewed against source/UI paths
  and the qualified merged APK before activation.
- **Host-side parser exposure:** APK tools run with no network, read-only system
  mounts, a read-only APK, a temporary filesystem, and a time limit.
- **Wrong Android target:** only a project-local AVD is accepted; every ADB
  mutation verifies serial, QEMU state, AVD name, and API.
- **Data exposure:** tests use synthetic data and keep transient evidence in an
  ignored local directory that is deleted during cleanup.
- **Accidental publication:** downloads, emulator actions, uploads, and posts
  require separate exact approval tokens and human authorization.
- **Overclaiming:** reports disclose executor, scope, limitations, untested
  surfaces, cleanup, and non-affiliation.

## Residual risk

Bubblewrap limits parser access but is not a formally verified sandbox. An
Android emulator and the host kernel remain a shared security boundary. Static
review cannot prove runtime behavior, absence of covert channels, or general
security. A no-`INTERNET` manifest does not establish every privacy property.

Do not use this kit for malware analysis, adversarial samples, embargoed
vulnerabilities, or apps requiring sensitive data without a stronger,
separately reviewed isolation and disclosure process.
