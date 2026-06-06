#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"
SKILL_ROOT="$REPO_ROOT/.agents/skills/premium-web-workflow"
SKILL_FILE="$SKILL_ROOT/SKILL.md"
OPENAI_YAML="$SKILL_ROOT/agents/openai.yaml"
REFERENCE="$SKILL_ROOT/references/frontend-quality.md"

required_paths=(
  "$REPO_ROOT/AGENTS.md"
  "$REPO_ROOT/README.md"
  "$REPO_ROOT/.gitattributes"
  "$REPO_ROOT/.gitignore"
  "$REPO_ROOT/scripts/install.ps1"
  "$REPO_ROOT/scripts/install.sh"
  "$REPO_ROOT/scripts/validate.ps1"
  "$REPO_ROOT/scripts/validate.sh"
  "$SKILL_FILE"
  "$OPENAI_YAML"
  "$REFERENCE"
)

for path in "${required_paths[@]}"; do
  if [[ ! -e "$path" ]]; then
    echo "missing required path: $path" >&2
    exit 1
  fi
done

if [[ "$(head -n 1 "$SKILL_FILE")" != "---" ]]; then
  echo "SKILL.md missing opening frontmatter" >&2
  exit 1
fi

frontmatter_end="$(awk 'NR > 1 && $0 == "---" { print NR; exit }' "$SKILL_FILE")"
if [[ -z "$frontmatter_end" ]]; then
  echo "SKILL.md missing closing frontmatter" >&2
  exit 1
fi

frontmatter="$(sed -n "2,$((frontmatter_end - 1))p" "$SKILL_FILE")"
frontmatter_chars="$(printf "%s" "$frontmatter" | wc -c | tr -d ' ')"
if [[ "$frontmatter_chars" -gt 1024 ]]; then
  echo "SKILL.md frontmatter exceeds 1024 characters" >&2
  exit 1
fi

grep -qx 'name: premium-web-workflow' <<<"$frontmatter" || {
  echo "SKILL.md name must be premium-web-workflow" >&2
  exit 1
}

grep -q '^description: Use when' <<<"$frontmatter" || {
  echo "SKILL.md description must start with 'Use when'" >&2
  exit 1
}

grep -q 'references/frontend-quality.md' "$SKILL_FILE" || {
  echo "SKILL.md must reference references/frontend-quality.md" >&2
  exit 1
}

grep -q '\$premium-web-workflow' "$OPENAI_YAML" || {
  echo "openai.yaml missing default prompt trigger" >&2
  exit 1
}

old_skill="premium-3d""-frontend"
old_serena="Serena"" MCP"
misspelled_python="Phy""ton"
pending_marker="TO""DO"
brief_marker="T""BD"
stale_regex="$old_skill|$old_serena|$misspelled_python|$pending_marker|$brief_marker"

if grep -RniE "$stale_regex" \
  "$REPO_ROOT/AGENTS.md" \
  "$REPO_ROOT/README.md" \
  "$REPO_ROOT/.gitattributes" \
  "$REPO_ROOT/.gitignore" \
  "$REPO_ROOT/scripts/install.ps1" \
  "$REPO_ROOT/scripts/install.sh" \
  "$REPO_ROOT/.agents/skills"; then
  echo "found stale markers" >&2
  exit 1
fi

if command -v git >/dev/null 2>&1 && [[ -d "$REPO_ROOT/.git" ]]; then
  git -C "$REPO_ROOT" diff --check
fi

echo "validation OK"
