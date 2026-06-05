# AGENTS.md

## Project Focus

- Optimize for premium, cinematic, visually rich websites with interactive 3D depth.
- Treat the first screen as a usable designed experience, not a generic landing-page placeholder.
- Prioritize strong composition, readable Thai/English typography, smooth motion, and clear brand presence.
- Make 3D meaningful: it should clarify the product, brand, workflow, object, or atmosphere instead of being decoration only.
- Default to Thai for user-facing conversation when the user writes in Thai.

## How To Use This Guidance

- Treat this file as persistent project context that reduces repeated prompting and keeps Codex consistent.
- Before editing, identify the stack, coding style, test commands, folder structure, and security constraints that apply to the current task.
- Prefer targeted context gathering over opening large files or scanning the whole project.
- Use `rg`/`rg --files` first for discovery, then read only the files that are likely to matter.
- Avoid reading generated or dependency folders unless the task explicitly requires it, such as `node_modules`, `dist`, build outputs, virtual environments, and archived vendor folders.
- When a repository has its own `AGENTS.md`, follow the local project guidance where it is more specific than this global guidance.

## Codex Skills

- Use the repo skill at `.agents/skills/premium-3d-frontend/SKILL.md` for repeated premium frontend build, review, refactor, security, accessibility, responsive, motion, 3D/canvas, and verification workflows.
- If a global Codex skill with the same `premium-3d-frontend` name is also installed, prefer this repo-scoped skill while working inside this project.
- Keep `AGENTS.md` for project-wide rules and `SKILL.md` for repeatable task workflows so prompts stay shorter and Codex behavior stays consistent.

## Stack Preferences

- For this workspace, prefer React + Vite + Tailwind CSS patterns already present in the project.
- Use Framer Motion for UI motion and page transitions when the project already includes it.
- Use lucide-react icons for interface controls and small symbolic UI.
- For real 3D scenes, prefer Three.js with React Three Fiber and Drei when adding dependencies is appropriate.
- Ask before adding new production dependencies, especially 3D, physics, shader, postprocessing, or asset pipeline packages.

## Language And File Preferences

- Use JavaScript and JSX for React code in this workspace unless the project already has TypeScript or the user asks to migrate.
- Do not introduce TypeScript, TSX, or a type-checking setup without a clear reason and user approval.
- Use modern ES modules syntax: `import`/`export`, small named helpers, and clear component exports.
- Use JSX with semantic HTML elements for UI structure.
- Use Tailwind utility classes for component styling and keep shared/global CSS in `src/index.css` when needed.
- Use JSON for configuration and package metadata; preserve valid formatting and avoid comments in JSON files.
- Use Markdown for project instructions, notes, specs, and documentation.
- Use SQL for database schema, migrations, and queries when a relational database is introduced; otherwise follow the existing ORM or database tool already present.
- Use PowerShell-compatible commands when providing Windows shell examples for this workspace.

## Project Structure Awareness

- Keep application code in `src/`, reusable UI in `src/components/`, imported assets in `src/assets/`, and public static files in `public/` when this structure exists.
- Check `package.json` scripts before assuming commands.
- Treat `scripts/` as project automation; inspect it before changing build, smoke-test, or asset-generation behavior.
- Keep documentation, notes, and generated outputs separate from runtime UI code unless the user asks to integrate them.

## 3D Design Direction

- Build 3D scenes as full-bleed or naturally integrated hero/section experiences, not tiny previews trapped inside decorative cards.
- Use clear camera framing, lighting, shadows, materials, and depth cues so objects read well on desktop and mobile.
- Keep scenes interactive when useful: pointer parallax, hover states, scroll-linked camera movement, or subtle idle animation.
- Provide reduced-motion behavior for users who prefer less motion.
- Avoid visual noise: no random floating objects unless they support the story, brand, or workflow.
- Ensure 3D canvas content is never blank, cropped awkwardly, or blocking important text and controls.

