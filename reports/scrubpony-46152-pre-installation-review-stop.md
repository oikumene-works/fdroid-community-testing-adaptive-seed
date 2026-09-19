# ScrubPony MR !46152 Pre-Installation Review Stop

**No functional test was performed. The candidate was not installed or
launched.**

## Independent status

This report is independent community evidence. It is not an F-Droid review or
acceptance decision, a security/privacy audit, a human usability assessment, or
an endorsement by F-Droid or the upstream project.

OpenAI Codex performed the automated source, metadata, public-claim, and APK
checks in an operator-owned local environment under explicit authorization.
The operator approved candidate selection and the initial exact download and
execution window. No emulator UI was reached, so there was no human UI
observation or interaction.

## Exact candidate

- F-Droid data merge request:
  [fdroiddata !46152](https://gitlab.com/fdroid/fdroiddata/-/merge_requests/46152)
- MR head: `db6f218d8930edb6c525beb5b1ffd23dda38b297`
- Pipeline: `2852643977`
- Build job: [`16524511623`](https://gitlab.com/norsehorse/pgponyandroid/-/jobs/16524511623)
- Application/version: `com.norsehorse.scrubpony` `1.3.1` (`5`)
- Upstream source:
  [`69e97ba3cc425b8136ad17ff90fb0b3bf43abf8a`](https://github.com/norsehorse-dev/ScrubPonyAndroid/commit/69e97ba3cc425b8136ad17ff90fb0b3bf43abf8a)
- Annotated tag object: `1e1bf0a1aff79fa45fd03943ec526f54e28aac06`
- APK SHA-256:
  `776228592070574b3f2709cb39e009421900f03628b090be29bdc741f033aa66`
- Signing-certificate SHA-256:
  `89a23cac7936dd0b67a9e91dd944fde540f78eb6b0fb123bad3939987e2b1ee3`
- fdroiddata metadata SHA-256:
  `65b25fcaa4eba33cb11ad32a19a6abe8bebcdaaf12f995997b9f6911be2366c2`
- Source-surface SHA-256:
  `f4f73bab28707748f867c2e40c4ea26b430d600f0b2c3da05fd40fa7e242aaf6`
- Public-claim surface SHA-256:
  `fa791a4acb17791ccf2a8b60503c6ed3a6fbcc0963910f8faa5291b6a7a91d87`
- Claim-review SHA-256:
  `16d0d5a142c2a4e55bd03d031f03f4b9b5ea5fee5206bb9ccde8b9857a98f088`

## Completed review scope

The read-only preflight pinned the exact MR head, pipeline, build job, artifact,
metadata, upstream tag/source mapping, release APK digest, source manifest,
claim files, source navigation surface, and latest reviewed discussion note.
At that snapshot the MR was open and non-draft, its current-head pipeline and
build job were successful, and the artifact answered the availability check.

The separately authorized APK download then matched the pinned SHA-256,
application ID, version, minimum SDK 29, target SDK 34, signing certificate,
`x86_64` native ABI, and ZIP alignment. Host-side diagnosis inspected the
merged manifest after the workflow stopped on the permission-set difference.

## Why the workflow stopped

Two public-claim boundaries require clarification:

1. The exact source manifest declares no permissions. The exact built APK
   defines and uses the package-scoped signature-level permission
   `com.norsehorse.scrubpony.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION`.
   This is not a dangerous or runtime-grantable permission, but it conflicts
   with the README's literal empty-manifest claim. The localized listing's
   user-facing statement that the app asks for no permissions remains
   consistent with the inspected absence of dangerous/runtime permissions.
2. The listing and README state universally that originals are not changed and
   a scrub creates a copy. The exact source also exposes an explicit
   `Replace in place` folder mode that writes a cleaned temporary document,
   deletes the selected original, and renames the replacement.

The first issue caused the approved helper to stop before installation. The
later digest-bound claim review classified the combined state as
`CLARIFICATION_REQUIRED`, which closes candidate download and execution until
public wording or implementation is reconciled at a newly pinned exact head.
This is a pre-installation review stop, not an app test failure.

## Work not performed

The APK was never installed or launched. No first-run UI, image processing,
folder replacement, picker/share flow, output metadata, input preservation,
runtime permission behavior, persistence, localization, performance,
accessibility, crash/ANR state, or runtime network behavior was tested.

The static absence of `INTERNET` and dangerous permissions is not presented as
proof of general privacy or security behavior.

## Timeline and known durations

- `2026-09-18T20:35:26Z` — Codex began read-only candidate research.
- `2026-09-18T20:43:08Z` — candidate recommendation completed after 7 minutes
  42 seconds of active research.
- `2026-09-18T20:47:06Z` — the operator approved selection after 3 minutes
  58 seconds of operator waiting.
- `2026-09-18T20:47:33Z` to `20:52:30Z` — exact read-only preflight completed
  in 4 minutes 57 seconds.
- `2026-09-18T21:06:36Z` — the operator approved the exact download and
  visible-emulator execution window.
- `2026-09-18T21:06:53Z` — the immediate live recheck passed.
- `2026-09-18T21:07:20Z` — the helper stopped before installation on the APK
  permission-set difference.
- `2026-09-18T21:07:55Z` — diagnostic inspection confirmed the merged
  signature permission; all other recorded APK identity checks matched.
- `2026-09-18T21:08:26Z` — APK deletion and local-state cleanup were verified.
  The authorized slice lasted 1 minute 50 seconds with no waiting interval.
- `2026-09-18T21:11:47Z` — permission expectations were reconciled after 37
  seconds of active correction and recheck.
- `2026-09-18T21:36:22Z` — digest-bound claim review and guard hardening
  completed with status `CLARIFICATION_REQUIRED`.
- `2026-09-18T21:52:38Z` — this sanitized public report draft was started.
- `2026-09-18T21:57:37Z` — the first complete local public-tree and report
  audit passed offline; nothing was published.

Only phase durations supported by the recorded lifecycle are reported; no
unrecorded active-work total is inferred.

## Cleanup and external state

The downloaded APK and diagnostic copy were deleted. No fixture or raw APK
evidence remains. The project emulator and isolated ADB server were never
started for this case, so the candidate never reached an Android device. No APK
or evidence was uploaded externally, and no GitLab comment or other external
mutation was made for this case.

## Resolution path

A future preflight can begin only from a changed exact MR/source state whose
public wording scopes the copy claim around the optional replace-in-place mode
and accurately distinguishes source-manifest permissions from the merged APK's
package-scoped signature permission. The changed claim surface, source, built
APK, and all exact identifiers would need fresh review and qualification.

This report does not recommend an F-Droid merge outcome.
