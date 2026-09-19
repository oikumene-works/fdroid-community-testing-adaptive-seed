# Design Rationale

## Exact-state evidence

Merge requests, artifacts, tags, and public descriptions change independently.
The workflow therefore binds observations to one MR head, pipeline, build job,
upstream source, version, APK digest, certificate, and claim surface. A useful
report says what was tested, not merely which app was named.

## Separate approval boundaries

Read-only research has a different risk profile from downloading an executable,
starting a device bridge, installing an APK, uploading evidence, or posting a
public comment. Tokens make accidental command execution harder, while human
approval remains the actual authorization.

## Qualification before execution

A source manifest is not the merged manifest. Libraries and build tooling can
add components and permissions. The download-inspect-delete checkpoint makes
the built surface reviewable before emulator approval is requested.

## Disposable local Android state

The AVD home and ADB server port live under the project instead of a personal
Android profile. Fixed configuration plus repeated runtime verification reduces
the chance of mutating the wrong device. A wipe is verified rather than merely
requested.

## Minimal durable evidence

Raw logs and screenshots increase privacy and secret-retention risk. Durable
reports keep exact public identifiers, hashes, environment class, bounded
observations, timestamps, and cleanup facts. Git history can then archive the
sanitized record without archiving executables or device state.
