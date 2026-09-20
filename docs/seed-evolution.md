# From Guarded Starter Kit to Adaptive Seed

## Purpose and disclosure status

This document records why the project is exploring an adaptive seed, including
mistakes, limitations, and corrections. It is intended to become public project
history. It must remain evidence-based and must not turn hindsight into a claim
that every earlier decision was avoidable.

This seed project preserves ancestry from published starter-kit commit
`5a54da63a58b22c8715778a31931394769b60d72`. It was published from approved
commit `e371eb9ccdf298330a9c20fb51a35b85dfc765d1`. The local `grow` path reaches guarded offline verification.

## The original need

The original project began with a concrete operational need: produce bounded,
reproducible community evidence for one third-party F-Droid new-app merge
request without confusing readiness, execution, reporting, or publication
authority.

Building and exercising a complete guarded path exposed safety requirements
that a speculative minimal template would probably have missed. The published
kit now contains exact source pinning, public-claim review, built-APK
qualification, disposable-emulator targeting, verified cleanup, evidence
hygiene, report review, and separately approved posting.

That work remains valuable. The design change is not a rejection of the guarded
workflow.

## What changed in our thinking

The original kit answers:

> How can this known Linux reference environment perform one guarded workflow?

The seed must first answer:

> What is true in this new user's environment, and what is the smallest safe
> capability that can grow here?

The difference is sequencing. The original kit presents a largely grown
reference environment. The seed begins with discovery, a user choice, and one
bounded adaptation while retaining the reference lane as proven capability.

The operator then sharpened the interaction goal: growth should not become a
technical interview. The seed should discover facts by itself and communicate
only at meaningful choice or authority boundaries. The first interaction
contract therefore became one grower request, one seed proposal, one grower
choice, and one completion report. This is a design requirement, not merely a
preference for concise wording.

## Evidence that motivated the shift

### Complete reference path

Two real cases and the fictional dry run demonstrated that exact pins, gates,
effect labels, cleanup, and separate publication approval are not theoretical.
They belong in the invariant kernel.

### Context-free external reading

On 2026-09-20, an external agent with read-only GitHub access and no prior
project context found the public starter kit and reconstructed its newcomer
path. Its initial response was useful but made correctable semantic mistakes:

- it attributed two upstream inspection scripts to GitLab instead of GitHub;
- it blurred case activation with authorization to execute;
- it blurred human authorization, an approved operational slice, and technical
  approval tokens;
- it understated documented Bubblewrap restrictions; and
- it missed existing conservative cleanup-recovery guidance.

A guided audit against exact source files corrected those mistakes. This showed
that the repository was discoverable and self-correcting, but also that its
authority vocabulary needed a single clearer map.

### Real local discovery evaluation

A separate clean-session evaluation asked an agent to inspect an actual Ubuntu
workspace without network access or changes and recommend the smallest useful
starter slice. The agent activated the adaptive-seed guidance, inspected tools
and versions, separated observed presence from unverified operation, excluded a
machine-specific skill symlink from portable source, and proposed one small
POSIX-shell discovery path.

The evaluation covered one environment only. It did not test contrasting
hosts, profile creation, or profile reuse. Its raw transcript was not retained;
only the prompt, decision result, and limitations were recorded. We must not
claim stronger evidence.

## Mistakes, limitations, and lessons

| Type | Earlier state | Evidence or impact | Lesson and response |
| --- | --- | --- | --- |
| Corrected implementation error | A publication postcondition counted recursive tree directories as files | The first count was invalid even though the published tree was intact | Correct the measurement, run a read-only recovery check, and record the failed check rather than hiding it |
| Documentation weakness | Activation, authorization, operational slice, and token meanings were distributed across documents | A context-free reader conflated them | Add one authoritative authority map to the seed kernel |
| Design limitation | Readiness is measured against one fixed Linux reference environment | A missing reference component often becomes `BLOCKED` even when another safe growth path might exist | Separate truthful discovery from selection of a supported lane |
| Sequencing tradeoff | The complete guarded kit was built before the adaptive newcomer interface | The safety model is strong, but first use assumes substantial project knowledge | Preserve the proven lane and place discovery and user choice before it |
| Interaction risk | A powerful growth interface could ask a newcomer to make premature technical choices | New users cannot reliably answer questions the seed could inspect itself | Discover first, recommend one slice, and ask only about goals, effects, and authority |
| Evidence limitation | Local adaptation has been observed on only one host | Portability beyond that host is unproved | Keep other environments `UNSUPPORTED` or `UNKNOWN` until tested |

