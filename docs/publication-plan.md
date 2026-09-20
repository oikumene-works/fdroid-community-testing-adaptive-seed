# Publication Preparation

## Status and authority

This is a local publication candidate, not a published project. Preparing this
plan authorizes no GitHub repository creation, remote, push, topic change, tag,
release, announcement, or modification to the original starter kit.

No publication action is authorized until the operator approves the exact clean
commit, owner, repository name, visibility, description, topics, and mutation
sequence. A technical command or authenticated account never supplies that
approval.

## Proposed public identity

- **Owner:** `oikumene-works`
- **Repository:** `fdroid-community-testing-seed`
- **Proposed URL:** <https://github.com/oikumene-works/fdroid-community-testing-seed>
- **Visibility:** public
- **Default branch:** `main`
- **License:** Zero-Clause BSD (`0BSD`)
- **Original project:**
  <https://github.com/oikumene-works/fdroid-community-testing-starter-kit>
- **Exact derivation point:**
  <https://github.com/oikumene-works/fdroid-community-testing-starter-kit/commit/5a54da63a58b22c8715778a31931394769b60d72>

Proposed GitHub description:

> Adaptive companion to the Guarded F-Droid Community Testing Starter Kit:
> discovers local capabilities, grows through explicit choices, and preserves
> strict approval boundaries.

Proposed topics:

- `fdroid`
- `android-testing`
- `community-testing`
- `adaptive-seed`
- `shell`

The public repository name is still a proposal. An anonymous GitHub check on
2026-09-20 found the original project public and the proposed seed URL returning
404. A 404 is not a reservation; availability must be rechecked immediately
before an approved create operation.

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
  private machine hostname, or ignored `.local` state;
- local Markdown links, shell syntax, ShellCheck, denial tests, workflow tests,
  readiness tests, seed growth tests, and documentation budgets pass; and
- the source uses the inherited `0BSD` license and retains third-party
  non-relicensing language.

The audit is evidence about this candidate, not proof that the code is secure,
portable to every host, or suitable for every F-Droid case.

## Public presentation boundary

The initial publication should expose the repository and `main` only. It should
not create a tag, GitHub Release, package, Pages site, announcement, issue,
discussion, or backlink mutation in the original project. Each later public
surface adds its own review and maintenance boundary.

The seed README links to the original project and exact derivation commit. A
backlink from the original project would modify that independent project and
therefore needs its own later review and approval.

## Exact pre-publication gate

Immediately before any approved publication:

1. run `REQUIRE_NO_REMOTE=1 ./scripts/check-all.sh`;
2. require a clean `main` and record its exact commit identifier;
3. inspect every commit author and committer identity;
4. repeat the credential, workstation-path, forbidden-artifact, symlink, and
   large-blob checks;
5. recheck both proposed GitHub URLs anonymously;
6. verify the authenticated GitHub account and authority for `oikumene-works`;
7. present the exact description, topics, visibility, destination, and command
   sequence for operator approval; and
8. stop if the name, commit, account, source tree, or requested metadata differs.

## Proposed later mutation sequence

After exact approval, create the empty public repository without initializing
files, add its HTTPS URL as `origin`, push only the approved clean `main`, apply
the approved description and topics, then verify the public default branch and
commit. If repository creation or push has an ambiguous result, do not retry or
delete automatically; inspect public and authenticated state first.

The proposed commands, to be re-presented rather than run without approval, are:

```sh
gh repo create oikumene-works/fdroid-community-testing-seed --public \
  --description 'Adaptive companion to the Guarded F-Droid Community Testing Starter Kit: discovers local capabilities, grows through explicit choices, and preserves strict approval boundaries.'
git remote add origin \
  https://github.com/oikumene-works/fdroid-community-testing-seed.git
git push --set-upstream origin main
gh repo edit oikumene-works/fdroid-community-testing-seed \
  --default-branch main \
  --add-topic fdroid --add-topic android-testing \
  --add-topic community-testing --add-topic adaptive-seed --add-topic shell
```

Success must include the exact public URL, observed commit, visibility, default
branch, description, topics, and confirmation that no tag or release exists.
Local preparation alone satisfies none of those postconditions.
