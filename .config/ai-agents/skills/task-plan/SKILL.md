---
name: task-plan
description: Create or update .tasks task artifacts from product, design, bug, or implementation discussions. Use when a conversation becomes concrete enough to plan work, when handing work between harnesses, when using visual planning tools like Lavish, or when implementation needs acceptance criteria and verification evidence.
---

# Task Plan

## Purpose

Use this skill to turn messy discussion into a durable task artifact. The user should not need to say "freeze", "write a spec", or "create a handoff". Detect when the conversation has enough concrete direction and update `.tasks/<date>-<slug>.md`.

## Planning Flow

1. Continue the conversation as the single user-facing owner.
2. Ask clarifying questions only while they materially change scope, acceptance criteria, or risk.
3. Inspect the repo when needed to ground the plan in real files and commands.
4. When the direction is concrete, create or update a task artifact.
5. Present the artifact summary for user correction if product or UX choices remain unsettled.
6. After approval or clear scope, implementation can proceed from the task artifact.

## Task Artifact

Prefer `task-init "<task title>"` when available. Otherwise create `.tasks/<date>-<slug>.md` with:

- Goal
- Context
- Decisions
- Acceptance Criteria
- Implementation Plan
- Verification Plan
- Status
- Handoff Notes

## Visual Planning

Use visual planning tools such as Lavish when terminal text is a poor review surface, especially for UI, UX, flows, information architecture, or product option comparison. Treat visual artifacts as planning surfaces, not final handoff state.

After the user comments on a visual artifact, write final decisions back into the active `.tasks` artifact so any harness can continue without the visual tool or prior chat.

## Handoff Rules

- Do not rely on hidden chat state for implementation.
- Keep rejected options only when they prevent likely re-litigation.
- Update `Status` and `Handoff Notes` before switching harnesses or stopping.
- Record verification evidence after implementation, including commands and user-facing checks.
- If the task grows into independent workstreams, split into separate task artifacts before spawning parallel agents.
