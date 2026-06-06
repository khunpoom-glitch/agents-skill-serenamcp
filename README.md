# Reusable Codex Agent Skill Package

This repository contains reusable Codex guidance for project setup and premium web workflows.

## Contents

- `AGENTS.md` - project-level Codex instructions template.
- `.agents/skills/premium-web-workflow/SKILL.md` - repo-scoped skill for premium web build, review, refactor, accessibility, security, 3D/canvas, and verification workflows.
- `.agents/skills/premium-web-workflow/agents/openai.yaml` - skill UI metadata and default prompt.
- `.agents/skills/premium-web-workflow/references/frontend-quality.md` - optional deep reference loaded only for frontend quality, visual QA, accessibility, security, or 3D/canvas tasks.
- `scripts/install.ps1` - safe installer for project-scoped and global skill installation on Windows.
- `scripts/install.sh` - safe installer for project-scoped and global skill installation on macOS/Linux.
- `scripts/validate.ps1` and `scripts/validate.sh` - package validation scripts.
- `.gitattributes` - normalizes line endings so files stay stable across machines.
- `.gitignore` - keeps installer test outputs and local OS metadata out of commits.

## Clone

Windows PowerShell:

```powershell
git clone https://github.com/khunpoom-glitch/agents-skill-serenamcp.git
cd agents-skill-serenamcp
```

macOS/Linux:

```bash
git clone https://github.com/khunpoom-glitch/agents-skill-serenamcp.git
cd agents-skill-serenamcp
```

## Install In A Project

Windows:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1 -Project -ProjectPath "D:\path\to\your-project"
```

macOS/Linux:

```bash
bash ./scripts/install.sh --project /path/to/your-project
```

This installs:

- `AGENTS.md` into the project root.
- the full `.agents/skills/premium-web-workflow` folder into the project, including `agents/` and `references/`.

If `AGENTS.md` or the skill already exists, the script keeps the existing files and writes `.incoming` copies for manual review. Use `-Force` on Windows or `--force` on macOS/Linux only when you intentionally want to overwrite.

## Global Install

Install the skill once for all projects on the same machine.

Windows:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1 -Global
```

macOS/Linux:

```bash
bash ./scripts/install.sh --global
```

Install into both the current project and the global skills folder.

Windows:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1 -Project -Global -ProjectPath "D:\path\to\your-project"
```

macOS/Linux:

```bash
bash ./scripts/install.sh --project /path/to/your-project --global
```

Use the repo-scoped install when a project should carry the skill with it. Use the global install when you want the same workflow available across many projects.

After installing, start a new Codex session or reload the workspace so `AGENTS.md` and `$premium-web-workflow` are discovered.

## Validate

Windows:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\validate.ps1
```

macOS/Linux:

```bash
bash ./scripts/validate.sh
```

## Codex Prompt

Use this prompt in a new project:

```text
Please install the reusable Codex agent/skill package from:
https://github.com/khunpoom-glitch/agents-skill-serenamcp

Install it into the current project. If this machine supports shell scripts, use the installer:
- Windows: scripts/install.ps1
- macOS/Linux: scripts/install.sh

Requirements:
- Put AGENTS.md at the project root.
- Copy the full .agents/skills/premium-web-workflow folder, including agents/ and references/.
- If files already exist, do not overwrite silently. Keep existing files and create .incoming copies for manual merge.
- Validate that SKILL.md has name: premium-web-workflow.
- Summarize installed paths and explain how to use $premium-web-workflow.
- Remind me to start a new Codex session or reload the workspace after install.
```
