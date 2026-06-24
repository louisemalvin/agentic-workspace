---
name: project-guide
description: Create or refresh project-level AGENTS.md guides for agent-agnostic coding workflows. Use when entering a repository without AGENTS.md, bootstrapping a project for multiple harnesses, standardizing Claude/Codex/OpenCode/Antigravity setup, or separating stable project context from task artifacts.
---

# Project Guide

## Purpose

Use this skill to create or update a project-local `AGENTS.md` that any coding harness can read before work starts. Follow the video workflow principle: global preferences stay tiny, `AGENTS.md` stores stable project context, and task-specific planning lives in artifacts.

## Workflow

1. Check for an existing project guide:
   - Prefer `AGENTS.md`.
   - Also notice `CLAUDE.md`, `GEMINI.md`, `.cursorrules`, or harness-specific files if present.
2. If `AGENTS.md` is missing, run `agent-init` when available. If unavailable, create `AGENTS.md` with the structure below.
3. If harness-specific guidance files exist, preserve their content and recommend consolidating stable project facts into `AGENTS.md`.
4. Inspect the repository before filling sections. Use package files, README, config files, tests, and directory layout. Do not guess commands.
5. Keep task-specific decisions out of `AGENTS.md`. Put active planning in `.tasks/*.md`.
6. Keep `AGENTS.md` concise. Add only facts that should remain useful across many sessions.
7. Include the workflow rules below so agents know to use task artifacts without waiting for a special user phrase.

## AGENTS.md Structure

Use this shape unless the project already has a stronger convention:

```md
# Project Agent Guide

## Project

What this project is, who it serves, and the current product stage.

## Stack

- Runtime:
- Framework:
- Package manager:
- Database:
- Deployment:

## Commands

- Install:
- Dev:
- Test:
- Lint:
- Typecheck:
- Build:

## Architecture

List important directories and ownership boundaries.

## Workflow

- Keep task-specific planning in .tasks/*.md.
- When discussion produces a concrete implementation direction, create or update a task artifact automatically.
- Do not require the user to say "freeze", "handoff", or "write a spec".
- Before implementation, make sure the active task artifact has goal, decisions, acceptance criteria, and verification plan.
- Update the active task artifact before handing work to another harness.
- Verify behavior against acceptance criteria before calling work done.

## Task Artifacts

Use `.tasks/<date>-<slug>.md` for active task plans and handoffs.

Each task artifact should include:

- Goal
- Context
- Decisions
- Acceptance Criteria
- Implementation Plan
- Verification Plan
- Status
- Handoff Notes

## Known Traps

- Add repeated agent mistakes here after they happen.
```

## Update Rules

- Prefer facts discovered from files over conversational assumptions.
- Do not include secrets, tokens, API keys, or private credentials.
- Do not paste long chat history into `AGENTS.md`.
- Move long conditional instructions into skills or referenced docs.
- Record repeated mistakes as short `Known Traps` bullets.
- If a task artifact is missing for active work, create `.tasks/<date>-<slug>.md` instead of expanding `AGENTS.md`.
- If the user is reviewing options in chat or a visual planning tool, write the final decision back to the active task artifact.

## Handoff Contract

Before switching harnesses, starting implementation, or ending a session, update the active task artifact with:

- Current status
- Files changed
- Decisions made
- Commands run
- Errors encountered
- Next exact step

The next harness should read the global `AGENTS.md`, project `AGENTS.md`, and the active task artifact. It should not need the prior chat transcript.
