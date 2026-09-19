# Candidate Case

## Gate state

- [ ] Selection complete
- [ ] Exact source and claim preflight complete
- [ ] Built-APK qualification complete
- [ ] Exact execution and verified cleanup complete
- [ ] Exact report reviewed and approved
- [ ] Exact public comment separately approved and posted

## Exact candidate

Record the MR, head, source project, pipeline, build job, artifact expiry and
URL, application ID, version, upstream tag/source mapping, metadata digest, APK
digest, certificate digest, and latest reviewed non-system note.

## Static surface

Record separate source and built-APK permission sets, SDK bounds, dependencies,
exported components, features, native code, normalized built-manifest digest,
external navigation, share/document-provider surfaces, and suitability for the
initial no-network lane. Built fields remain pending until qualification.

## Public claim review

Link `claims.md`, record its digest and status, and summarize every material
claim inconsistent with source, UI paths, or the qualified merged APK.

## Intended functional test

List synthetic inputs, each advertised main function, permission-denial and
cancellation cases, environment identity, operator role, stop conditions,
cleanup checks, and estimated uninterrupted duration.

## Qualification result

Link the digest-bound `qualification.md`. Do not request emulator approval
until qualification passed, its APK was deleted, and the checkpoint is clean.

## Execution result

Record only observed results. A stop before installation is not a functional
test failure or completion.

## Timeline and cleanup

Record sanitized UTC milestones, actors, active/waiting phase durations,
uninstall, wipe verification, emulator/ADB stop, artifact deletion, upload
state, and every external mutation or its absence.
