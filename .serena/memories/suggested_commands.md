# Suggested Commands

- Install/update deps: `npm install`.
- Start local dev server: `npm run dev` (Vite host `127.0.0.1`, default port `5173`).
- Production build: `npm run build`.
- Smoke test: `npm run test` (runs `node scripts/smoke-test.mjs`).
- Preview build: `npm run preview`.
- Windows discovery: prefer `rg --files -g '!*node_modules*' -g '!dist'`; read files with `Get-Content -Raw <path>`.