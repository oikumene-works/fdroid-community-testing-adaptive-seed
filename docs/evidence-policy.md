# Evidence Policy

## Durable evidence

Keep only the minimum public facts needed to reproduce and interpret a report:

- exact public repository, MR, pipeline, job, tag, source, version, and digest
  identifiers;
- claim-review and source-surface digests;
- sanitized environment identity and bounded checklist results;
- unsupported, inconclusive, or stopped work;
- machine-generated UTC milestones and separate phase durations; and
- uninstall, wipe, stop, deletion, upload, and public-mutation state.

## Transient evidence

APKs and parser input belong under `.local/downloads/`. Put case fixtures,
outputs, and raw journals under `.local/cases/CASE_ID/`; transient screenshots
and UI dumps belong under `.local/evidence/CASE_ID/`. Emulator state remains
under `.local/android/`. Delete case material at the end of APK qualification
or verified execution cleanup.

Do not retain credentials, access tokens, signed artifact URLs, private files,
personal data, workstation paths, temporary emulator serials, or unrelated app
state. Never commit an executable Android package or private evidence.

Offline checks and the fictional dry run may create and remove bounded fixtures
under ignored `.local/`. They are externally read-only, not byte-for-byte local
no-ops. Fixture cleanup is part of the test result.

## Observation and inference

Report what a check showed and identify any inference. Static source review does
not become a runtime result. No network permission does not prove all privacy
claims. Operator observation without operator interaction is not a human
usability test.
