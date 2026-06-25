#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  cat <<'USAGE'
usage: ./install.sh

Installs the harness-agnostic agent workflow.

Options:
  -h, --help  Show this help.
USAGE
}

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
  local skill_source="$repo_root/skills/$skill_name"

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

install_bins() {
  local script

  for script in "$repo_root"/bin/*; do
    [[ -f "$script" ]] || continue
    chmod +x "$script"
    link_file "$script" "$HOME/.local/bin/$(basename "$script")"
  done
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h|--help)
        usage
        exit 0
        ;;
      *)
        printf 'unknown option: %s\n\n' "$1" >&2
        usage >&2
        exit 2
        ;;
    esac
    shift
  done
}

main() {
  parse_args "$@"

  local config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
  local global_agents_source="$repo_root/agents/AGENTS.md"

  ensure_dir "$HOME/.local/bin"
  ensure_dir "$HOME/.agents"
  ensure_dir "$HOME/.agents/skills"
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

  install_bins
  link_file "$global_agents_source" "$config_home/ai-agents/AGENTS.md"

  # Agent prompt entry points intentionally point to one canonical AGENTS.md file.
  link_file "$global_agents_source" "$HOME/.agents/AGENTS.md"
  link_file "$global_agents_source" "$config_home/AGENTS.md"
  link_file "$global_agents_source" "$config_home/claude/CLAUDE.md"
  link_file "$global_agents_source" "$config_home/claude/AGENTS.md"
  link_file "$global_agents_source" "$HOME/.claude/CLAUDE.md"
  link_file "$global_agents_source" "$HOME/.claude/AGENTS.md"
  link_file "$global_agents_source" "$config_home/codex/AGENTS.md"
  link_file "$global_agents_source" "$HOME/.codex/AGENTS.md"
  link_file "$global_agents_source" "$HOME/.gemini/GEMINI.md"
  link_file "$global_agents_source" "$HOME/.gemini/AGENTS.md"

  # Install shared skills into common harness-specific and neutral locations.
  install_skill "project-guide"
  install_skill "task-artifact"
  install_skill "handoff-contract"
  install_skill "task-resume"
  install_skill "lavish-planning"
  install_skill "git-commit"

  printf '\nAgent workflow installation complete.\n'
}

main "$@"
