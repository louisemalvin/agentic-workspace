# {{PROJECT_NAME}} Agent Guide

## Project

Describe what this project is, who it serves, and the current product stage.

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

- Keep task-specific planning in `.tasks/*.md`, not in this file.
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
