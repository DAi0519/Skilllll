$ErrorActionPreference = "Stop"

$REPO   = "DAi0519/Skilllll"
$BRANCH = "main"
$SKILL  = if ($env:SKILL) { $env:SKILL } else { "all" }
$TARGET = if ($env:TARGET) { $env:TARGET } else { "auto" }
$BASE   = "https://raw.githubusercontent.com/$REPO/$BRANCH"

$SKILLS_REGISTRY = @{
  "prd" = @{
    RepoDir = "PRD"
    Refs = @(
      "ai-product-output-standard.md",
      "discovery-questions.md",
      "feature-prd-template.md",
      "issues-template.md",
      "plan-template.md",
      "prd-template.md"
    )
  }
  "design-system" = @{
    RepoDir = "Design-system"
    Refs = @(
      "anti-generic-heuristics.md",
      "color-system.md",
      "component-architecture.md",
      "design-md-writing-guide.md",
      "design-system-checklist.md",
      "design-tokens.md",
      "documentation-guide.md",
      "icon-system.md",
      "spacing-and-layout.md",
      "tech-implementation.md",
      "typography-system.md",
      "visual-quality.md"
    )
  }
}

function Has-Claude {
  $null -ne (Get-Command claude -ErrorAction SilentlyContinue)
}

function Has-Codex {
  $env:CODEX_HOME -or ($null -ne (Get-Command codex -ErrorAction SilentlyContinue))
}

function Resolve-CodexHome {
  if ($env:CODEX_HOME) { $env:CODEX_HOME } else { "$env:USERPROFILE\.codex" }
}

function Install-Skill {
  param($SkillName, $TargetKey)

  $info = $SKILLS_REGISTRY[$SkillName]

  switch ($TargetKey) {
    "claude" {
      $dest = "$env:USERPROFILE\.claude\skills\$SkillName"
      $label = "Claude Code"
    }
    "codex" {
      $dest = "$(Resolve-CodexHome)\skills\$SkillName"
      $label = "Codex"
    }
    default {
      Write-Error "Unsupported target: $TargetKey"
      exit 1
    }
  }

  $refs = "$dest\references"
  Write-Host "Installing $label skill: /$SkillName"

  New-Item -ItemType Directory -Force -Path $dest | Out-Null
  New-Item -ItemType Directory -Force -Path $refs | Out-Null

  $repoDir = $info.RepoDir
  Invoke-WebRequest -Uri "$BASE/$repoDir/SKILL.md" -OutFile "$dest\SKILL.md"

  foreach ($f in $info.Refs) {
    Invoke-WebRequest -Uri "$BASE/$repoDir/references/$f" -OutFile "$refs\$f"
  }

  Write-Host "  -> $dest"
}

function Install-ForTarget {
  param($TargetKey)

  $skillNames = if ($SKILL -eq "all") {
    $SKILLS_REGISTRY.Keys
  } else {
    if (-not $SKILLS_REGISTRY.ContainsKey($SKILL)) {
      Write-Error "Unknown skill '$SKILL'. Available: $($SKILLS_REGISTRY.Keys -join ', '), all"
      exit 1
    }
    @($SKILL)
  }

  foreach ($name in $skillNames) {
    Install-Skill -SkillName $name -TargetKey $TargetKey
  }
}

switch ($TARGET) {
  "claude" { Install-ForTarget "claude" }
  "codex"  { Install-ForTarget "codex" }
  "auto"   {
    $installed = $false
    if (Has-Claude) { Install-ForTarget "claude"; $installed = $true }
    if (Has-Codex)  { Install-ForTarget "codex";  $installed = $true }
    if (-not $installed) { Install-ForTarget "claude" }
  }
  default {
    Write-Error "TARGET must be one of: auto, claude, codex"
    exit 1
  }
}

Write-Host ""
Write-Host "Done. Restart your tool to use the new skills."
