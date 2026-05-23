# Tech Stack

- Top-level app: Vite + React, JavaScript/JSX, ES modules (`type: module`).
- Styling: Tailwind CSS v4 via `@tailwindcss/vite`; global/shared styles in `src/index.css`.
- Motion/icons: `framer-motion` and `lucide-react` are installed and used.
- Package manager state: `package-lock.json` present; use npm commands.
- Node engine in `package.json`: `>=20.19`.
- Existing dependencies before new work did not include Three.js/R3F/auth libraries; adding those is a production dependency change unless explicitly requested by the task.