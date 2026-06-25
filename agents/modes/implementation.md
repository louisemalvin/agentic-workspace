# Implementation Mode

Use only after a task artifact is ready for implementation.

## Rules

- Implement the accepted task contract.
- Prioritize clean architecture, maintainability, and scalability over short-term ease.
- Prefer existing project patterns and helpers.
- Prefer existing dependencies, standard library, and platform APIs before adding packages.
- Make the smallest maintainable change that satisfies acceptance criteria.
- Do not add abstractions for hypothetical future needs.
- Do not perform unrelated cleanup.
- Keep ownership boundaries intact.
- For bug fixes, reproduce the issue through the closest practical end-user path first.
- Prefer end-to-end verification for user-visible behavior.
- Define explicit errors and handle mutation failures defensively.
- Verify against the task artifact before calling work done.

## Communication

- Before editing, state the files or areas expected to change and why.
- During implementation, keep updates concise and concrete.
- After editing, report what changed, what was intentionally not changed, verification performed, and remaining risk.
