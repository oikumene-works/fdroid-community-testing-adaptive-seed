# Publication Record

## Status and authority

The public repository was created on 2026-09-20 from exact approved commit
`e371eb9ccdf298330a9c20fb51a35b85dfc765d1`. The approved initial mutation
created the repository, pushed only `main`, and applied the recorded metadata.
This record authorizes no later push, metadata change, tag, release,
announcement, or modification to the original starter kit.

## Public identity

- **Owner:** `oikumene-works`
- **Repository:** `fdroid-community-testing-adaptive-seed`
- **Public URL:** <https://github.com/oikumene-works/fdroid-community-testing-adaptive-seed>
- **Visibility:** public
- **Default branch:** `main`
- **License:** Zero-Clause BSD (`0BSD`)
- **Original project:**
  <https://github.com/oikumene-works/fdroid-community-testing-starter-kit>
- **Exact derivation point:**
  <https://github.com/oikumene-works/fdroid-community-testing-starter-kit/commit/5a54da63a58b22c8715778a31931394769b60d72>

GitHub description:

> Independent adaptive alternative to the Guarded F-Droid Community Testing
> Starter Kit: discovers local capabilities, grows through explicit choices,
> and preserves strict approval boundaries.

GitHub topics:

- `fdroid`
- `android-testing`
- `community-testing`
- `adaptive-seed`
- `shell`

The operator selected this public name during preparation. Immediately before
creation, anonymous and authenticated checks found no repository at the target.
After creation, the uncached anonymous page and public API both returned HTTP
200 while the original project remained public and unchanged.

## Local source audit

The preparation audit observed:

- `main` is clean and has no configured remote;
- the first seed commit directly follows published starter-kit commit
  `5a54da63a58b22c8715778a31931394769b60d72`;
- all commits use the established public GitHub no-reply bot identity;
- the tree contains no tracked symlinks, APKs, archives, raw logs, captures,
  keystores, or files larger than one megabyte;
- the largest Git blob is below 16 KiB;
- tracked source contains no detected credential pattern, workstation path,
  private machine hostname, or ignored `.local` or `.idea` state;
- local Markdown links, shell syntax, ShellCheck, denial tests, workflow tests,
  readiness tests, seed growth tests, and documentation budgets pass; and
- the source uses the inherited `0BSD` license and retains third-party
  non-relicensing language.

The audit is evidence about this candidate, not proof that the code is secure,
portable to every host, or suitable for every F-Droid case.

## Public presentation boundary

The initial publication exposed the repository and `main` only. It created no
tag, GitHub Release, package, Pages site, announcement, issue, discussion, or
backlink mutation in the original project. Each later public surface adds its
own review and maintenance boundary.

The seed README links to the original project and exact derivation commit. A
backlink from the original project would modify that independent project and
therefore needs its own later review and approval.

## Exact pre-publication gate

Immediately before the approved publication, the gate required:

1. run `REQUIRE_NO_REMOTE=1 ./scripts/check-all.sh`;
2. require a clean `main` and record its exact commit identifier;
3. inspect every commit author and committer identity;
4. repeat the credential, workstation-path, forbidden-artifact, symlink,
   ignored-local-state, and large-blob checks;
5. recheck both proposed GitHub URLs anonymously;
6. verify the authenticated GitHub account and authority for `oikumene-works`;
7. present the exact description, topics, visibility, destination, and command
   sequence for operator approval; and
8. stop if the name, commit, account, source tree, or requested metadata differs.

## Executed mutation sequence

After exact approval, the process created the empty public repository without
initializing files, added its HTTPS URL as `origin`, pushed only the approved
clean `main`, applied the approved description and topics, and verified the
public default branch and commit. No ambiguous mutation result occurred.

The approved commands executed once were:

