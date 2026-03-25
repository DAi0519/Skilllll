#!/usr/bin/env sh
set -eu

REPO="${REPO:-DAi0519/Skilllll}"
BRANCH="${BRANCH:-main}"
SKILL="${SKILL:-all}"
TARGET="${TARGET:-auto}"
BASE_URL="https://raw.githubusercontent.com/${REPO}/${BRANCH}"

download_file() {
  url="$1"
  output="$2"

  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$url" -o "$output"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO "$output" "$url"
  else
    echo "Error: curl or wget is required to install this skill." >&2
    exit 1
  fi
}

resolve_codex_home() {
  printf '%s\n' "${CODEX_HOME:-${HOME}/.codex}"
}

has_claude() {
  command -v claude >/dev/null 2>&1
}

has_codex() {
  [ -n "${CODEX_HOME:-}" ] || command -v codex >/dev/null 2>&1
}

install_skill() {
  skill_name="$1"
  repo_dir="$2"
  target_key="$3"

  case "$target_key" in
    claude)
      install_dir="${HOME}/.claude/skills/${skill_name}"
      target_name="Claude Code"
      ;;
    codex)
      install_dir="$(resolve_codex_home)/skills/${skill_name}"
      target_name="Codex"
      ;;
    *)
      echo "Error: unsupported install target: ${target_key}" >&2
      exit 1
      ;;
  esac

  refs_dir="${install_dir}/references"
  echo "Installing ${target_name} skill: /${skill_name}"

  mkdir -p "${install_dir}" "${refs_dir}"

  download_file "${BASE_URL}/${repo_dir}/SKILL.md" "${install_dir}/SKILL.md"

  # Download all reference files for this skill
  case "$skill_name" in
    prd)
      for file in \
        ai-product-output-standard.md \
        discovery-questions.md \
        feature-prd-template.md \
        issues-template.md \
        plan-template.md \
        prd-template.md; do
        download_file "${BASE_URL}/${repo_dir}/references/${file}" "${refs_dir}/${file}"
      done
      ;;
    design-system)
      for file in \
        color-system.md \
        component-architecture.md \
        design-system-checklist.md \
        design-tokens.md \
        documentation-guide.md \
        icon-system.md \
        spacing-and-layout.md \
        tech-implementation.md \
        typography-system.md \
        visual-quality.md; do
        download_file "${BASE_URL}/${repo_dir}/references/${file}" "${refs_dir}/${file}"
      done
      ;;
  esac

  UPDATED_TARGETS="${UPDATED_TARGETS}${target_name} /${skill_name}: ${install_dir}\n"
}

install_for_target() {
  target_key="$1"

  case "$SKILL" in
    all)
      install_skill "prd" "PRD" "$target_key"
      install_skill "design-system" "Design-system" "$target_key"
      ;;
    prd)
      install_skill "prd" "PRD" "$target_key"
      ;;
    design-system)
      install_skill "design-system" "Design-system" "$target_key"
      ;;
    *)
      echo "Error: unknown skill '${SKILL}'. Available: prd, design-system, all" >&2
      exit 1
      ;;
  esac
}

UPDATED_TARGETS=""

case "$TARGET" in
  claude)
    install_for_target "claude"
    ;;
  codex)
    install_for_target "codex"
    ;;
  auto)
    installed_any=0
    if has_claude; then
      install_for_target "claude"
      installed_any=1
    fi
    if has_codex; then
      install_for_target "codex"
      installed_any=1
    fi
    if [ "$installed_any" -eq 0 ]; then
      install_for_target "claude"
    fi
    ;;
  *)
    echo "Error: TARGET must be one of auto, codex, claude." >&2
    exit 1
    ;;
esac

if [ -n "${UPDATED_TARGETS}" ]; then
  printf '\nInstalled:\n'
  printf '%b' "${UPDATED_TARGETS}"
  printf '\nDone. Restart your tool to use the new skills.\n'
fi
