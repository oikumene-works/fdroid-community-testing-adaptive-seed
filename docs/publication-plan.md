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
- **Proposed URL:** <https://github.com/oikumene-works/fdroid-community-testing-adaptive-seed>
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
