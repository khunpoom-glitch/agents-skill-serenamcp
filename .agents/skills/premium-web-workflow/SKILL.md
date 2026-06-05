---
name: premium-web-workflow
description: Use when building, redesigning, reviewing, or refining premium web work with HTML, CSS, JavaScript, TypeScript, React, Vite, Tailwind, Python automation, meaningful 3D/canvas depth, responsive polish, accessibility checks, security review, refactor planning, or repeated context-saving workflow guidance.
---

# Premium Web Frontend Workflow

A focused web workflow for this repo: use it to build or review premium HTML/CSS/JavaScript/TypeScript/React interfaces, support Python automation, preserve the project's cinematic 3D direction, and reduce repeated prompting by keeping reusable web quality checks in one place.

## Overview

Use this skill as reusable procedural memory for web and supporting automation work that would otherwise require repeated long prompts. `AGENTS.md` owns the project-wide workflow and rules; this `SKILL.md` specializes them for HTML, CSS, JavaScript, TypeScript, React, Python scripting, visual polish, 3D/canvas, security, refactor, and verification work.

## Workflow

Follow the canonical `Ask -> Plan -> Implement -> Review Diff -> Run/Test -> Commit` workflow in `AGENTS.md`. Apply these web-specific checks while moving through it:

1. Ask: inspect targeted files with `rg` or `rg --files`; ask before new production dependencies, TypeScript migration, destructive file operations, database changes, broad design shifts, or unclear commit scope.
2. Plan: identify the task mode, active stack, expected files, validation commands, viewport checks, accessibility concerns, and key risks.
3. Implement: match existing HTML, CSS, React, Vite, Tailwind CSS, JavaScript/JSX, TypeScript/TSX, Python, and folder conventions. Prefer existing dependencies and keep edits focused.
4. Review Diff: inspect the actual diff for component structure, responsive behavior, accessibility, security, text fit, layout stability, duplicate logic, generated files, ignored files, and user-change preservation.
5. Run/Test: run the relevant project scripts. For visual or 3D work, also use a local browser check at one desktop and one mobile viewport. For Python scripts, run the narrowest safe command that exercises the changed path.
6. Commit: commit only when requested or when the task is explicitly a publish workflow. Stage only intended paths, including ignored `.agents/` files only when the instruction update is in scope.

## Language Playbook

| Area | Use This Judgment |
| --- | --- |
| HTML | Start with semantic elements, valid nesting, heading order, form labels, alt text, and keyboard-friendly structure before adding ARIA. |
| CSS | Reason about cascade, specificity, layout, overflow, responsive constraints, browser support, and reduced motion. Prefer Tailwind utilities when they match local style; use shared CSS for tokens, resets, and cross-cutting rules. |
| JavaScript | Use ES modules, small pure helpers, explicit async control flow, clear error paths, and boundary validation. Avoid hidden globals and DOM manipulation that fights React. |
| TypeScript | Use only when already present or approved. Favor precise boundary types, `unknown` for external data, discriminated unions for UI state, and type guards instead of broad `any`. |
| React | Keep components focused, props explicit, state close to where it is used, effects reserved for side effects, and lists keyed by stable IDs. Include loading, empty, error, and success states for user flows. |
| Python | Use for repeatable automation, data transforms, asset processing, smoke checks, and scripts. Prefer `pathlib`, `argparse`, type hints for non-trivial code, environment variables for secrets, and safe path checks before destructive operations. |

## Experience Bar

- Treat the first viewport as a designed usable experience, not a placeholder landing page.
- Put the brand, product, place, object, or workflow in the first-viewport signal.
- Use strong composition, clear hierarchy, readable Thai/English typography, smooth motion, and restrained cinematic contrast.
- Keep palettes balanced. Avoid a UI that collapses into one hue family or purely decorative gradients.
- Use real images, generated bitmap assets, or rendered canvas/3D visuals when visual identity matters.
- Keep cards for repeated items, tools, and modals. Do not nest cards inside cards or turn page sections into floating card stacks.
- Use semantic HTML, accessible focus states, alt text where relevant, sufficient contrast, keyboard-friendly controls, and reduced-motion behavior.
- Default user-facing conversation to Thai when the user writes in Thai.

