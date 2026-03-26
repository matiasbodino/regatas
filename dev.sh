#!/bin/bash
# Servidor estático local para preview (Claude Code / navegador).
# Abre: http://localhost:${PORT}/coach.html  (los rewrites de Vercel no aplican aquí)
cd "$(dirname "$0")"
PORT="${PORT:-3456}"
exec python3 -m http.server "$PORT" --directory public
