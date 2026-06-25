# Agentic Workspace

Agentic Workspace is a lightweight, harness-agnostic workflow setup for AI coding. It keeps project context, task state, handoffs, and commit conventions in plain files so you can move between Codex, Claude Code, Gemini, OpenCode, agy, Reasonix, and whatever comes next without rebuilding your process around one tool.

The project focuses on portable workflow primitives: global rules, project guides, task artifacts, skills, and handoff conventions.

## Why This Exists

AI coding tools are changing quickly. Each harness has its own config files, memory behavior, permission model, and extension system. A workflow that lives entirely inside one product becomes brittle as soon as you switch tools.

This repository keeps the durable parts of the workflow outside any single harness:

- Stable project context lives in `AGENTS.md`.
- Active task state lives in `.tasks/*.md`.
- Reusable procedures live in small skills.
- Parallel work uses Git worktrees.
- Commits remain the durable checkpoint.

The goal is not to build another agent dispatcher. The goal is to make whichever agent you are using today start from the same context and leave behind the same useful artifacts.

The operating model is **coordinator and workers**:

- One user-facing coordinator owns the task boundary.
- Worker sessions can investigate, build, or validate.
- Decisions, plans, and handoffs are written to files instead of hidden chat state.
- Git worktrees provide isolation for parallel work.

This avoids chained-agent telephone loops where each handoff compresses intent, loses filesystem state, and turns prior decisions into vague summaries.

## Repository Layout

```text
agents/
  AGENTS.md
bin/
  agent-init
  git-commit-safe
  task-check
  task-init
  task-list
skills/
  git-commit/SKILL.md
  handoff-contract/SKILL.md
  lavish-planning/SKILL.md
  project-guide/SKILL.md
  task-artifact/SKILL.md
  task-resume/SKILL.md
templates/
  AGENTS.md
  task.md
optional/
  lavish/README.md
install.sh
README.md
```

## Core Concepts

`agents/AGENTS.md` is the shared global baseline. The installer links it into common global prompt locations so multiple harnesses can start from the same rules.

`agent-init` creates a project-local `AGENTS.md` from `templates/AGENTS.md` when a project does not already have one. Project guides are for stable facts: stack, commands, architecture, workflow rules, and known traps.

`task-init` creates `.tasks/<date>-<slug>.md` from `templates/task.md`. Task artifacts are for active implementation plans, acceptance criteria, verification evidence, and handoff notes.

`task-list` prints unfinished task artifacts with status and next step. It is meant for agents to run when resuming work, so the user does not need to remember generated task filenames.

`task-check` validates that a task artifact has the required sections for handoff-ready work.

`git-commit-safe` stages explicit paths, checks the staged diff, rejects protected local files, and creates a Conventional Commit using the user's configured Git identity.

The `project-guide` skill teaches agents to create or refresh project guides without polluting them with task-specific context.

The `task-artifact` skill teaches agents to create or update compact task artifacts once discussion becomes concrete. The user should not need to say "freeze", "handoff", or "write a spec".

The `handoff-contract` skill teaches agents to finalize implementation contracts before coding, delegation, or switching harnesses.

The `task-resume` skill teaches agents to run `task-list` and continue unfinished work without requiring the user to remember generated task filenames.

The `lavish-planning` skill teaches agents to use Lavish Editor when a plan, diagram, comparison, report, code view, or UI/UX discussion is easier to review visually than as terminal markdown. Lavish is a planning surface; final decisions still belong in `.tasks/*.md`.

The `git-commit` skill teaches agents to make small Conventional Commits while preserving the user's configured Git author identity.

The workflow is designed to avoid token-heavy handoffs. Simple work should use only a compact `.tasks` artifact. Lavish is for cases where visual review prevents ambiguity; it should not duplicate a full markdown plan.

## Installation

```bash
git clone https://github.com/louisemalvin/agentic-workspace.git ~/github/agentic-workspace
cd ~/github/agentic-workspace
chmod +x install.sh
./install.sh
```

The default install links only the agent workflow pieces:

```text
~/.local/bin/agent-init
~/.local/bin/git-commit-safe
~/.local/bin/task-check
~/.local/bin/task-init
~/.local/bin/task-list
~/.config/ai-agents/AGENTS.md
~/.config/AGENTS.md
~/.agents/AGENTS.md
~/.config/claude/CLAUDE.md
~/.config/claude/AGENTS.md
~/.claude/CLAUDE.md
~/.claude/AGENTS.md
~/.config/codex/AGENTS.md
~/.codex/AGENTS.md
~/.gemini/GEMINI.md
~/.gemini/AGENTS.md
```

It also links shared skills into neutral and common harness-specific directories:

```text
~/.config/ai-agents/skills/<skill>
~/.agents/skills/<skill>
~/.codex/skills/<skill>
~/.config/codex/skills/<skill>
~/.claude/skills/<skill>
~/.config/claude/skills/<skill>
~/.config/opencode/skills/<skill>
~/.config/antigravity/skills/<skill>
~/.gemini/skills/<skill>
```

Harnesses that support this skill layout can load the skills directly. Harnesses that do not support skills still share the global `AGENTS.md` and can use `agent-init` and `task-init`.

## Optional Lavish Integration

Lavish Editor is provided by `kunchenguid/lavish-axi`: https://github.com/kunchenguid/lavish-axi

It can be installed as an upstream Agent Skills skill:

```bash
npx skills add kunchenguid/lavish-axi --skill lavish
```

Lavish can also be used with no skill install by asking the agent to run:

```bash
npx -y lavish-axi <html-file>
```

Use Lavish for complex planning and review, then write the confirmed decisions back into the active `.tasks/*.md` artifact. See `optional/lavish/README.md` for the detailed integration contract.

## Project Initialization

In any project that lacks an `AGENTS.md`:

```bash
cd ~/projects/my-project
agent-init
```

The generated file should stay concise and stable. Put task-specific planning in `.tasks/*.md`.

To create a task artifact directly:

```bash
task-init "Improve onboarding empty state"
```

This creates:

```text
.tasks/<date>-improve-onboarding-empty-state.md
```

## Workflow Model

Keep these concepts separate:

- Personas: coordinator, implementer, reviewer, investigator.
- Skills: conditional procedures such as `project-guide`, `task-artifact`, `handoff-contract`, `task-resume`, `lavish-planning`, and `git-commit`.
- Runtime: shell sessions, Git worktrees, and local commands.

For one task, talk to one main agent. It may create or update a task artifact, then implement from that file. For parallel tasks, a coordinator can create worktrees and spawn implementer sessions, but the handoff should remain file-based.

When resuming work, the agent should run `task-list`. If one unfinished task exists, continue from it. If several exist, ask which task to continue.

Example worktree setup:

```bash
git worktree add ../feature-agent feature-agent
git worktree add ../review-agent review-agent
```

The coordinator reviews changes through Git diffs, commands, logs, and task artifacts rather than trusting conversational confidence.

## Public Safety

Do not commit tokens, API keys, SSH private keys, `.env` files, or machine-local credentials. Keep secrets in the platform keychain, shell environment, or a dedicated secrets manager.

Before publishing or tagging a release, check:

```bash
git status --short
git diff
```

Trust reproducible commands, tests, logs, and diffs over agent summaries.
