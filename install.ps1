$ErrorActionPreference = "Stop"

$REPO   = "DAi0519/Skilllll"
$BRANCH = "main"
$SKILL  = "prd"
$BASE   = "https://raw.githubusercontent.com/$REPO/$BRANCH"
$TARGET = if ($env:TARGET) { $env:TARGET } else { "auto" }

$REFS_FILES = @(
  "ai-product-output-standard.md",
  "discovery-questions.md",
  "feature-prd-template.md",
  "issues-template.md",
  "plan-template.md",
  "prd-template.md"
)

function Has-Claude {
  $null -ne (Get-Command claude -ErrorAction SilentlyContinue)
}

function Has-Codex {
  $env:CODEX_HOME -or ($null -ne (Get-Command codex -ErrorAction SilentlyContinue))
}

function Resolve-CodexHome {
  if ($env:CODEX_HOME) { $env:CODEX_HOME } else { "$env:USERPROFILE\.codex" }
}

function Install-Target {
  param($TargetKey)

  switch ($TargetKey) {
    "claude" {
      $dest = "$env:USERPROFILE\.claude\skills\$SKILL"
      $label = "Claude Code"
    }
    "codex" {
      $dest = "$(Resolve-CodexHome)\skills\$SKILL"
      $label = "Codex"
    }
    default {
      Write-Error "Unsupported target: $TargetKey"
      exit 1
    }
  }

  $refs = "$dest\references"
  Write-Host "Updating $label skill: /$SKILL"

  New-Item -ItemType Directory -Force -Path $dest | Out-Null
  New-Item -ItemType Directory -Force -Path $refs | Out-Null

  Invoke-WebRequest -Uri "$BASE/PRD/SKILL.md" -OutFile "$dest\SKILL.md"

  foreach ($f in $REFS_FILES) {
    Invoke-WebRequest -Uri "$BASE/PRD/references/$f" -OutFile "$refs\$f"
  }

  Write-Host "  -> $dest"
}

switch ($TARGET) {
  "claude" { Install-Target "claude" }
  "codex"  { Install-Target "codex" }
  "auto"   {
    $installed = $false
    if (Has-Claude) { Install-Target "claude"; $installed = $true }
    if (Has-Codex)  { Install-Target "codex";  $installed = $true }
    if (-not $installed) { Install-Target "claude" }
  }
  default {
    Write-Error "TARGET must be one of: auto, claude, codex"
    exit 1
  }
}

Write-Host ""
Write-Host "Done. Restart your tool and type /prd to get started."
