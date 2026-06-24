# Persistent Agentic Workspace

This repository is a private dotfiles baseline for terminal-first AI coding work. It centralizes terminal settings, tmux persistence, and shared agent memory so local GPU terminals and mobile SSH clients attach to the same durable workspace.

## Architectural Overview

The operating model is **Captain & First Mate**. One primary agent owns the task boundary, keeps the plan coherent, and writes final decisions into durable files. Supporting agents can investigate, build, or review, but their output is treated as bounded evidence rather than a new source of authority.

This avoids volatile chained-agent telephone loops, where each handoff compresses intent, loses filesystem state, and degrades after large context windows. A 180k-token context can still become unreliable when every agent carries an approximate transcript instead of a crisp boundary.

Git worktrees are the isolation primitive. Each agent can work in its own checkout against the same repository history:

```bash
git worktree add ../feature-agent feature-agent
git worktree add ../review-agent review-agent
```

That gives each agent an isolated file boundary, independent build artifacts, and clean diffs. The Captain reviews changes through Git rather than through a lossy conversation chain.

## Repository Layout

```text
.config/
  ai-agents/global_memory.md
  ai-agents/skills/project-init/SKILL.md
  ghostty/config
  tmux/tmux.conf
.local/
  bin/agent-init
install.sh
README.md
```

`global_memory.md` is the shared system baseline for child agents. `install.sh` links it into common global prompt locations, including neutral `AGENTS.md` paths, so Claude, Codex, Gemini, OpenCode-compatible, and compatible tools can share the same foundational rules.

## Installation Protocol

On a pristine machine:

```bash
git clone <private-repo-url> ~/github/dotfiles
cd ~/github/dotfiles
chmod +x install.sh
./install.sh
```

The installer is idempotent. It creates the expected configuration directories and replaces managed files with symbolic links back into this repository:

```text
~/.config/ghostty/config
~/.config/tmux/tmux.conf
~/.local/bin/agent-init
~/.config/ai-agents/global_memory.md
~/.config/ai-agents/AGENTS.md
~/.config/AGENTS.md
~/.agents/AGENTS.md
~/.config/claude/CLAUDE.md
~/.config/claude/AGENTS.md
~/.claude/CLAUDE.md
~/.claude/AGENTS.md
~/.config/codex/AGENTS.md
~/.codex/AGENTS.md
~/.config/codex/global_memory.md
~/.gemini/GEMINI.md
~/.gemini/AGENTS.md
```

It also links the shared `project-init` skill into neutral and common harness-specific skill directories:

```text
~/.config/ai-agents/skills/project-init
~/.agents/skills/project-init
~/.codex/skills/project-init
~/.config/codex/skills/project-init
~/.claude/skills/project-init
~/.config/claude/skills/project-init
~/.config/opencode/skills/project-init
~/.config/antigravity/skills/project-init
~/.gemini/skills/project-init
```

Harnesses that support this skill layout can load the skill directly. Harnesses that do not support skills still share the same global `AGENTS.md` and can use `agent-init` as the fallback project bootstrap command.

Start or reload tmux after installation:

```bash
tmux new -s main
tmux source-file ~/.config/tmux/tmux.conf
```

## Project Initialization

Harnesses should not require hand-written project context before they can work. If a project does not already have `AGENTS.md`, run:

```bash
cd ~/projects/my-project
agent-init
```

This creates `AGENTS.md` only when it is missing. The local file is for stable project facts: stack, commands, architecture, workflow rules, and known traps. Task-specific planning belongs in `.tasks/*.md` so long planning sessions can be compressed into durable artifacts and resumed by any harness.

The installed `project-init` skill guides agents to do the same thing automatically: check for `AGENTS.md`, create it only when missing, keep it concise, and move task-specific context into `.tasks/*.md`.

Agents should not wait for a special phrase like "freeze the plan" before creating a task artifact. Once discussion has produced a concrete implementation direction, the agent should create or update `.tasks/<date>-<slug>.md`, then use that artifact as the implementation handoff.

Visual planning tools such as Lavish can fit into this same pipeline. They improve review by making options easier to inspect than terminal chat, but the final decisions should still be written back into the active `.tasks` artifact so any harness can continue.

## Terminal Persistence

tmux uses `Ctrl+a` as the prefix. Panes and windows open in the active directory:

```text
Ctrl+a |   split horizontally
Ctrl+a -   split vertically
Ctrl+a c   new window
Ctrl+a h/j/k/l   move between panes
```

Mouse and touch tracking are enabled for scrolling, pane selection, and mobile terminal use.

## Mobile Connectivity Matrix

Use SSH when latency is stable and Mosh when the network changes frequently.

| Client path | Command | Use case |
| --- | --- | --- |
| SSH attach | `ssh user@host -t 'tmux attach -t main || tmux new -s main'` | Directly resume the primary session. |
| SSH named worktree | `ssh user@host -t 'cd ~/github/dotfiles && tmux attach -t dotfiles || tmux new -s dotfiles'` | Keep dotfiles work isolated. |
| Mosh attach | `mosh user@host -- tmux attach -t main` | Roaming mobile network with an existing session. |
| Mosh create-or-attach | `mosh user@host -- sh -lc 'tmux attach -t main || tmux new -s main'` | Roaming mobile network with automatic session creation. |

Recommended mobile terminal apps should save one profile per host and use the create-or-attach command. That keeps running agents, builds, and logs alive when the client disconnects.

## Operational Notes

Do not commit tokens, API keys, SSH private keys, `.env` files, or machine-local credentials. Keep secrets in the platform keychain, shell environment, or a dedicated secrets manager.

Use Git commits as durable checkpoints. For multi-agent work, prefer:

```bash
git status --short
git diff
git commit -am "Describe the finished unit"
```

When agents disagree, trust reproducible commands, tests, logs, and diffs over conversational confidence.
