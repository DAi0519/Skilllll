#!/usr/bin/env bash
set -e

REPO="DAi0519/Skilllll"
BRANCH="main"
SKILL_NAME="prd"
BASE_URL="https://raw.githubusercontent.com/${REPO}/${BRANCH}"
INSTALL_DIR="${HOME}/.claude/skills/${SKILL_NAME}"
REFS_DIR="${INSTALL_DIR}/references"

echo "Installing Claude Code skill: /${SKILL_NAME}"

mkdir -p "${INSTALL_DIR}"
mkdir -p "${REFS_DIR}"

curl -fsSL "${BASE_URL}/PRD/SKILL.md" -o "${INSTALL_DIR}/SKILL.md"

for file in \
  ai-product-output-standard.md \
  discovery-questions.md \
  feature-prd-template.md \
  issues-template.md \
  plan-template.md \
  prd-template.md; do
  curl -fsSL "${BASE_URL}/PRD/references/${file}" -o "${REFS_DIR}/${file}"
done

echo ""
echo "Installed to: ${INSTALL_DIR}"
echo "Restart Claude Code and type /prd to get started."
