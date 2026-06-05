# Reusable Codex Agent Skill Package

This repository contains reusable Codex guidance for premium web projects.

## Contents

- `AGENTS.md` - project-level Codex instructions template.
- `.agents/skills/premium-web-workflow/SKILL.md` - repo-scoped skill for premium web build, review, refactor, accessibility, security, 3D/canvas, and verification workflows.
- `.agents/skills/premium-web-workflow/agents/openai.yaml` - skill UI metadata and default prompt.

## Install In A Project

1. Copy `AGENTS.md` into the project root.
2. Copy `.agents/skills/premium-web-workflow` into the project's `.agents/skills/` folder.
3. Start a new Codex session or reload the workspace so the skill is discovered.
4. Use `$premium-web-workflow` when you want to force this workflow, or let Codex trigger it from the task context.

## Global Install

Copy `.agents/skills/premium-web-workflow` into your global Codex skills folder:

```powershell
Copy-Item -Recurse -Force .\.agents\skills\premium-web-workflow "$env:USERPROFILE\.agents\skills\premium-web-workflow"
```

Use the repo-scoped install when a project should carry the skill with it. Use the global install when you want the same workflow available across many projects.
