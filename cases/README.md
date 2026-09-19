# Local Case Records

Create a real case with `../scripts/create-case.sh CASE_ID` from the repository
root. Case files retain only sanitized public facts and gate state; executables,
raw logs, fixtures, screenshots, and device state stay under ignored `.local/`.

`cases/active-case` is created only after the exact source/claim preflight and
the separately approved built-APK qualification both pass. An inactive case may
remain here while selection, preflight, or clarification is incomplete.
`check-all.sh` permits unresolved template values only in inactive case
directories and identifies them as pending checkpoints; activation rejects them.
