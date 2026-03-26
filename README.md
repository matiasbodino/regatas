# Regatas Bellavista Primera — Cumbre a Cumbre

App estática (HTML/CSS/JS) para planificación de rugby y vista “hoy” para jugadores.

## Rutas (Vercel)

| URL            | Uso                          |
|----------------|------------------------------|
| `/` y `/coach` | App completa (coaches)        |
| `/hoy`         | Vista solo lectura (jugadores) |

## Estructura

- `public/coach.html` — copia de `cumbre_a_cumbre_app_FINAL.html` + integración Supabase
- `public/hoy.html` — vista mobile jugadores
- `supabase/schema.sql` — tabla `semana_activa`

## Deploy (resumen)

1. Crear proyecto en [Supabase](https://supabase.com), ejecutar `supabase/schema.sql` en SQL Editor.
2. En Settings → API, copiar **URL** y **anon key** y reemplazar `REEMPLAZAR_*` en `coach.html` y `hoy.html`.
3. En [Vercel](https://vercel.com): New Project → root `regatas-primera` (carpeta con `public/` y `vercel.json`).

Sin `package.json` ni build: Vercel sirve `public/` como estático.