Calling something a tradeoff or limitation is not a way to avoid admitting an
error. The project should label each finding according to the evidence and
update the label when new evidence warrants it.

## Public learning record

For every material design correction, the public record should state:

1. the earlier assumption or decision;
2. the dated observation or test that challenged it;
3. the impact on users, safety, or maintenance;
4. the smallest adopted correction;
5. how the correction was evaluated; and
6. what remains unknown.

Raw evidence should be public when it is retained and safe to publish. When it
was not retained, the project must say so. Public transparency never includes
credentials, private transcripts, personal data, workstation paths, transient
signed URLs, or third-party private evidence.

## Current hypothesis

The project can retain the current safety properties while making the newcomer
experience radically smaller:

```text
Grow this seed
  -> discover truthfully
  -> propose one bounded local adaptation
  -> wait for the user's exact choice
  -> apply, verify, record, and stop
```

This is a hypothesis until a newcomer can use the implemented path in a clean
environment. The design documents alone do not prove it.

## Slice 1 retrospective

The first read-only prototype ended at a safe proposal checkpoint. The bounded
retrospective retained three findings:

| Evidence | Impact | Smallest response | Disposition |
| --- | --- | --- | --- |
| Adapter availability initially appeared beside host readiness as `READY` | A newcomer could mistake included adapter code for local client or network readiness | Label it as a seed capability, verify the adapter files, and state that client and network readiness are untested | Adopted now; Codex-owned, no new authority |
| The report contains multiple factual rows before one proposal | Detail supports auditability but may still feel dense to a newcomer | Evaluate comprehension in the clean newcomer test before changing the output | Park for Slice 4; shared review |
| The unsupported-host test simulates a Darwin result while still running on Linux | It verifies branching logic, not real macOS compatibility | Keep macOS unsupported and make no portability claim | No change |

## Slice 2 retrospective

The first ignored-local profile was previewed, approved, written atomically with
mode `600`, and verified unchanged by an identical reapply. The bounded
retrospective retained three findings:

| Evidence | Impact | Smallest response | Disposition |
| --- | --- | --- | --- |
| After profile creation, the default growth proposal initially still offered to prepare the same profile | The seed stored an adaptation but failed to use it when choosing its next growth | Detect exact, absent, and conflicting local-profile state before proposing the next slice; add a regression assertion | Adopted now; Codex-owned, no new authority |
| The exact technical guard is intentionally verbose | It prevents accidental writes but may burden a newcomer using the terminal directly | Let the newcomer evaluation measure whether the agent-facing path hides enough ceremony without hiding effects | Park for Slice 4; shared review |
| The profile records an absolute SDK choice that can become stale | A later session could treat an old path as current if it only reads the file | Continue running discovery and compare the profile with current facts before using it | Carry into Slice 3 verification |

## Slice 3 retrospective

The exact-profile path passed the repository checks and fictional dry run. The
wrapper preserved the profile and Git worktree. Three findings were retained:

| Evidence | Impact | Smallest response | Disposition |
| --- | --- | --- | --- |
| The first real output still described the wrapper as a future implementation | The proposal contradicted the capability that had just been added | Describe preview and execution as the available next slice; add the wording to the regression test | Adopted now; Codex-owned, no new authority |
| Repository checks produce a long nested test transcript | Audit evidence is clear, but a newcomer may struggle to find the final result | Preserve truthful output and measure comprehension before designing a concise view | Park for Slice 4; shared review |
| A successful run is not stored as durable growth state | A later `grow` call safely offers the repeatable verification again | Avoid a new state file until evaluation shows a real need; report the completed run in the handoff | Deliberate limit; no change |

