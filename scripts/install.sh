#!/usr/bin/env bash
set -euo pipefail

PROJECT_PATH="$(pwd)"
INSTALL_PROJECT=0
INSTALL_GLOBAL=0
FORCE=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --project)
      INSTALL_PROJECT=1
      if [[ $# -gt 1 && "$2" != --* ]]; then
        PROJECT_PATH="$2"
        shift
      fi
      ;;
    --global)
      INSTALL_GLOBAL=1
      ;;
    --force)
      FORCE=1
      ;;
    -h|--help)
      cat <<'HELP'
Usage:
  bash scripts/install.sh --project /path/to/project
  bash scripts/install.sh --global
  bash scripts/install.sh --project /path/to/project --global
  bash scripts/install.sh --project /path/to/project --force

Defaults to --project for the current directory when no install mode is set.
Existing different files are kept and incoming copies are written unless --force is used.
HELP
      exit 0
      ;;
    *)
      echo "unknown option: $1" >&2
      exit 2
      ;;
  esac
  shift
done

if [[ "$INSTALL_PROJECT" -eq 0 && "$INSTALL_GLOBAL" -eq 0 ]]; then
  INSTALL_PROJECT=1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"
SOURCE_AGENTS="$REPO_ROOT/AGENTS.md"
SOURCE_SKILL="$REPO_ROOT/.agents/skills/premium-web-workflow"

hash_file() {
  if command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$1" | awk '{print $1}'
  elif command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{print $1}'
  else
    echo "missing shasum or sha256sum" >&2
    exit 1
  fi
}

assert_inside() {
  local path="$1"
  local root="$2"
  local label="$3"
  local real_root
  local real_path

  mkdir -p "$root"
  real_root="$(cd "$root" && pwd -P)"
  real_path="$(cd "$path" && pwd -P)"

  case "$real_path" in
    "$real_root"|"$real_root"/*) ;;
    *)
      echo "$label path is outside expected root: $real_path" >&2
      exit 1
      ;;
  esac
}

copy_file_safely() {
  local source="$1"
  local destination="$2"
  mkdir -p "$(dirname "$destination")"

  if [[ -f "$destination" ]]; then
    if [[ "$(hash_file "$source")" == "$(hash_file "$destination")" ]]; then
      echo "unchanged $destination"
      return
    fi

    if [[ "$FORCE" -eq 0 ]]; then
      cp "$source" "$destination.incoming"
      echo "kept existing $destination"
      echo "wrote incoming template $destination.incoming"
      return
    fi
  fi

  cp "$source" "$destination"
  echo "installed $destination"
}

copy_directory_safely() {
  local source="$1"
  local destination="$2"
  local allowed_root="$3"
  mkdir -p "$(dirname "$destination")"

  if [[ -d "$destination" ]]; then
    if diff -qr "$source" "$destination" >/dev/null 2>&1; then
      echo "unchanged $destination"
      return
    fi

    if [[ "$FORCE" -eq 0 ]]; then
      local incoming="$destination.incoming-$(date +%Y%m%d%H%M%S)-$$"
      cp -R "$source" "$incoming"
      echo "kept existing $destination"
      echo "wrote incoming skill $incoming"
      return
    fi

    assert_inside "$destination" "$allowed_root" "Destination"
    rm -rf "$destination"
  fi

  cp -R "$source" "$destination"
  echo "installed $destination"
}

if [[ "$INSTALL_PROJECT" -eq 1 ]]; then
  PROJECT_ROOT="$(cd "$PROJECT_PATH" && pwd -P)"
  PROJECT_SKILL_ROOT="$PROJECT_ROOT/.agents/skills"

  copy_file_safely "$SOURCE_AGENTS" "$PROJECT_ROOT/AGENTS.md"
  copy_directory_safely "$SOURCE_SKILL" "$PROJECT_SKILL_ROOT/premium-web-workflow" "$PROJECT_SKILL_ROOT"
fi

if [[ "$INSTALL_GLOBAL" -eq 1 ]]; then
  GLOBAL_SKILL_ROOT="$HOME/.agents/skills"
  copy_directory_safely "$SOURCE_SKILL" "$GLOBAL_SKILL_ROOT/premium-web-workflow" "$GLOBAL_SKILL_ROOT"
fi

echo "install complete"
