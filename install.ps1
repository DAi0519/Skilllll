$ErrorActionPreference = "Stop"

$REPO   = "DAi0519/Skilllll"
$BRANCH = "main"
$SKILL  = "prd"
$BASE   = "https://raw.githubusercontent.com/$REPO/$BRANCH"
$DEST   = "$env:USERPROFILE\.claude\skills\$SKILL"
$REFS   = "$DEST\references"

Write-Host "Installing Claude Code skill: /$SKILL"

New-Item -ItemType Directory -Force -Path $DEST | Out-Null
New-Item -ItemType Directory -Force -Path $REFS | Out-Null

Invoke-WebRequest -Uri "$BASE/PRD/SKILL.md" -OutFile "$DEST\SKILL.md"

$files = @(
  "ai-product-output-standard.md",
  "discovery-questions.md",
  "feature-prd-template.md",
  "issues-template.md",
  "plan-template.md",
  "prd-template.md"
)

foreach ($f in $files) {
  Invoke-WebRequest -Uri "$BASE/PRD/references/$f" -OutFile "$REFS\$f"
}

Write-Host ""
Write-Host "Installed to: $DEST"
Write-Host "Restart Claude Code and type /prd to get started."
