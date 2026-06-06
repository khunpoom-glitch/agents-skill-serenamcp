param(
  [string]$ProjectPath = (Get-Location).Path,
  [switch]$Project,
  [switch]$Global,
  [switch]$Force
)

$ErrorActionPreference = "Stop"

if (-not $Project -and -not $Global) {
  $Project = $true
}

$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$SourceAgents = Join-Path $RepoRoot.Path "AGENTS.md"
$SourceSkill = Join-Path $RepoRoot.Path ".agents\skills\premium-web-workflow"

function Assert-Inside {
  param(
    [string]$Path,
    [string]$Root,
    [string]$Label
  )

  $resolvedRoot = (Resolve-Path -LiteralPath $Root).Path
  $fullPath = [System.IO.Path]::GetFullPath($Path)
  if (-not $fullPath.StartsWith($resolvedRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "$Label path is outside expected root: $fullPath"
  }
}

function Copy-FileSafely {
  param(
    [string]$Source,
    [string]$Destination,
    [switch]$ForceWrite
  )

  $destDir = Split-Path -Parent $Destination
  New-Item -ItemType Directory -Path $destDir -Force | Out-Null

  if (Test-Path -LiteralPath $Destination) {
    $sourceHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $Source).Hash
    $destHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $Destination).Hash
    if ($sourceHash -eq $destHash) {
      Write-Host "unchanged $Destination"
      return
    }

    if (-not $ForceWrite) {
      $incoming = "$Destination.incoming"
      Copy-Item -LiteralPath $Source -Destination $incoming -Force
      Write-Host "kept existing $Destination"
      Write-Host "wrote incoming template $incoming"
      return
    }
  }

  Copy-Item -LiteralPath $Source -Destination $Destination -Force
  Write-Host "installed $Destination"
}

function Test-DirectorySame {
  param(
    [string]$Source,
    [string]$Destination
  )

  if (-not (Test-Path -LiteralPath $Destination)) {
    return $false
  }

  $sourceRoot = (Resolve-Path -LiteralPath $Source).Path
  $destRoot = (Resolve-Path -LiteralPath $Destination).Path
  $sourceFiles = Get-ChildItem -LiteralPath $sourceRoot -Recurse -File
  $destFiles = Get-ChildItem -LiteralPath $destRoot -Recurse -File

  if ($sourceFiles.Count -ne $destFiles.Count) {
    return $false
  }

  $destByRelative = @{}
  foreach ($file in $destFiles) {
    $relative = $file.FullName.Substring($destRoot.Length).TrimStart("\")
    $destByRelative[$relative] = $file.FullName
  }

  foreach ($file in $sourceFiles) {
    $relative = $file.FullName.Substring($sourceRoot.Length).TrimStart("\")
    if (-not $destByRelative.ContainsKey($relative)) {
      return $false
    }

    $sourceHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $file.FullName).Hash
    $destHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $destByRelative[$relative]).Hash
    if ($sourceHash -ne $destHash) {
      return $false
    }
  }

  return $true
}

function Copy-DirectorySafely {
  param(
    [string]$Source,
    [string]$Destination,
    [string]$AllowedRoot,
    [switch]$ForceWrite
  )

  New-Item -ItemType Directory -Path (Split-Path -Parent $Destination) -Force | Out-Null

  if (Test-Path -LiteralPath $Destination) {
    if (Test-DirectorySame -Source $Source -Destination $Destination) {
      Write-Host "unchanged $Destination"
      return
    }

    if (-not $ForceWrite) {
      $stamp = Get-Date -Format "yyyyMMddHHmmss"
      $incoming = "$Destination.incoming-$stamp"
      $incoming = "$incoming-$PID"
      Copy-Item -LiteralPath $Source -Destination $incoming -Recurse -Force
      Write-Host "kept existing $Destination"
      Write-Host "wrote incoming skill $incoming"
      return
    }

    Assert-Inside -Path $Destination -Root $AllowedRoot -Label "Destination"
    Remove-Item -LiteralPath $Destination -Recurse -Force
  }

  Copy-Item -LiteralPath $Source -Destination $Destination -Recurse -Force
  Write-Host "installed $Destination"
}

if ($Project) {
  $ProjectRoot = Resolve-Path -LiteralPath $ProjectPath
  $ProjectSkillRoot = Join-Path $ProjectRoot.Path ".agents\skills"
  $ProjectSkill = Join-Path $ProjectSkillRoot "premium-web-workflow"
  $ProjectAgents = Join-Path $ProjectRoot.Path "AGENTS.md"

  Copy-FileSafely -Source $SourceAgents -Destination $ProjectAgents -ForceWrite:$Force
  Copy-DirectorySafely -Source $SourceSkill -Destination $ProjectSkill -AllowedRoot $ProjectSkillRoot -ForceWrite:$Force
}

if ($Global) {
  $GlobalSkillRoot = Join-Path $env:USERPROFILE ".agents\skills"
  $GlobalSkill = Join-Path $GlobalSkillRoot "premium-web-workflow"

  Copy-DirectorySafely -Source $SourceSkill -Destination $GlobalSkill -AllowedRoot $GlobalSkillRoot -ForceWrite:$Force
}

Write-Host "install complete"
