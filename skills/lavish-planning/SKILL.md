---
name: lavish-planning
description: Use Lavish Editor for pre-implementation visual planning, comparison, diagrams, reports, code views, and UI or UX discussions, then write final decisions back into docs or the active .tasks artifact.
---

# Lavish Planning

## Purpose

Use this skill when a task would be easier to review as an interactive visual artifact than as a long terminal response. Lavish is a local-first editor for agent-generated HTML artifacts. It lets the user annotate elements or selected text, choose options, and send feedback back to the agent.

This skill does not replace durable files. Lavish is the review surface; `docs/` holds durable human-readable project knowledge and `.tasks/*.md` holds active execution state.

Use Lavish to reduce review cost, not to generate another large document.

## When To Use

Use Lavish for:

- Product or technical plans with multiple options.
- Pre-implementation reviews where the contract has several moving parts.
- UI, UX, information architecture, or interaction design.
- Architecture diagrams, flows, state machines, or sequence diagrams.
- Dense tables, comparisons, reports, or decision matrices.
- Code views or implementation plans that need comments on precise sections.
- Any discussion where a wall of markdown would make review slow or ambiguous.

Do not use Lavish for:

- Tiny changes where a short answer is enough.
- Simple implementation contracts that fit cleanly in a compact `.tasks` artifact.
- Secret material that should not be written into local HTML artifacts.
- Work where no local browser can be opened.

## Workflow

1. Identify whether confirmed output belongs in `docs/`, `.tasks/`, or both.
2. Create an HTML artifact for the discussion. Prefer a path near the relevant doc or task artifact.
3. Match the design system of the project being planned. Inspect the target project's theme, CSS variables, component library, Tailwind config, or existing UI before inventing visuals.
4. Use Lavish to open or resume the artifact:

   ```bash
   npx -y lavish-axi <html-file>
   ```

5. Poll for feedback while the user reviews:

   ```bash
   npx -y lavish-axi poll <html-file>
   ```

6. Apply user feedback to the artifact, then poll again until the user confirms the direction or ends the session.
7. Write durable project knowledge and decisions back into `docs/` when they should remain useful after the task.
8. Write implementation scope, acceptance criteria, and verification expectations back into `.tasks/*.md`.
9. Implement from the `.tasks` artifact, not from hidden Lavish session state.

Do not also print the full plan in chat. Chat should name the artifact path, durable output path, and any open questions.

## Contract Review

When Lavish is used before implementation, the artifact should make the plan easy to audit:

- Summary of the intended outcome.
- Scope and out-of-scope sections side by side.
- Decision list with selected options and rejected alternatives.
- Implementation sequence grouped by workstream.
- Files or subsystems likely to change.
- Acceptance criteria.
- Verification evidence expected from implementation.
- Risks, edge cases, and open questions.

The user should be able to annotate any part of this artifact before implementation starts. After review, copy durable project knowledge into `docs/` and the confirmed execution contract into `.tasks/*.md`.

## Token Budget Rules

- Do not duplicate all durable file content in the Lavish artifact.
- Focus the HTML on what is hard to review in terminal text: options, boundaries, diagrams, states, risks, and decision points.
- Keep `docs/` focused on durable project knowledge.
- Keep `.tasks` as the compact final contract after review.
- Link to the Lavish artifact path from `.tasks`; do not paste HTML into `.tasks`.
- Summarize large review evidence by path and result.
- Skip Lavish when the handoff is already easy to audit in terminal.

## Artifact Rules

- Keep artifacts local and project-specific.
- Reference local assets with relative paths from the HTML artifact directory.
- Do not rely on root-prefixed paths such as `/assets/logo.png`.
- For diagrams, prefer Mermaid through Lavish's design/playbook guidance unless the diagram needs custom rendering.
- Native controls such as radios, checkboxes, inputs, selects, buttons, labels, and disclosure summaries should remain normal interactive controls.
- Mark only custom clickable controls with Lavish action attributes when needed.
- Fix layout warnings from `lavish-axi poll` before asking the user to review.

## Durable Outputs

Before implementation or stopping work, update the relevant durable files.

Use `docs/` for:

- Durable architecture or workflow decisions.
- System explanations.
- Diagrams or summaries that should remain useful after the task.

Use `.tasks/*.md` for:

- Lavish artifact path.
- Reviewed execution contract.
- Acceptance criteria.
- Verification plan.
- Current status.
- Next exact step.

The next harness should be able to continue by reading the global `AGENTS.md`, project `AGENTS.md`, relevant docs, and the active `.tasks` artifact without needing the Lavish browser session or prior chat.
