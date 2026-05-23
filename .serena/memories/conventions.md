# Conventions

- Use JavaScript/JSX, not TypeScript, unless the project already migrated or user asks.
- Keep app code in `src/`, reusable UI in `src/components/`, imported assets in `src/assets/`, static files in `public/`.
- Prefer Tailwind utilities for component styling; use `src/index.css` for fonts, design tokens, global layers, reusable animation/glass classes.
- Use Framer Motion for UI motion where already present; use lucide-react for interface icons.
- Frontend visual direction: premium cinematic, dark/luxury, readable Thai/English typography, meaningful full-bleed/naturally integrated 3D/canvas, reduced-motion support, avoid crowded decorative noise.
- Do not hardcode secrets or real auth provider credentials in client code; use env vars and surface configuration-missing states.