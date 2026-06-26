# dotfiles Agent Guide

## Project

A portable workflow kit for AI coding sessions (Agentic Workspace) that standardizes state, posture, and procedures across coding agents using local markdown files.

This repository is the source package for developing and publishing the workflow. It is not the downstream project root where the workflow is consumed. The installed workflow interface is the command names provided by install, such as `work-context`, `task-ready`, and `task-init`; `bin/` is the source location of those scripts inside this repository.

## Stack

- Runtime: Bash (OS: Linux/macOS)
- Framework: None (Shell scripts and markdown templates)
- Package manager: None (Local symlinks and copies)

## Commands

- Install: `./install.sh`
- Context check: `work-context`
- Initialize task: `task-init "<title>"`
- Validate task contract: `task-ready .tasks/<task-file>.md`

## Architecture

- `agents/`: global baseline preferences and phase-specific `modes/`
- `bin/`: workspace state CLI scripts
- `skills/`: procedural guidelines (git-commit, task-artifact, lavish-planning, etc.)
- `templates/`: templates for `AGENTS.md` and task artifacts

## Known Traps

- Path issues: always use absolute paths or resolve paths relative to `repo_root` when referencing files.
- Do not confuse this source repo with a consumer installation. Use `bin/...` only when editing or testing the scripts in this repo. User-facing workflow guidance should use installed command names such as `work-context`, `task-ready`, and `task-init`.
- If installed workflow commands are missing in a harness after install, treat that as a corrupted installation or environment setup problem. Do not add `which work-context` or fallback path probing to the workflow guidance.
