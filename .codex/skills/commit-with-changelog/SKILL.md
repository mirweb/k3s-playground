---
name: commit-with-changelog
description: "Propose and execute git commits with changelog verification. Use when the user asks to commit changes and wants CHANGELOG.md checked/updated, a commit message suggested, and confirmation before staging and committing."
---

# Commit With Changelog

## Overview

Ensure changes are reviewed, CHANGELOG.md is updated as needed, and a commit message is proposed and confirmed before committing.

## Workflow

1) Check repository state

- Run `git status -sb` to see modified and untracked files.
- If there are no changes, report and stop.

2) Review changes

- Use `git diff` (and `git diff --staged` if needed) to understand what changed.
- If unrelated or unexpected changes appear, ask how to proceed.

3) Verify and propose CHANGELOG.md updates

- Open `CHANGELOG.md` and ensure changes are captured under `## [Unreleased]`.
- If missing, propose concise entries and ask for confirmation before editing.
- After applying, re-open to verify the entry is present.

4) Propose commit message

- Suggest a short, lowercase, imperative message (e.g., "add rancher reset password docs").
- Ask the user to confirm or edit the message before committing.

5) Stage and commit

- Stage only the intended files.
- Commit with the confirmed message.
- Report the commit hash and affected files.

## Confirmation Rules

- Always request confirmation before editing `CHANGELOG.md`.
- Always request confirmation before running `git commit`.
