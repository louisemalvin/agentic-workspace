---
name: task-artifact
description: Create or update compact .tasks artifacts when discussion becomes concrete enough to preserve implementation state, decisions, acceptance criteria, or verification evidence.
---

# Task Artifact

## Purpose

Use this skill when a discussion turns into concrete work that should survive context switches, new sessions, or another harness. The user should not need to say "freeze", "write a spec", or "create a handoff".

The artifact is a compact contract, not a transcript.

## Workflow

1. Continue as the single user-facing owner.
2. Ask clarifying questions only when they materially change scope, acceptance criteria, or risk.
3. Inspect the repo when needed to ground the task in real files and commands.
4. Once direction is concrete, create or update `.tasks/<date>-<slug>.md`.
5. Prefer `task-init "<task title>"` when available.
6. Run `task-check <task-file>` after filling the artifact when handoff readiness matters.
7. In chat, report the task path, status, and unresolved questions only. Do not print the full artifact unless asked.

## Artifact Sections

Use the template from `task-init` when available. Otherwise include:

- Goal
- Context
- Decisions
- Acceptance Criteria
- Implementation Plan
- Handoff Contract
- Verification Plan
- Status
- Handoff Notes

## Token Rules

- Prefer bullets over prose.
- Keep each field to the minimum detail needed for safe implementation.
- Do not paste chat transcripts, full logs, full diffs, or generated HTML.
- Store large evidence as file paths with one-line summaries.
- Mark irrelevant fields as `N/A` instead of filling them with boilerplate.
- Describe the current task state directly. Do not narrate how the plan changed unless that history prevents likely mistakes.

## Status Updates

Before stopping or handing off, update:

- `Status`
- `Handoff Notes`
- `Next exact step`
- `Files changed`
- `Commands run`
- `Errors encountered`
