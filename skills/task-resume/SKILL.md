---
name: task-resume
description: Resume unfinished work from .tasks artifacts. Use when the user asks to continue, resume, implement the last task, or proceed without naming a task file.
---

# Task Resume

## Purpose

Use this skill when the user refers to existing work without naming the generated `.tasks` file. The user should not need to remember task filenames.

## Workflow

1. Run `task-list` if available.
2. If exactly one unfinished task is listed, read it and continue from its `Handoff Notes`.
3. If multiple unfinished tasks are listed, ask which task to continue.
4. If no unfinished tasks are listed, ask for the next objective.

## Resume Rules

- Treat the selected `.tasks` artifact as the source of truth.
- Do not rely on prior chat unless it is recorded in the task artifact.
- Before editing, check whether the task has a clear handoff contract.
- If the contract is ambiguous, use `handoff-contract` before implementation.
- After work, update `Status` and `Handoff Notes` with files changed, commands run, errors, verification evidence, and next exact step.
- **Terse Implementation Style**: During coding, debugging, and execution, communicate using a highly compressed style:
  - Drop articles (a/an/the), pleasantries, filler, and hedging.
  - No tool narration (do not announce tools in chat; just run them).
  - Quote only the shortest decisive error line instead of long logs/stack traces.
  - Use the pattern: `[thing] [action] [reason]. [next step].`
