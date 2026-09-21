# Real-Case Growth Evaluation: Profile-Bearing Offline Verification

## Status and question

On 2026-09-21, a bounded integration evaluation asked whether a fresh public
copy could grow from the newcomer request into the existing offline
verification path before any candidate, executable, or Android action.

The evaluation produced a material `FAIL` at public commit
`ff45f27b0d47991ebb5bf8e1382df4a468375237`. The failure was corrected in
commit `bb9bef6d3bd90b64e243daf5bad0ec953833074f`, which passed an isolated
profile-bearing rerun. This is integration evidence from a familiar operator
and Codex, not newcomer or human-comprehension evidence.

## Frozen evaluated path

The initial subject was a fresh clone of the public repository at exact commit
`ff45f27b0d47991ebb5bf8e1382df4a468375237`. The choices were made one at a
time:

1. request `Grow this seed`;
2. preview the proposed ignored local profile;
3. create that exact profile;
4. continue growth;
5. preview the proposed offline verification; and
6. authorize that exact offline verification.

The profile was created as ignored local state with mode `600`. It selected the
existing Linux reference lane and recorded the discovered Android SDK root.
No machine-specific path from the profile is retained in this public record.

## Observed failure

The wrapper started the repository checks and stopped before the fictional dry
run because `tests/seed-grow-tests.sh` failed with this unmet expectation:

```text
Seed output did not contain:
PROPOSED_STEP=Preview an ignored local profile for the existing Linux reference lane.
OFFLINE_VERIFY_STATUS=CHECKS_FAILED
```

The failed run did not select a candidate, download an APK, start an emulator
or ADB server, use a credential, access the network, or mutate an external
service. The stop-on-first-failure boundary worked as intended.

## Direct cause

The growth test invoked `./seed grow` in the live repository root and assumed
that no local profile existed. That assumption was true in ordinary clean CI
but false in the required integration state: offline verification is available
only after the exact ignored profile exists. In that state, the correct next
proposal is offline verification rather than profile preview.

The failure was therefore in test isolation, not in the seed's adaptation to
the exact profile. The test made an uncontrolled ignored-local state part of an
exact output expectation.

## Smallest correction

Commit `bb9bef6d3bd90b64e243daf5bad0ec953833074f` changes only the growth test:

- the live-root check still verifies read-only state preservation and the
  generic proposal contract, but no longer assumes one exact profile state;
- the exact absent-profile proposal is asserted in the existing controlled
  test repository before the profile is created; and
- the existing controlled cases continue to cover exact, absent, conflicting,
  and failed profile states.

No runtime growth behavior, authority boundary, network behavior, or
community-testing gate changed.

## Corrected evaluation

The complete repository check suite passed after the correction. A second,
isolated local clone at exact commit
`bb9bef6d3bd90b64e243daf5bad0ec953833074f` then:

1. created the exact ignored profile through the guarded seed interface;
2. ran the real `--verify-offline` wrapper with its exact technical guard;
3. passed the complete repository check suite;
4. passed the fictional dry run;
5. preserved the profile byte for byte; and
6. preserved the Git worktree state.

The final observable result was:

```text
PROFILE_PRESERVED=YES
GIT_WORKTREE_PRESERVED=YES
OFFLINE_VERIFY_STATUS=PASS
```

The corrected rerun also performed no network, APK, emulator, ADB, credential,
upload, or external mutation.

## Evidence limits and next gate

The first failure remains evidence against public commit `ff45f27`; the
corrected rerun does not erase it. The rerun proves the corrected commit in an
isolated local Git clone, not acquisition from the corrected public remote.
No raw private transcript, machine path, local profile, or generated test
artifact is retained.

A useful follow-up is one new public-acquisition run after the correction is
separately approved and published. It should begin from a fresh clone of the
new public commit and may proceed only to the same read-only offline
verification boundary. Candidate selection and every executable, Android, or
external effect remain outside that evaluation unless separately authorized.
