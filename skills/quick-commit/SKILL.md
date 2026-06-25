---
name: quick-commit
description: Create concise Git commits using Conventional Commits. Use when the user asks Codex to commit, make a quick commit, propose a commit message, split staged changes into commits, clean up a commit message, or verify that a commit follows Conventional Commits and local authorship rules.
---

# Quick Commit

Use this skill to turn the current Git diff into one or more clean commits without adding AI attribution.

## Workflow

1. Inspect repository state with `git status --short`.
2. Inspect the relevant diff before staging or committing:
   - Use `git diff` for unstaged changes.
   - Use `git diff --cached` for staged changes.
   - Use path-limited diffs when the user identified specific files.
3. Decide whether the current changes are one coherent commit.
   - If unrelated changes are mixed, split them into separate commits or ask which subset to commit.
   - Do not stage unrelated local notes, generated artifacts, secrets, or user changes outside the requested scope.
4. Choose a Conventional Commit header:
   - Format: `<type>[optional scope]: <description>`
   - Use `feat` for user-visible features.
   - Use `fix` for bug fixes.
   - Use `docs`, `test`, `refactor`, `perf`, `build`, `ci`, `style`, or `chore` when they describe the change better.
   - Use a scope only when it adds real context, such as `docs(readme): ...`.
   - Use imperative, lowercase descriptions without a trailing period.
5. Add a body only when the commit needs context that is not obvious from the header.
6. Add footers only when useful. For breaking changes, use `BREAKING CHANGE: <description>` or `!` in the header.
7. Run a lightweight verification command that matches the change, at minimum `git diff --cached --check` when committing staged changes.
8. Commit with `git commit`.

## Authorship Rules

- Never add `Co-authored-by`, `Generated-by`, `Signed-off-by`, tool credits, model names, or AI attribution trailers unless the user explicitly asks for that exact trailer.
- Do not set or override `GIT_AUTHOR_NAME`, `GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_NAME`, or `GIT_COMMITTER_EMAIL`.
- Let Git use the user's configured author and committer identity.
- If Git blocks the commit because identity is missing, stop and report the exact error.

## Message Shape

Prefer one-line commits for small changes:

```text
docs: refocus repository on agent workflow
```

Use a body when evidence or risk matters:

```text
feat(skills): add quick commit workflow

Add a reusable skill for creating Conventional Commits while preserving
the user's configured Git author identity.
```

Use breaking-change syntax only for real compatibility breaks:

```text
feat(api)!: require explicit workspace ids

BREAKING CHANGE: callers must pass workspace_id when creating tasks.
```

## Safety Checks

- Refuse to commit secrets, credentials, private keys, or `.env` files.
- Treat untracked files as excluded until deliberately inspected and selected.
- If `.git` is read-only or Git cannot create an index lock, explain that the filesystem prevents committing and provide the exact commands for the user to run locally.
- If there are pre-existing user changes mixed with current work, preserve them unless the user explicitly includes them in the commit.