## 3D And Motion

- Make 3D meaningful: it should clarify the product, brand, workflow, object, or atmosphere.
- Integrate 3D scenes full-bleed or naturally into the hero/section instead of trapping them in tiny decorative previews.
- Ensure camera framing, lighting, shadows, materials, and depth cues read well on desktop and mobile.
- Add interaction only when useful: pointer parallax, hover states, scroll-linked camera movement, subtle idle animation, or stateful object response.
- Respect `prefers-reduced-motion`; provide calmer animation or static framing.
- Keep mobile GPU cost low. Limit heavy postprocessing, particle counts, real-time shadows, large textures, and unnecessary re-renders.
- If real 3D dependencies are absent, ask before installing them. For small visual depth needs, consider lightweight CSS perspective, SVG, or canvas techniques that fit the existing stack.

## Implementation Rules

- Keep application code in `src/`, reusable UI in `src/components/`, imported assets in `src/assets/`, and static public files in `public/` when those folders exist.
- Use JavaScript and JSX with modern ES modules. Use Tailwind utilities for component styling and `src/index.css` for shared/global CSS.
- For standalone HTML/CSS/JS work, keep structure, styling, and behavior separated unless a single-file artifact is explicitly requested.
- For TypeScript projects, keep types close to module boundaries and avoid type assertions that hide unvalidated data.
- For Python scripts, keep runtime code behind small functions and a `main` entry point, and make file operations explicit and reversible where practical.
- Separate rendering, state, validation, data access, and side effects. Keep reusable logic in small named helpers or hooks.
- Handle loading, empty, error, and success states for user-facing flows.
- Validate external input at boundaries and never hardcode secrets, tokens, credentials, private URLs, or API keys.
- Preserve user changes. Never revert, overwrite, or discard unrelated edits.
- Use lucide-react icons for familiar controls when available, with labels or tooltips where clarity requires it.
- Keep text inside its containers at mobile and desktop sizes. Use stable dimensions for canvases, boards, grids, toolbars, icon buttons, counters, and fixed-format tiles.

## Review And Refactor Checks

- For review tasks, inspect the actual diff or relevant files before giving recommendations.
- For frontend review, check component boundaries, responsive layout, accessibility, duplicate code, visual consistency, and whether 3D/canvas content blocks important UI.
- For HTML/CSS/JS/TS/React review, check semantics, layout stability, event handling, state ownership, effect dependencies, type safety, and runtime error paths.
- For Python review, check file/path safety, input validation, dependency assumptions, logging, exceptions, and whether scripts can be rerun safely.
- For security-sensitive UI, check user-supplied content, external links, forms, downloads, embeds, input validation, dependency risk, XSS exposure, and secrets in client code.
- For refactors, understand references before renaming or moving code. Propose a small plan, change one area at a time, and summarize the diff in practical language.
- For debugging, first identify the failing behavior and likely boundary, then inspect the smallest relevant slice of code before editing.

## Verification

Run the relevant checks from `package.json` after frontend changes. For this workspace, prefer:

```powershell
npm run build
npm run test
```

For visual or 3D changes, also start the dev server and inspect the rendered app:

```powershell
npm run dev
```

Confirm the page renders without console-breaking errors, the 3D/canvas area is nonblank, important text and controls are not covered, and layout works at one desktop viewport and one mobile viewport. If verification cannot run, state the reason and the remaining risk.

For Python scripts, run the narrowest safe command that exercises the changed path, for example:

```powershell
python path\to\script.py --help
python -m pytest path\to\test_file.py
```
