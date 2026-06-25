---
name: handoff-contract
description: Review and finalize implementation contracts before coding, delegation, or switching harnesses. Use when scope, acceptance criteria, risks, or verification need to be explicit before implementation.
---

# Handoff Contract

## Purpose

Use this skill before implementation, delegation to another agent, or switching harnesses. The goal is to make the contract explicit enough that an implementer can work from `.tasks/*.md` without relying on prior chat.

## Required Contract

If an active task artifact exists, run `task-check <task-file>` first. Use its output to identify missing or empty sections before editing.

The active task artifact should make these fields explicit:

- Scope: what the implementer should change.
- Out of scope: what the implementer should avoid.
- Files or areas likely to change: grounded in repo inspection when possible.
- Interfaces or behavior contracts: APIs, UI behavior, data shapes, commands, or compatibility expectations.
- Risks and edge cases: where bugs or regressions are likely.
- Open questions: only items that still need user or maintainer judgment.
- Acceptance criteria: what must be true when done.
- Verification plan: commands, end-to-end checks, screenshots, logs, or other evidence expected.

## Readiness Rules

- If the contract is clear, implementation may proceed from the task artifact.
- If product or technical judgment is still required, ask before implementation.
- If several independent workstreams exist, split them into separate task artifacts before parallelizing.
- Do not rely on hidden chat state. If it matters, write it into `.tasks`.

## Visual Review

Use `lavish-planning` when the handoff is hard to review in terminal because it has multiple parts, ambiguous boundaries, UI states, architecture choices, diagrams, or high-risk edge cases.

After visual review, copy the confirmed contract back into the active `.tasks` artifact. Lavish is not the durable source of truth.