```sh
gh repo create oikumene-works/fdroid-community-testing-adaptive-seed --public \
  --description 'Independent adaptive alternative to the Guarded F-Droid Community Testing Starter Kit: discovers local capabilities, grows through explicit choices, and preserves strict approval boundaries.'
git remote add origin \
  https://github.com/oikumene-works/fdroid-community-testing-adaptive-seed.git
git push --set-upstream origin main
gh repo edit oikumene-works/fdroid-community-testing-adaptive-seed \
  --default-branch main \
  --add-topic fdroid --add-topic android-testing \
  --add-topic community-testing --add-topic adaptive-seed --add-topic shell
```

Post-publication verification observed the exact public URL and commit, public
visibility, `main` as the default and only branch, the approved description and
topics, and zero tags and releases.

## Publication retrospective

| Evidence | Impact | Smallest response | Disposition |
| --- | --- | --- | --- |
| A browser fetch briefly repeated the pre-creation 404 after authenticated verification showed the repository public | A cached absence could be mistaken for a failed publication | Verify an ambiguous result through an uncached anonymous page and public API before mutating or retrying | Adopted during verification; no retry occurred |
| Exact commit approval limited the first push to the reviewed tree | The durable handoff became stale as soon as publication succeeded | Record the outcome in a separate local commit and require new approval before pushing it | Adopted; authority boundary preserved |
| The public repository contains only `main`, and tag and release counts are zero | The initial public surface matches the smallest useful seed publication | Leave announcements, backlinks, tags, and releases for separately justified slices | Adopted as the stop condition |

The later self-referential handoff loop and its correction are recorded in the
[Seed Publication Evolution Log](seed-publication-evolution.md).

## Battleship results publication — 2026-09-22

After reviewing the distinction between locally committed results and GitHub
state, the operator explicitly requested publication of the results. The
authorized destination was this repository's existing public main branch.
This included the case records and the already implemented eligibility policy
needed to interpret them, not an upstream issue update or F-Droid comment.

Results commit `ba990f713d57d01049d1deb2d9239040b4f699e2` was pushed by the
authenticated oikumene-admin account and verified through both the Git remote
and GitHub commits API at 2026-09-22T03:04:40Z. The previous remote head was
`cb4ab8bd35952acb204c0920086d14a379996066`. The update was a normal fast-forward
of main only; no forced update, tag, release or repository metadata change.

The four unpublished commits inherited workstation-specific author/committer
metadata. Before publication, their metadata was replaced with the established
public oikumene-agent[bot] no-reply identity, preserving every file tree and
commit timestamp. Original local checkpoint identifiers in historical case
records map to these public commits:

| Original local checkpoint | Identical public file-tree checkpoint |
| --- | --- |
| `641156a18e35c732537387b8028413dc2e29f260` | `8ce54c2905362aaae2d8d61278b030f1005bb8c7` |
| `83c7ee36ac4b5563cc580be31ee9629fa05fbce4` | `428cea9255dd8a7c072b24f35ec100ce12106cd9` |
| `29be0405a1883c107233325d182c7cca4d0912d1` | `8ffec5e55998660f9c20f40f335af13894091e86` |
| `f4d1e94e1d87d2d303a299595eeab8e23e3aae15` | `ba990f713d57d01049d1deb2d9239040b4f699e2` |

The originals remain in a local recovery ref, which was not pushed. The clone
now explicitly uses the established public identity for later local commits.
This identity choice supplies no future publication authority.

Pre-publication verification passed all offline repository checks, both
digest-bound case gates, clean-worktree checks, and a bounded scan of all four
new commits (125 unique file blobs) for known credential/workstation patterns,
symlinks, ignored local state, oversized blobs and forbidden artifacts. These
checks are limited evidence, not a comprehensive security audit.

The published qualification remains static: no Android start or installation,
all functional tests Not tested, product findings still open. The APK/raw journal
were deleted before publication; only sanitized records and reviewed seed changes
were pushed. The later publication receipt/handoff update records this completed
result without describing its own pending push.

Retrospective: installed Git/GitHub tools sufficed. Metadata review caught the
local identity issue before exposure; the existing public-identity rule was
applied without changing test evidence. Codex/shared coordination used the
operator's existing publication instruction, with no additional authority or
material process change. This is a known rule, not a new improvement proposal.
