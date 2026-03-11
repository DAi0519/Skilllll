#!/usr/bin/env sh
set -eu

REPO="${REPO:-DAi0519/Skilllll}"
BRANCH="${BRANCH:-main}"
SKILL_NAME="${SKILL_NAME:-prd}"
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

install_target() {
  target_key="$1"

  case "$target_key" in
    claude)
      install_dir="${HOME}/.claude/skills/${SKILL_NAME}"
      target_name="Claude Code"
      ;;
    codex)
      install_dir="$(resolve_codex_home)/skills/${SKILL_NAME}"
      target_name="Codex"
      ;;
    *)
      echo "Error: unsupported install target: ${target_key}" >&2
      exit 1
      ;;
  esac

  refs_dir="${install_dir}/references"
  echo "Updating ${target_name} skill: /${SKILL_NAME}"

  mkdir -p "${install_dir}" "${refs_dir}"

  download_file "${BASE_URL}/PRD/SKILL.md" "${install_dir}/SKILL.md"

  for file in \
    ai-product-output-standard.md \
    discovery-questions.md \
    feature-prd-template.md \
    issues-template.md \
    plan-template.md \
    prd-template.md; do
    download_file "${BASE_URL}/PRD/references/${file}" "${refs_dir}/${file}"
  done

  UPDATED_TARGETS="${UPDATED_TARGETS}${target_name}|${install_dir}\n"
}

print_summary() {
  if [ -n "${UPDATED_TARGETS}" ]; then
    printf '\nUpdated:\n'
    printf '%b' "${UPDATED_TARGETS}" | while IFS='|' read -r name path; do
      [ -n "${name}" ] || continue
      printf -- '- %s: %s\n' "$name" "$path"
    done
  fi
}

UPDATED_TARGETS=""

case "$TARGET" in
  claude)
    install_target "claude"
    ;;
  codex)
    install_target "codex"
    ;;
  auto)
    installed_any=0
    if has_claude; then
      install_target "claude"
      installed_any=1
    fi
    if has_codex; then
      install_target "codex"
      installed_any=1
    fi
    if [ "$installed_any" -eq 0 ]; then
      install_target "claude"
    fi
    ;;
  *)
    echo "Error: TARGET must be one of auto, codex, claude." >&2
    exit 1
    ;;
esac

print_summary

if [ -n "${UPDATED_TARGETS}" ]; then
  printf '\nDone.\n'
fi