## Frontend Quality Bar

- Match the existing visual system before inventing a new one.
- Use responsive constraints for fixed-format elements such as canvases, navbars, cards, toolbars, and hero media.
- Do not let text overlap, overflow buttons, or collide with 3D/canvas layers on mobile or desktop.
- Keep cards to actual repeated items, tools, and modals; avoid nesting cards inside cards.
- Use real images, generated bitmap assets, or rendered 3D/canvas visuals where visual identity matters.
- Avoid one-note palettes. Balance dark cinematic backgrounds with clear contrast, accent color discipline, and enough neutral space.

## Performance And Assets

- Keep 3D assets lightweight and intentional. Compress textures and avoid oversized models.
- Lazy-load heavy scenes or assets when they are below the fold.
- Watch mobile GPU cost: limit postprocessing, particle counts, realtime shadows, and unnecessary re-renders.
- Prefer reusable scene components with clear props for camera, content, theme, and interaction state.
- Keep animation smooth but subtle; design for perceived quality, not constant movement.

## Coding Style

- Inspect the project structure and conventions before editing.
- Keep changes scoped to the user's request and avoid unrelated refactors.
- Never overwrite, revert, or discard user changes unless the user explicitly asks for it.
- Prefer existing dependencies, helpers, and patterns over introducing new ones.
- Keep code readable: small components, direct names, minimal cleverness.
- Add comments only when they clarify non-obvious behavior.
- Preserve surrounding formatting and style.

## Code Fundamentals

- Separate concerns clearly: UI rendering, state, data access, validation, and side effects should not be tangled together.
- Prefer explicit data flow through props, hooks, functions, or services over hidden global state.
- Validate inputs at boundaries: forms, API handlers, database writes, file imports, and external service responses.
- Handle loading, empty, error, and success states for user-facing flows.
- Keep reusable logic in small functions or hooks with clear names and minimal dependencies.
- Avoid duplicating business rules across components; extract shared rules when duplication risks drift.
- Do not swallow errors silently. Surface actionable messages to users and useful details to logs where appropriate.
- When changing public behavior, update tests, smoke checks, docs, or examples that depend on it.

## Database Fundamentals

- Do not add a database or ORM unless the task needs persistent structured data.
- Identify the data model, ownership, relationships, and read/write paths before creating tables or collections.
- Prefer migrations or schema files over manual, undocumented database changes.
- Keep secrets and connection strings in environment variables; never commit real credentials.
- Validate and sanitize all data before writes. Use parameterized queries or ORM query builders; never concatenate user input into SQL.
- Design for integrity: primary keys, foreign keys, uniqueness, not-null constraints, defaults, and timestamps where useful.
- Use transactions for multi-step writes that must succeed or fail together.
- Add indexes for real query patterns, not speculative ones. Check performance before adding many indexes.
- Plan authorization close to the data layer: row-level security, ownership checks, tenant boundaries, or server-side access control as appropriate.
- Treat destructive migrations, backfills, deletes, and data rewrites as high-risk; make them reversible or backed up when possible.

## Security And Reliability

- Do not hardcode secrets, API keys, tokens, private URLs, or credentials.
- Be careful with user-supplied content, external links, forms, downloads, and embedded media.
- For frontend work, check accessibility basics: semantic elements, alt text, focus states, keyboard access, contrast, and reduced motion.
- For refactors, inspect references before renaming or moving components.
- Summarize changed files and verification results clearly at the end of the task.

## Verification

- After frontend changes, run the most relevant check from `package.json`: usually `npm run build`, `npm run test`, or both when available.
- For visual or 3D work, start the local dev server and verify in a browser when practical.
- Check at least one desktop viewport and one mobile viewport for layout, canvas framing, interaction, and text fit.
- Confirm the 3D/canvas area renders nonblank and does not cover critical UI.
- If verification cannot be run, explain why and note the remaining risk.
