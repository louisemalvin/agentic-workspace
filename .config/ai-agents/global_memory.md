# Global Agent Memory

- Treat this repository as the shared baseline for every coding agent on this machine.
- Default to fast execution assumptions: measure automation in seconds or minutes, not human-estimated task blocks.
- Before refactoring, reproduce the bug or behavior end to end and keep a failing test or command as the proof point.
- Prefer small, verifiable edits over broad rewrites; preserve existing architecture unless evidence says it is the constraint.
- Use typed interfaces, explicit error handling, and defensive boundary checks for untrusted inputs.
- Keep formatting deterministic: run the project formatter and avoid style-only churn outside touched code.
- Favor clear control flow, early returns, named helpers, and simple data structures over clever compression.
- Never commit secrets, private keys, tokens, or local machine credentials.
- Document operational decisions where future agents would otherwise need to rediscover context.
- When blocked, record the exact command, error output, environment assumption, and next recovery step.
