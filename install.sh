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

main() {
  local config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
  local memory_source="$repo_root/.config/ai-agents/global_memory.md"

  ensure_dir "$HOME/.local/bin"
  ensure_dir "$HOME/.agents"
  ensure_dir "$config_home/ghostty"
  ensure_dir "$config_home/tmux"
  ensure_dir "$config_home/ai-agents"
  ensure_dir "$config_home/claude"
  ensure_dir "$config_home/codex"
  ensure_dir "$HOME/.claude"
  ensure_dir "$HOME/.codex"
  ensure_dir "$HOME/.gemini"

  link_file "$repo_root/.config/ghostty/config" "$config_home/ghostty/config"
  link_file "$repo_root/.config/tmux/tmux.conf" "$config_home/tmux/tmux.conf"
  link_file "$repo_root/.local/bin/agent-init" "$HOME/.local/bin/agent-init"
  link_file "$memory_source" "$config_home/ai-agents/global_memory.md"
  link_file "$memory_source" "$config_home/ai-agents/AGENTS.md"

  # Agent prompt entry points intentionally point to one canonical memory file.
  link_file "$memory_source" "$HOME/.agents/AGENTS.md"
  link_file "$memory_source" "$config_home/AGENTS.md"
  link_file "$memory_source" "$config_home/claude/CLAUDE.md"
  link_file "$memory_source" "$config_home/claude/AGENTS.md"
  link_file "$memory_source" "$HOME/.claude/CLAUDE.md"
  link_file "$memory_source" "$HOME/.claude/AGENTS.md"
  link_file "$memory_source" "$config_home/codex/AGENTS.md"
  link_file "$memory_source" "$HOME/.codex/AGENTS.md"
  link_file "$memory_source" "$config_home/codex/global_memory.md"
  link_file "$memory_source" "$HOME/.gemini/GEMINI.md"
  link_file "$memory_source" "$HOME/.gemini/AGENTS.md"

  printf '\nDotfiles installation complete.\n'
}

main "$@"
