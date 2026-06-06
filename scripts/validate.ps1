param(
  [string]$Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$ErrorActionPreference = "Stop"

$RepoRoot = Resolve-Path -LiteralPath $Root
$SkillRoot = Join-Path $RepoRoot.Path ".agents\skills\premium-web-workflow"
$SkillFile = Join-Path $SkillRoot "SKILL.md"
$OpenAiYaml = Join-Path $SkillRoot "agents\openai.yaml"
$Reference = Join-Path $SkillRoot "references\frontend-quality.md"

$Required = @(
  "AGENTS.md",
  "README.md",
  ".gitattributes",
  ".gitignore",
  "scripts\install.ps1",
  "scripts\install.sh",
  "scripts\validate.ps1",
  "scripts\validate.sh",
  ".agents\skills\premium-web-workflow\SKILL.md",
  ".agents\skills\premium-web-workflow\agents\openai.yaml",
  ".agents\skills\premium-web-workflow\references\frontend-quality.md"
)

foreach ($relative in $Required) {
  $path = Join-Path $RepoRoot.Path $relative
  if (-not (Test-Path -LiteralPath $path)) {
    throw "Missing required path: $relative"
  }
}

$skill = Get-Content -Raw -Encoding UTF8 -LiteralPath $SkillFile
if (-not $skill.StartsWith("---`n")) {
  throw "SKILL.md missing opening frontmatter"
}

$frontmatterEnd = $skill.IndexOf("`n---`n", 4)
if ($frontmatterEnd -lt 0) {
  throw "SKILL.md missing closing frontmatter"
}

$frontmatter = $skill.Substring(4, $frontmatterEnd - 4)
if ($frontmatter.Length -gt 1024) {
  throw "SKILL.md frontmatter exceeds 1024 characters"
}

if ($frontmatter -notmatch "(?m)^name: premium-web-workflow$") {
  throw "SKILL.md name must be premium-web-workflow"
}

if ($frontmatter -notmatch "(?m)^description: Use when") {
  throw "SKILL.md description must start with 'Use when'"
}

if ($skill -notmatch "references/frontend-quality\.md") {
  throw "SKILL.md must reference references/frontend-quality.md"
}

$yaml = Get-Content -Raw -Encoding UTF8 -LiteralPath $OpenAiYaml
if (-not $yaml.Contains('$premium-web-workflow')) {
  throw "openai.yaml missing `$premium-web-workflow default prompt trigger"
}

$searchPaths = @(
  (Join-Path $RepoRoot.Path "AGENTS.md"),
  (Join-Path $RepoRoot.Path "README.md"),
  (Join-Path $RepoRoot.Path ".gitattributes"),
  (Join-Path $RepoRoot.Path ".gitignore"),
  (Join-Path $RepoRoot.Path "scripts\install.ps1"),
  (Join-Path $RepoRoot.Path "scripts\install.sh"),
  (Join-Path $RepoRoot.Path ".agents\skills")
)

$searchFiles = foreach ($path in $searchPaths) {
  if ((Get-Item -LiteralPath $path).PSIsContainer) {
    Get-ChildItem -LiteralPath $path -Recurse -File
  } else {
    Get-Item -LiteralPath $path
  }
}

$stalePatterns = @(
  ("premium" + "-3d-frontend"),
  ("Serena" + " MCP"),
  ("Phy" + "ton"),
  ("TO" + "DO"),
  ("T" + "BD")
)

$matches = Select-String -Path $searchFiles.FullName -Pattern $stalePatterns -CaseSensitive:$false -ErrorAction SilentlyContinue
if ($matches) {
  $joined = ($matches | ForEach-Object { "$($_.Path):$($_.LineNumber): $($_.Line)" }) -join "`n"
  throw "Found stale markers:`n$joined"
}

Write-Host "validation OK"
