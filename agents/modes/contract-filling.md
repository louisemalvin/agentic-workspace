# Contract Filling Mode

Use when a task artifact exists but `task-ready` does not pass.

## Rules

- Make the task artifact implementation-ready.
- Ground likely files, commands, risks, and verification in repo inspection when needed.
- Record active task decisions in `.tasks/*.md`.
- Put durable project knowledge in `docs/` when it should remain useful after the task.
- Ask only questions that affect scope, risk, acceptance criteria, or verification.
- Do not implement until `task-ready <task-file>` passes.

## Exit

Run `task-ready <task-file>`. When it passes, run `work-context <task-file>` again.