## Slice 4 retrospective

A fresh read-only agent received only the repository and `Grow this seed`. It
ran discovery, made no change, proposed one preview, and stopped for a choice.
Three findings were retained:

| Evidence | Impact | Smallest response | Disposition |
| --- | --- | --- | --- |
| The portable handoff said the ignored development profile existed, but the clean copy correctly had none | The evaluator had to reconcile contradictory local state | Label development-only history and state that a clean copy begins without the profile | Adopted now; Codex-owned, no new authority |
| The generic startup path caused about 440 lines of operational documentation to be read before a local discovery request | The final answer was clear, but activation used 18,475 model tokens and unnecessary context | Add a grow-only startup path; a fresh recheck skipped the protocol and used 7,328 tokens | Adopted now; Codex-owned, safety gates retained |
| The read-only evaluation sandbox lacked `/dev/kvm` while the development host had it | Discovery correctly reported the evaluated environment rather than copying prior readiness | Keep the result as one contrasting-host observation, not portability proof | No change |

## Slice 5 retrospective

The initial distribution question incorrectly included replacing public `main`.
The operator clarified that comparison between two usable implementations is a
project purpose, not a temporary migration stage. Three findings were retained:

| Evidence | Impact | Smallest response | Disposition |
| --- | --- | --- | --- |
| Codex framed replacement as a live option after the parallel value was already emerging | It risked turning an experiment in different design premises into a winner-and-loser migration story | State that the original remains usable and undeprecated; record this framing correction publicly | Adopted now; Codex-owned |
| A separate sibling project makes both implementations independently obtainable and comparable | It adds a real maintenance boundary and possible divergence | Document provenance and review shared safety corrections deliberately; do not imply automatic synchronization | Adopted as distribution direction; shared ownership |
| A repository name and public location are not yet needed to preserve the decision | Premature creation would cross local-project and publication boundaries without improving the comparison | Keep `fdroid-community-testing-seed` provisional and stop before repository creation | Park for the next separately approved slice |

## Local sibling creation retrospective

The approved local project was created without a remote. Three findings were
retained:

| Evidence | Impact | Smallest response | Disposition |
| --- | --- | --- | --- |
| The seed can retain the starter kit's exact Git ancestry instead of beginning with a history-free copy | Reviewers can inspect both the common base and the seed-specific change | Make the published starter-kit commit the parent of the first seed commit | Adopted now; Codex-owned |
| The design worktree contained a valid ignored machine profile | Copying it would falsely make one machine's adaptation part of the new project | Exclude `.local` completely; let the independent seed begin with discovery | Adopted now; invariant/local boundary preserved |
| The first local commit attempt inherited an email containing a private machine hostname | Publishing that metadata later would leak machine-specific identity | Replace it before any remote with the established public no-reply bot identity and require metadata review before publication | Adopted now; Codex-owned, no external mutation |

## Publication preparation retrospective

The bounded audit retained three findings:

| Evidence | Impact | Smallest response | Disposition |
| --- | --- | --- | --- |
| The seed README named the original but did not link its public source or exact derivation commit | A reviewer had to trust local prose to find the comparison base | Add public links to the original repository and immutable commit | Adopted now; Codex-owned |
| The proposed GitHub URL returned 404 anonymously | The name appears available, but treating absence as a reservation could create a race or wrong-target publication | Recheck immediately before an approved create action and stop on any change | Adopted as a later gate |
| Public repository metadata had not been decided | Creating first and improvising description or topics would make the external mutation under-specified | Record the proposed owner, name, visibility, description, topics, and bounded initial surface | Adopted now; operator approval still required |

## Public name refinement

The operator selected `fdroid-community-testing-adaptive-seed`; `adaptive` exposes the different premise without implying replacement. `Independent alternative` replaced `companion` because the seed does not depend on the original kit.
When Android Studio later created ignored `.idea` state containing a workstation path, the publication gate caught it before commit.
