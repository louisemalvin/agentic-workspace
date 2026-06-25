# Agentic Workspace

Agentic Workspace is a portable workflow kit for AI coding sessions. It keeps the parts that must survive across harnesses in plain files, so Codex, Claude Code, Gemini, OpenCode, agy, Reasonix, and future tools can share the same operating model.

The goal is not to build another agent dispatcher. The goal is to make every new session understand the workspace layers, find the current state, and leave behind useful artifacts without relying on hidden chat history.

## Mental Model

Keep these layers separate:

```text
agents/AGENTS.md
  Global agent guide. Personal workflow defaults for every harness.

PROJECT_ROOT/AGENTS.md
  Repo-specific agent guide. Created in each project by agent-init.

docs/
  Human-durable project knowledge. High-level overview, architecture,
  concepts, collaboration context, and explanations useful before reading code.

.tasks/
  Active execution state. Task contracts, decisions, acceptance criteria,
  verification plans, evidence, status, and handoff notes.

agents/modes/
  Workflow posture. Short behavior briefs for the current phase.

skills/
  Callable procedures. Detailed how-to instructions for specific activities.

bin/
  Portable command interface. Scripts that route, validate, initialize, and commit.

Git worktrees
  Runtime isolation for parallel agent work.
```

The common confusion to avoid:

- `agents/AGENTS.md` is global. It is installed into harness prompt locations.
- `AGENTS.md` in a project is local to that repo. It is created from `templates/AGENTS.md`.
- `docs/` explains the project at a durable human level.
- `.tasks/` records active work state and task decisions.
- Modes say how the agent should behave right now.
- Skills say how to perform one specific operation.

## Repository Layout

```text
agents/
  AGENTS.md
  modes/
    contract-filling.md
    evidence.md
    implementation.md
bin/
  agent-init
  git-commit-safe
  task-init
  task-list
  task-ready
  task-status
  work-context
skills/
  git-commit/SKILL.md
  lavish-planning/SKILL.md
  project-guide/SKILL.md
  task-artifact/SKILL.md
templates/
  AGENTS.md
  task.md
optional/
  lavish/README.md
install.sh
README.md
```

## Sources Of Truth

### Global Agent Guide

`agents/AGENTS.md` is the shared global baseline. It should stay tiny because it is loaded often by multiple harnesses.

Use it for personal defaults that apply everywhere, such as communication preferences and the instruction to run `work-context` at workflow boundaries.

Do not put project facts, task plans, long procedures, or one-off decisions in the global guide.

### Project Agent Guide

`agent-init` creates a repo-local `AGENTS.md` from `templates/AGENTS.md`.

Use project `AGENTS.md` for stable repo facts:

- What the project is.
- Stack and package manager.
- Common commands.
- Important directories and ownership boundaries.
- Repeated agent mistakes or known traps.

Do not put active task planning in project `AGENTS.md`. Use `.tasks/` for that.

### Docs

`docs/` is for human-durable project knowledge. It should help a person or agent understand the project before reading code.

Use `docs/` for:

- High-level product or system overview.
- Architecture explanations.
- Domain concepts and terminology.
- Collaboration context.
- Durable design decisions that remain useful after the task ends.

Do not use `docs/` as an execution log. If the information only matters for the current task, put it in `.tasks/`.

### Task Artifacts

`.tasks/*.md` files are active execution artifacts. They are compact contracts and state logs, not transcripts.

Use `.tasks/` for:

- Goal.
- Context needed for implementation.
- Decisions made for the task.
- Acceptance criteria.
- Implementation plan.
- Task contract.
- Verification plan.
- Status.
- Commands run, files changed, errors, evidence, and next exact step.

The next harness should be able to continue by reading the global guide, project guide, relevant docs, and active task artifact. It should not need the prior chat.

## Workflow Router

`work-context` is the entry point for non-trivial work.

Run it:

- At the start of a repo or session.
- After `agent-init`.
- After `task-init`.
- After filling or updating a task artifact.
- Before implementation.
- After implementation or verification changes task status.

`work-context` reports:

- Sources of truth.
- Active tasks.
- Required reads.
- Readiness state.
- Current mode.
- Blocked actions.
- Next step.

It replaces ad hoc resume logic. If there is one active task, it selects it. If several active tasks exist, it asks the user to choose. If no task exists, it keeps the session in chat or task-shaping mode.

## Workflow Phases

The normal progression is:

```text
project_init -> chat_or_task_shaping -> contract_filling -> implementation -> evidence -> done
```

### project_init

Use when a repo does not have a project `AGENTS.md`.

Expected action:

```bash
agent-init
work-context
```

The project guide should stay concise and stable.

### chat_or_task_shaping

Use while the user is exploring, asking questions, or deciding direction.

Keep exploration in chat until the direction becomes concrete. Once implementation state needs to survive context switches, create or update a task artifact.

Expected action:

```bash
task-init "Short task title"
work-context .tasks/<task-file>.md
```

### contract_filling

