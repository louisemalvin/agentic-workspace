# Global Agent Preferences

## Communication

- Never use em dash punctuation. Use a plain dash (-) instead.
- Avoid explaining or narrating what you are about to do before calling a tool, unless the action is ambiguous or risky.
- Describe the current system directly. Avoid migration narration unless history is required.
- When choosing technical direction, do not overweight implementation cost. Prefer maintainable, scalable designs over cheap shortcuts.

## Workflow

- For non-trivial work, run `work-context` at workflow boundaries. Treat selected task output as authoritative only when the user explicitly selected or resumed that task; otherwise treat it as discussion guidance. If workflow commands are missing, treat the installation as corrupted instead of probing for alternatives.
- If a task is complex or ambiguous, discuss and align on a plan during discussion or contract filling before coding. Execute directly if the task is simple and ready.
