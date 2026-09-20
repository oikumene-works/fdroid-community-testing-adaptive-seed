# Adaptive Seed Design

## Status

This document defines an independent adaptive alternative to the published
guarded starter kit. This seed project can discover, propose, create one ignored profile,
and run the existing offline checks after exact approval. Existing operational
gates and action scripts retain their published behavior.

The seed must preserve the current safety boundaries while making the first
experience simple enough for a newcomer with no project history.

## First user story

A newcomer obtains the repository, opens it with a repository-aware agent, and
says:

> Grow this seed.

The terminal entry point exposes the same contract:

```sh
./seed grow
```

Both interfaces must follow one growth protocol. Natural language must not
weaken the command-line safety or authority model.

## Current slice contract

- **Present need:** derive, beside a fixed reference kit, a small beginning that
  can explain and adapt to its local environment.
- **Smallest useful outcome:** truthful discovery, one ignored profile, and
  guarded use of existing offline verification without installation, network
  access, Android mutation, or external mutation.
- **Stop condition:** the local reference lane passes the repository checks and
  fictional dry run. No candidate-handling or Android action behavior is
  changed.

## Growth protocol

Growth is a controlled state transition, not autonomous self-expansion.

| State | Result | Authority and effect |
| --- | --- | --- |
| Discover | Inspect local tools, constraints, and existing state | Read-only; grants no authority |
| Report | Classify every relevant finding | Read-only; no hidden fallback |
| Propose | Name one smallest useful growth slice | No change; disclose effects and stop condition |
| Approve | Bind the operator's choice to that exact slice | Human decision; not a script token |
| Apply | Make only the approved local changes | Never implies executable or external authority |
| Verify | Test the clean path and one adapted path | Report failures and unknowns truthfully |
| Record | Keep portable decisions tracked and machine facts local | No credentials or private evidence |
| Stop | State what is ready and what still needs approval | Do not continue into another slice |

The current implementation reaches **Verify** only for the selected offline
reference lane. Every later effect or authority boundary still requires a new
slice and decision.

## Communication contract

The seed should make few requests, but each request must correspond to a real
human decision.

- Ask no question before safe read-only discovery.
- Do not ask the grower for a fact the seed can inspect locally.
- Present one recommended slice, its effects, its stop condition, and at most
  three choices: approve it for a later slice, request details, or stop.
- Ask again whenever a later action crosses a new local-write, installation,
  network, executable, Android, credential, or external-mutation boundary.
- Do not carry authority from one growth slice into another.
- Report progress without narrating every command; explain the evidence behind
  `UNKNOWN`, `UNSUPPORTED`, or a blocked proposal.
- End each applied slice with what changed, what was verified, and what still
  requires a decision.

The ideal first cycle is one grower request, one seed proposal, one grower
choice, and one completion report. Learned communication preferences may reduce
repetition, but they never reduce approval boundaries.

## First local write boundary

The first adapted path uses an exact preview before one ignored-local write:

```sh
./seed grow --preview-profile
./seed grow --apply-profile --approval create-profile:linux-reference
```

Apply may create only `.local/seed/profile.env`. It records the selected
reference lane, the local SDK-root choice, and the portable Android config it
will use later. It records no credential or authority. The technical guard does
not replace human approval. An identical reapply is a no-op; a different file,
non-file target, or symlink boundary is a conflict and is never overwritten.
An exact existing profile advances the next proposal to offline verification.

Offline verification has its own preview and exact guard. It runs only
`scripts/check-all.sh` followed by `scripts/fictional-dry-run.sh`, stops on the
first failure, and verifies that the profile and Git worktree were preserved.

## Truthful discovery states

Every discovered capability must use one of four meanings:

- `READY`: the specific supported check passed.
- `MISSING`: the capability was checked and was not found.
- `UNSUPPORTED`: the capability exists or was requested, but this seed has no
  reviewed path for it.
- `UNKNOWN`: available evidence is insufficient to make a stronger claim.

Finding a command on `PATH` does not prove that it works. A ready environment
does not authorize a download, emulator start, ADB command, upload, or post.

## Seed layers

### Invariant kernel

The following must remain portable and must not be weakened by adaptation:

- independent community evidence never becomes an F-Droid decision;
- third-party source, APKs, pages, metadata, and copied text are untrusted;
- exact-state pinning and live rechecks precede executable work;
- human authorization, an approved operational slice, case activation, and a
  technical approval token remain distinct;
- physical devices, personal profiles, credentials, and personal data are out
  of bounds;
- every Android mutation targets one verified disposable emulator;
- executable work includes verified cleanup in the same bounded slice;
- public posting is separate from testing and report approval; and
- learning a capability or preference never grants authority to use it.

### Discovery

The seed may inspect, without changing:

- host operating system and shell behavior;
- required and optional command availability and versions;
- Android SDK roots, installed components, and unresolved SDK state;
- KVM and graphical-display readiness;
- Git state and configured remotes;
- supported source and merge-request adapters; and
- existing ignored-local profile and runtime state.

Discovery must explain which check supports each status. It must not install a
package, accept a license, start Android tooling, contact a service, or create a
profile.

### Local profile

After a later explicit choice, ignored local state may hold:

- resolved SDK paths and reviewed package selections;
- the selected reference lane and adapter choices;
- project-local AVD, port, and display configuration;
- locally accepted tool variants; and
- decisions that are useful on this machine but not portable policy.

It must never retain credentials, access tokens, transient signed URLs, private
evidence, or inferred permissions.

### Optional growth

Only observed needs may justify later support for another host, provider,
emulator mode, permission class, evidence mechanism, or publication path. Each
addition needs a named user, a tested path, a maintenance owner, and its own
authority boundary.

## First reference lane

The seed is not empty. Its first verified lane is the current published path:

- Linux with GNU userland assumptions;
- Bubblewrap for bounded host-side APK parsing;
- Android SDK with a visible KVM-backed project-local emulator;
- GitLab for the F-Droid merge request and GitHub for upstream source; and
- new-app candidates without `INTERNET` or sensitive permissions.

Other environments are not rejected forever. They remain `UNSUPPORTED` or
`UNKNOWN` until a real need and a verified adapter exist.

## Draft newcomer response

A first run should be able to produce an answer shaped like this:

```text
SEED_STATUS=GROWTH_PROPOSAL

Ready: local Git workspace, Bash, Git, KVM
Missing: Bubblewrap
Unsupported: network-capable candidate lane
Unknown: Android SDK package compatibility

Proposed slice: create an ignored local profile for the existing Linux lane.
Effects: local files only; no downloads, Android actions, or external changes.
Stop: profile validated and next missing prerequisite reported.
```

The wording may change after evaluation. The distinctions and stop boundary may
not.

## Explicit non-goals

The first seed version will not:

- support every host, provider, package manager, or Android configuration;
- silently install dependencies or accept licenses;
- make credentials discoverable or reusable;
- enable a test lane solely because tools are present;
- rewrite all current scripts into a plugin framework; or
- mutate the published repository or any external service.

## Completion questions

Before a seed implementation is called ready, it must answer:

1. Which safety and authority rules remain invariant?
2. Which facts were observed rather than assumed?
3. Which choices and machine facts remain ignored-local?
4. Which real need would justify the next extension?
5. Which next action still needs explicit operator approval?
