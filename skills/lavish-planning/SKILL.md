---
name: lavish-planning
description: Use Lavish Editor for visual planning, comparison, diagrams, reports, code views, and UI or UX discussions, then write final decisions back into the active .tasks artifact.
---

# Lavish Planning

## Purpose

Use this skill when a task would be easier to review as an interactive visual artifact than as a long terminal response. Lavish is a local-first editor for agent-generated HTML artifacts. It lets the user annotate elements or selected text, choose options, and send feedback back to the agent.

This skill does not replace task artifacts. Lavish is the review surface; `.tasks/*.md` remains the durable handoff.

Use Lavish to reduce review cost, not to generate another large document.

## When To Use

Use Lavish for:

- Product or technical plans with multiple options.
- Orchestrator-to-implementer handoffs where the contract has several moving parts.
- UI, UX, information architecture, or interaction design.
- Architecture diagrams, flows, state machines, or sequence diagrams.
- Dense tables, comparisons, reports, or decision matrices.
- Code views or implementation plans that need comments on precise sections.
- Any discussion where a wall of markdown would make review slow or ambiguous.

Do not use Lavish for:

- Tiny changes where a short answer is enough.
- Simple implementation handoffs that fit cleanly in a compact `.tasks` artifact.
- Secret material that should not be written into local HTML artifacts.
- Work where no local browser can be opened.

## Workflow

1. Identify the active task artifact. If none exists and the direction is concrete, create one with `task-init`.
2. Create an HTML artifact for the discussion. Prefer `.tasks/<task-slug>-lavish.html` or another path next to the active task.
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
7. Write final decisions, rejected options worth preserving, acceptance criteria, and verification expectations back into the active `.tasks/*.md` file.
8. Implement from the `.tasks` artifact, not from hidden Lavish session state.

Do not also print the full plan in chat. Chat should name the artifact path, the active task path, and any open questions.

## Handoff Review

When Lavish is used before delegating from an orchestrator to an implementer, the artifact should make the contract easy to audit:

- Summary of the intended outcome.
- Scope and out-of-scope sections side by side.
- Decision list with selected options and rejected alternatives.
- Implementation sequence grouped by workstream.
- Files or subsystems likely to change.
- Acceptance criteria.
- Verification evidence expected from the implementer.
- Risks, edge cases, and open questions.

The user should be able to annotate any part of this artifact before implementation starts. After review, copy the confirmed contract into the active `.tasks/*.md` artifact.

## Token Budget Rules

- Do not duplicate all `.tasks` content in the Lavish artifact.
- Focus the HTML on what is hard to review in terminal text: options, boundaries, diagrams, states, risks, and decision points.
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

## Handoff Contract

Before implementation or stopping work, update the active task artifact with:

- Lavish artifact path.
- Reviewed handoff contract.
- Decisions made.
- Options rejected.
- Acceptance criteria.
- Verification plan.
- Current status.
- Next exact step.

The next harness should be able to continue by reading the global `AGENTS.md`, project `AGENTS.md`, and the active `.tasks` artifact without needing the Lavish browser session or prior chat.
