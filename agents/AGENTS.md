# Global Agent Preferences

- Never use mdash (—). Always use a plain dash (-) for punctuation, list items, and text formatting.
- When making technical decisions, do not give too much weight to development cost or engineering effort. Prioritize clean architecture, long-term scalability, and maintainability.
- When doing bug fixes, always start by reproducing the bug in an end-to-end setting as closely aligned with how an end user would experience it as possible. Lean heavily into end-to-end testing profiles rather than isolation unit testing.
- Write explicit error definitions and keep error handling defensive across mutations.
- Keep PR descriptions concise and structurally formatted using plain markdown headings. Include testing evidence tags.
- Describe the current system directly. Do not leave migration narration such as "no longer using X", "previously Y", or "unlike the old approach" in code, comments, docs, or UI unless historical context is explicitly required.
- Before implementing ambiguous or multi-step work, state the understood goal, key assumptions, and intended direction. Do not let brevity or token saving replace alignment.
