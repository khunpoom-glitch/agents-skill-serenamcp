---
name: premium-3d-frontend
description: Use when building, redesigning, reviewing, or refining React/Vite/Tailwind frontend work that needs premium cinematic UI, meaningful 3D/canvas depth, responsive polish, accessibility checks, security-conscious frontend review, refactor planning, or repeated context-saving workflow guidance.
---

# Premium 3D Frontend

A focused frontend workflow for this repo: use it to build or review premium React/Vite interfaces, preserve the project's cinematic 3D direction, and reduce repeated prompting by keeping common build, review, refactor, security, and verification rules in one reusable place.

## Overview

Use this skill as reusable procedural memory for frontend work that would otherwise require repeated long prompts. Let `AGENTS.md` hold project-wide rules; let this `SKILL.md` guide repeatable frontend build, review, security, refactor, and verification workflows.

## Workflow

1. Read the nearest `AGENTS.md` before editing, then inspect only targeted project files with `rg` or `rg --files`.
2. Identify the task mode: build, redesign, review, refactor, security check, migration plan, release note, or debugging flow.
3. Identify the active stack from `package.json`, existing components, CSS, scripts, and asset folders before choosing an implementation path.
4. Gather context deliberately. Read symbols, components, and references that matter; avoid opening whole projects, generated folders, dependency folders, build outputs, virtual environments, and archived vendor folders.
5. Match existing React, Vite, Tailwind CSS, JavaScript/JSX, and folder conventions. Do not introduce TypeScript unless the project already uses it or the user asks for it.
6. Prefer existing dependencies. Use Framer Motion and lucide-react when available. Ask before adding production dependencies, especially Three.js, React Three Fiber, Drei, physics, shaders, postprocessing, or asset pipeline packages.
7. Make focused edits in small steps, then review the result for component structure, responsive behavior, accessibility, duplicate code, obvious security risks, and visual polish.
8. Verify with the most relevant project scripts, usually `npm run build` and `npm run test` when present. For visual or 3D work, run a local dev server and check at least one desktop and one mobile viewport.

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
- Separate rendering, state, validation, data access, and side effects. Keep reusable logic in small named helpers or hooks.
- Handle loading, empty, error, and success states for user-facing flows.
- Validate external input at boundaries and never hardcode secrets, tokens, credentials, private URLs, or API keys.
- Preserve user changes. Never revert, overwrite, or discard unrelated edits.
- Use lucide-react icons for familiar controls when available, with labels or tooltips where clarity requires it.
- Keep text inside its containers at mobile and desktop sizes. Use stable dimensions for canvases, boards, grids, toolbars, icon buttons, counters, and fixed-format tiles.

## Review And Refactor Checks

- For review tasks, inspect the actual diff or relevant files before giving recommendations.
- For frontend review, check component boundaries, responsive layout, accessibility, duplicate code, visual consistency, and whether 3D/canvas content blocks important UI.
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
