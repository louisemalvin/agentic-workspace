# Optional Lavish Integration

Lavish Editor is an optional planning and review surface for agent-generated HTML artifacts. It is useful when product plans, UI decisions, diagrams, comparisons, or technical reports would be hard to review as terminal markdown.

Upstream: https://github.com/kunchenguid/lavish-axi

Agentic Workspace treats Lavish as a planning surface, not as the durable source of truth. Final decisions should always be written back into `docs/` or the active `.tasks/*.md` artifact.

The main use case is reviewing a plan before implementation starts. When the plan has several parts, reviewing it as terminal text is slow and error-prone. Lavish gives the user a visual artifact they can annotate before durable project knowledge is committed to `docs/` or execution state is committed to `.tasks`.

Lavish should save review time and tokens. Do not generate a giant markdown handoff and a giant HTML handoff for the same work.

## Install The Upstream Skill

Lavish publishes an Agent Skills skill:

```bash
npx skills add kunchenguid/lavish-axi --skill lavish
```

That teaches capable agents to run the CLI on demand through:

```bash
npx -y lavish-axi
```

Use `-g` with `npx skills add` if you want the upstream Lavish skill installed globally for supported harnesses.

## Zero Setup Use

Without installing the upstream skill, ask an agent to use the CLI directly:

```text
Use npx -y lavish-axi to create and review a visual plan for this task.
```

## Optional Session Hooks

Lavish can also install session-start hooks for supported harnesses:

```bash
npm install -g lavish-axi
lavish-axi setup hooks
```

Restart the agent session after installing hooks.

## Workflow Contract

1. Identify whether the confirmed output belongs in `docs/`, `.tasks/`, or both.
2. If the plan is easy to review in terminal, skip Lavish.
3. If review is hard, create an HTML artifact near the task file.
4. Open it with `npx -y lavish-axi <html-file>`.
5. Poll feedback with `npx -y lavish-axi poll <html-file>`.
6. Update the HTML until the user confirms the direction.
7. Copy only durable project knowledge into `docs/`.
8. Copy only implementation scope, acceptance criteria, and verification expectations into `.tasks/*.md`.

Do not leave important decisions only in the Lavish browser session.

## Contract Review Shape

A good Lavish review artifact should show:

- Intended outcome.
- Scope and out of scope.
- Decisions and rejected options.
- Implementation workstreams.
- Files or subsystems likely to change.
- Acceptance criteria.
- Verification expectations.
- Risks, edge cases, and open questions.

## Token Discipline

- Chat should point to the active task, relevant docs, and Lavish artifact instead of repeating the full plan.
- `docs/` should contain durable project knowledge that remains useful after the task is done.
- `.tasks` should contain the compact final contract.
- Lavish should visualize only the parts that benefit from visual review.
- Large artifacts, logs, screenshots, or generated HTML should be referenced by path, not pasted into `.tasks`.
