# Starter-Kit-to-Seed Migration Plan

## Status and boundary

This plan classifies the published kit and tracks bounded local growth while
leaving the published starter-kit project unchanged. This independent local
seed project preserves exact published commit
`5a54da63a58b22c8715778a31931394769b60d72` in its ancestry and is now public as
a separate repository. Publication creates no authority for later mutations or
for modifying the original project.

The completed slices provide read-only discovery, one ignored profile, and an
exactly guarded offline-verification wrapper. They do not install anything, use
the network, start Android tooling, or migrate an operational workflow script.

## Responsibility map

| Current responsibility | Seed layer | Initial treatment |
| --- | --- | --- |
| Non-affiliation, untrusted-input rules, exact pins, approvals, target checks, cleanup, and evidence limits | Invariant kernel | Preserve and centralize without weakening |
| `session-bootstrap.sh` and read-only portions of `doctor.sh` | Discovery | Form the evidence base for the first `grow` prototype |
| `config/android.env.example` and `.local/config/android.env` | Local profile | Separate portable defaults from discovered and user-selected local facts |
| Linux, GNU tools, Bubblewrap, SDK, KVM, display, and AVD assumptions | Reference lane | Keep as the first verified lane rather than universal seed assumptions |
| GitHub upstream and GitLab F-Droid logic | Reference-lane adapters | Keep both working; do not generalize providers before a real need |
| Case templates, claim review, qualification, activation, execution, cleanup, and reporting | Guarded workflow module | Preserve the proven sequence behind an explicit lane choice |
| Fictional case and denial tests | Verification | Retain as the first clean-path and refusal-path proof |
| Completed public reports | Public examples | Preserve as evidence, not reusable local profile data |
| Posting and recovery helpers | Optional approved capability | Never enable merely because credentials or clients are discoverable |

## Migration principles

1. Extract boundaries before moving files.
2. Keep the published reference path runnable throughout local development.
3. Do not introduce a generic adapter framework until a second real adapter
   proves which interface is shared.
4. Keep discovered facts and user choices ignored-local by default.
5. Require behavior-based tests for a clean first run and one adapted path.
6. Preserve every external and executable approval boundary during migration.
7. Prefer a reversible wrapper around proven scripts before rewriting them.

## Bounded implementation sequence

### Slice 0: public-ready design record

Deliver:

- the growth contract;
- the evidence-based evolution record;
- this responsibility map; and
- a handoff that names the next unapproved action.

Stop before adding or changing executable behavior. This was the initial slice.

Status: complete. The design record passed the existing offline checks before
the first executable seed slice began.

### Slice 1: read-only growth prototype

Implement one entry point that:

- reads no credentials;
- uses no network;
- changes no files;
- classifies selected capabilities as `READY`, `MISSING`, `UNSUPPORTED`, or
  `UNKNOWN`;
- proposes one compatible local growth slice; and
- stops before applying it.

Test a clean reference host, a host missing one required reference component,
and a user override that does not broaden authority.

Status: complete for the bounded prototype. Tests cover the current host, a
missing-tool environment, an unsupported host, a rejected `--apply` override,
and an invalid command. Clean newcomer evaluation remains Slice 4.

### Slice 2: ignored local profile

After separate review, allow one exact proposal to create a documented
ignored-local profile. Show the planned fields before writing, preserve a
different existing profile, and verify that no workstation path or credential
reaches tracked source.

Stop after profile validation. Do not install tools or start Android tooling.

Status: complete. Preview is read-only. Apply requires the exact technical guard
`create-profile:linux-reference`, writes one mode-`600` ignored file atomically,
treats an identical profile as unchanged, and refuses a different file or
symlink boundary. The design worktree verified that path. Its machine-specific
profile was excluded from this independent project.

### Slice 3: connect the existing reference lane

Use the selected profile to run existing offline checks and the fictional dry
run. Prefer thin orchestration around the proven scripts. Keep executable APK,
emulator, ADB, upload, and posting gates closed.

Status: complete. Preview names both commands and their effects. Execution
requires `verify-offline:linux-reference`, stops after the first failure, and
checks that the exact current profile and Git worktree state remain unchanged.
The real local run passed both commands without network or Android action.

### Slice 4: clean newcomer evaluation

Give a context-free user or agent only the repository and the instruction
`Grow this seed`. Record activation, discovered facts, choices, effects,
confusions, and stop behavior. Publish the prompt, result, corrections, and
limitations without private state.

Status: complete. A fresh read-only agent run received only the repository and
`Grow this seed`. It ran discovery, made no change, proposed profile preview,
and stopped for a choice. The evaluation and corrections are recorded in
`docs/seed-newcomer-evaluation.md`.

### Slice 5: distribution decision

Only after the local path passes should the operator decide whether the seed
replaces public `main`, becomes a separately versioned line, or becomes a new
project. A local design branch does not predetermine that choice.

Status: complete as a relationship decision. The seed will not replace or
deprecate the original starter kit. The original remains independently usable
and comparable. The seed is intended to become a separately named sibling
project with explicit provenance; no repository, remote, or publication was
created by this decision.

### Local sibling creation checkpoint

Create a separately named local repository while retaining the exact starter-kit
ancestry and excluding ignored machine state. Validate it, make one local seed
commit, and stop without a remote or publication.

Status: complete when the initial commit and clean-worktree checks pass. This
checkpoint grants no authority to choose a public host, create a remote, push,
tag, release, or change the original project.

### Publication checkpoint

Audit the local source and history, propose the public identity and metadata,
link the exact original project and derivation commit, and define an exact later
mutation and recovery boundary.

Status: complete. `docs/publication-plan.md` records the approved commit,
mutation sequence, verification, and retrospective. Publication created no tag,
release, or modification to the original starter kit.

## Deliberately parked possibilities

The following are not part of the first implementation:

- macOS, Windows, WSL execution, containers, or cloud-hosted emulators;
- headless Android execution;
- upstream providers other than GitHub or F-Droid targets other than GitLab;
- network-capable, sensitive-permission, account, payment, or special-hardware
  cases;
- automatic package installation or SDK license acceptance;
- credential brokers or automatic publication;
- a general plugin marketplace or self-modifying module system; and
- migration of every current script before the first `grow` path is evaluated.

Each parked item adds context, testing, maintenance, or approval boundaries. A
real user and a bounded verified path are required before implementation.

## Promotion rule

A local adaptation becomes portable source only when:

- a real repeated need is recorded;
- the portable invariant is clear;
- environment-specific state can remain local;
- positive, negative, boundary, and authority tests exist;
- maintenance and approval ownership are explicit; and
- the operator deliberately approves the promotion and any publication.

## Next decision after initial publication

Review the local post-publication record commit. A later approval must bind its
exact clean commit and destination before any push. No executable APK, emulator,
ADB, network, credential, further external mutation, push, branch publication,
tag, release, or metadata change is authorized by this plan.