Use before implementation when the task is not ready.

The agent should make the task contract explicit enough that another harness can implement from `.tasks/*.md`.

Expected check:

```bash
task-ready .tasks/<task-file>.md
```

If readiness fails, fill the missing fields or ask the user only for decisions that affect scope, risk, acceptance criteria, or verification.

### implementation

Use only after `task-ready` passes.

`work-context` points to the implementation mode brief:

```text
agents/modes/implementation.md
```

The implementer should code against the accepted contract, avoid unrelated cleanup, verify behavior, and update the task artifact.

### evidence

Use after implementation is recorded but verification remains.

The agent should prove the task satisfies the acceptance criteria, preferably with end-to-end evidence for user-visible behavior. Evidence can be commands, logs, screenshots, videos, or manual verification notes.

If evidence exposes a defect, return to implementation with narrow scope. Do not broaden or replan unless the task contract is invalid.

### done

Use when the task is implemented and verified or intentionally cancelled.

The task artifact should include final status, evidence, files changed, commands run, and any remaining risk.

## Modes And Skills

Modes and skills are different tools.

```text
Mode = how to behave right now.
Skill = how to perform a specific operation.
```

Modes should be short. They set posture, constraints, and what not to do.

Skills can be longer. They contain detailed procedures that are loaded only when relevant.

Current mode briefs:

- `agents/modes/contract-filling.md`: behavior while making a task artifact implementation-ready.
- `agents/modes/implementation.md`: coding behavior after task readiness passes.
- `agents/modes/evidence.md`: behavior while proving implementation against acceptance criteria.

Current skills:

- `project-guide`: create or refresh project `AGENTS.md`.
- `task-artifact`: create or update `.tasks/*.md`.
- `lavish-planning`: use Lavish Editor for visual planning and review.
- `git-commit`: create clean Conventional Commits.

Future modes can mirror workflow phases when the behavior is important enough to standardize.

## Command Reference

### agent-init

Creates a project-local `AGENTS.md` from `templates/AGENTS.md`.

```bash
agent-init
```

Optional target path:

```bash
agent-init AGENTS.md
```

### work-context

Routes the current workflow state.

```bash
work-context
work-context .tasks/<task-file>.md
```

### task-init

Creates a task artifact from `templates/task.md`.

```bash
task-init "Improve onboarding empty state"
```

### task-list

Prints unfinished task artifacts with status and next step. This is a lower-level helper used by routing scripts and agents.

```bash
task-list
```

### task-ready

Checks whether a task artifact has the structure and content needed for implementation.

```bash
task-ready .tasks/<task-file>.md
```

### task-status

Prints active, done, and total task counts plus status, readiness, and next step.

```bash
task-status
task-status .tasks/<task-file>.md
```

### git-commit-safe

Stages explicit paths, checks the staged diff, rejects protected local files, and creates a Conventional Commit using the user's configured Git identity.

```bash
git-commit-safe -m "feat(scope): describe change" -- path/to/file
```

## Installation

```bash
git clone https://github.com/louisemalvin/agentic-workspace.git ~/github/agentic-workspace
cd ~/github/agentic-workspace
chmod +x install.sh
./install.sh
```

The default install links the scripts into:

```text
~/.local/bin/
```

It links the global agent guide into common harness prompt locations:

```text
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

It links shared skills into neutral and harness-specific skill directories:

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

Harnesses that support this skill layout can load the skills directly. Harnesses that do not support skills still share the global guide and can use the scripts in `bin/`.

## Lavish

Lavish Editor is optional. Use it when a plan, UI decision, diagram, comparison, or technical report is hard to review as terminal markdown.

Upstream:

```text
https://github.com/kunchenguid/lavish-axi
```

Install the upstream skill:

```bash
npx skills add kunchenguid/lavish-axi --skill lavish
```

Or run the CLI directly:

```bash
npx -y lavish-axi <html-file>
npx -y lavish-axi poll <html-file>
```

Lavish is a review surface, not a source of truth. Copy final durable project knowledge into `docs/` and active execution decisions into `.tasks/`.

See `optional/lavish/README.md` for the detailed integration contract.

## Parallel Work

For one task, keep one user-facing coordinator responsible for scope and final review.

For parallel tasks, split work before spawning workers:

- Each worker gets one bounded task contract.
- Each worker runs in an isolated Git worktree.
- Evidence returns through files, diffs, logs, commits, or task notes.
- The coordinator reviews results against acceptance criteria.

Basic worktree setup:

```bash
git worktree add ../feature-agent feature-agent
git worktree add ../review-agent review-agent
```

Do not run multiple agents against unrelated changes in the same working tree unless they are only reading.

## Safety

Do not commit tokens, API keys, SSH private keys, `.env` files, or machine-local credentials. Keep secrets in the platform keychain, shell environment, or a dedicated secrets manager.

Before publishing or tagging a release, check:

```bash
git status --short
git diff
```

Trust reproducible commands, tests, logs, screenshots, videos, and diffs over agent summaries.
