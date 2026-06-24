#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ensure_dir() {
  local dir="$1"
  mkdir -p "$dir"
}

link_file() {
  local source="$1"
  local target="$2"

  ensure_dir "$(dirname "$target")"
  ln -sf "$source" "$target"
  printf 'linked %s -> %s\n' "$target" "$source"
}

link_dir() {
  local source="$1"
  local target="$2"

  ensure_dir "$(dirname "$target")"

  if [[ -e "$target" && ! -L "$target" ]]; then
    printf 'skipped %s because it already exists and is not a symlink\n' "$target"
    return 0
  fi

  ln -sfn "$source" "$target"
  printf 'linked %s -> %s\n' "$target" "$source"
}

install_skill() {
  local skill_name="$1"
  local skill_source="$repo_root/.config/ai-agents/skills/$skill_name"

  link_dir "$skill_source" "$config_home/ai-agents/skills/$skill_name"
  link_dir "$skill_source" "$HOME/.agents/skills/$skill_name"
  link_dir "$skill_source" "$HOME/.codex/skills/$skill_name"
  link_dir "$skill_source" "$config_home/codex/skills/$skill_name"
  link_dir "$skill_source" "$HOME/.claude/skills/$skill_name"
  link_dir "$skill_source" "$config_home/claude/skills/$skill_name"
  link_dir "$skill_source" "$config_home/opencode/skills/$skill_name"
  link_dir "$skill_source" "$config_home/antigravity/skills/$skill_name"
  link_dir "$skill_source" "$HOME/.gemini/skills/$skill_name"
}

main() {
  local config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
  local global_agents_source="$repo_root/.config/ai-agents/AGENTS.md"

  ensure_dir "$HOME/.local/bin"
  ensure_dir "$HOME/.agents"
  ensure_dir "$HOME/.agents/skills"
  ensure_dir "$config_home/ghostty"
  ensure_dir "$config_home/tmux"
  ensure_dir "$config_home/ai-agents"
  ensure_dir "$config_home/ai-agents/skills"
  ensure_dir "$config_home/claude"
  ensure_dir "$config_home/claude/skills"
  ensure_dir "$config_home/codex"
  ensure_dir "$config_home/codex/skills"
  ensure_dir "$config_home/opencode"
  ensure_dir "$config_home/opencode/skills"
  ensure_dir "$config_home/antigravity"
  ensure_dir "$config_home/antigravity/skills"
  ensure_dir "$HOME/.claude"
  ensure_dir "$HOME/.claude/skills"
  ensure_dir "$HOME/.codex"
  ensure_dir "$HOME/.codex/skills"
  ensure_dir "$HOME/.gemini"
  ensure_dir "$HOME/.gemini/skills"

  link_file "$repo_root/.config/ghostty/config" "$config_home/ghostty/config"
  link_file "$repo_root/.config/tmux/tmux.conf" "$config_home/tmux/tmux.conf"
  link_file "$repo_root/.local/bin/agent-init" "$HOME/.local/bin/agent-init"
  link_file "$repo_root/.local/bin/task-init" "$HOME/.local/bin/task-init"
  link_file "$global_agents_source" "$config_home/ai-agents/AGENTS.md"
  link_file "$global_agents_source" "$config_home/ai-agents/global_memory.md"

  # Agent prompt entry points intentionally point to one canonical AGENTS.md file.
  link_file "$global_agents_source" "$HOME/.agents/AGENTS.md"
  link_file "$global_agents_source" "$config_home/AGENTS.md"
  link_file "$global_agents_source" "$config_home/claude/CLAUDE.md"
  link_file "$global_agents_source" "$config_home/claude/AGENTS.md"
  link_file "$global_agents_source" "$HOME/.claude/CLAUDE.md"
  link_file "$global_agents_source" "$HOME/.claude/AGENTS.md"
  link_file "$global_agents_source" "$config_home/codex/AGENTS.md"
  link_file "$global_agents_source" "$HOME/.codex/AGENTS.md"
  link_file "$global_agents_source" "$config_home/codex/global_memory.md"
  link_file "$global_agents_source" "$HOME/.gemini/GEMINI.md"
  link_file "$global_agents_source" "$HOME/.gemini/AGENTS.md"

  # Install shared skills into common harness-specific and neutral locations.
  install_skill "project-guide"
  install_skill "task-plan"

  printf '\nDotfiles installation complete.\n'
}

main "$@"
