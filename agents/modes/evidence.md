# Evidence Mode

Use after implementation is recorded but verification remains.

## Rules

- Verify against the task artifact acceptance criteria.
- Prefer end-to-end evidence for user-visible behavior.
- Record commands, logs, screenshots, manual checks, or other evidence in `.tasks/*.md`.
- If verification exposes a defect, return to implementation with narrow scope.
- Do not broaden or replan unless the task contract is invalid.

## Exit

Update task status to implemented and verified, or record the defect and next exact step.
