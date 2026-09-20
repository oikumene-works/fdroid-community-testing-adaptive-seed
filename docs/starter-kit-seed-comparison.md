# Guarded Starter Kit and Adaptive Seed

## Relationship decision

The adaptive seed does not replace, supersede, or deprecate the published
Guarded F-Droid Community Testing Starter Kit. The original kit remains a fully
usable implementation for anyone who prefers its complete reference workflow
or wants to compare it with the seed approach.

The seed was developed from published [starter-kit commit
`5a54da63`](https://github.com/oikumene-works/fdroid-community-testing-starter-kit/commit/5a54da63a58b22c8715778a31931394769b60d72).
That provenance must remain visible.
The distribution is a separately named sibling project, not a new `main` that
erases the original implementation. The sibling now exists locally with no
remote or publication.

## Same need, different opening question

Both implementations seek bounded, reproducible community evidence without
confusing readiness, execution, reporting, or publication authority.

The starter kit began with:

> How can a known Linux reference environment perform the complete guarded
> workflow?

The seed begins with:

> What is true in this user's environment, and what is the smallest safe
> capability that should grow here next?

The second question was learned from building and using the first approach. It
does not make the first question or its implementation a mistake.

## Design and implementation consequences

| Dimension | Guarded starter kit | Adaptive seed |
| --- | --- | --- |
| Starting premise | A documented Linux reference environment is the target | Local conditions must be discovered before choosing a path |
| Initial shape | A complete, stage-gated workflow | A small kernel plus discovery, local profile, and optional growth |
| First interaction | Read the runbook, check the host, and initialize the workspace | Say `Grow this seed`, receive one proposal, and stop for a choice |
| Configuration | Reference examples become explicit local configuration | Discovered facts and approved choices become an ignored local profile |
| Unsupported conditions | Often block the fixed reference lane | Are distinguished from missing and unknown conditions before adaptation |
| Authority | Explicit gates throughout the complete workflow | The same gates remain invariant; learning and growth never create authority |
| Verification | Proves the whole known path and denial boundaries | Also tests clean discovery, adaptation, stale local state, and growth stops |
| Immediate strength | A complete, auditable path is available at once | A newcomer sees a smaller relevant next step |
| Immediate cost | More context and environment assumptions at first use | More orchestration, state comparison, branching, and evaluation machinery |
| Maintenance risk | Reference assumptions can become implicit or stale | Proposals and local profiles can become stale or diverge from discovery |

## What the implementations exposed

The complete starter kit made the safety model concrete. Real cases and the
fictional dry run exposed requirements for exact pins, built-APK qualification,
disposable-device targeting, cleanup, evidence limits, and separate posting
approval. Those findings became seed invariants rather than discarded work.

The seed work then exposed a different class of failure:

- discovery can be truthful while its presentation is still too dense;
- writing a profile is insufficient unless later proposals use that state;
- a stored absolute path must be compared with current discovery;
- a tracked handoff must not present one development machine's ignored state as
  the state of every clean copy; and
- a safe but overbroad startup procedure can consume unnecessary context before
  the user's actual task begins.

These consequences explain why the implementations differ. They do not support
a universal claim that one approach is better.

## Fair comparison rules

- Keep both projects obtainable and usable without forced migration.
- Identify the exact starter-kit commit from which the seed was derived.
- Compare observed behavior in named environments, not hypothetical support.
- Preserve mistakes and corrections in each project's own history.
- Do not transfer a feature, fix, or authority silently between projects.
- Review safety-invariant corrections for both projects, but apply and verify
  them independently.
- Cross-link the projects only after the exact public locations and wording are
  separately reviewed and approved.

## Current boundary

This independent local project uses the selected publication-candidate name
`fdroid-community-testing-adaptive-seed` and retains the starter-kit ancestry.
Adding a remote, publishing source, or modifying the original starter kit are
later and distinct decisions. This document authorizes none of them.
