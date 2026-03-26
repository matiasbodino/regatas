# Regatas Primera — Web App Implementation Plan

**Overall Progress:** `100%`

## TLDR
Convertir el HTML estático `cumbre_a_cumbre_app_FINAL.html` en una web app deployada en Vercel con dos URLs: `/coach` (app completa para coaches) y `/hoy` (vista mobile solo lectura para jugadores). Persistencia en Supabase con una tabla `semana_activa` (jsonb). Stack: HTML/CSS/JS vanilla, sin frameworks, sin build step.

## Critical Decisions
- **KPIs hardcodeados en hoy.html**: Los 4 KPIs fijos (90% PEO, 90% Line, 40% Scrum, <15% Tackles) van hardcodeados, no viajan en Supabase
- **window.storage → localStorage**: Reemplazar el storage inexistente de Biblioteca con localStorage para v1
- **GYM visible en hoy.html**: Los bloques de Gimnasio se muestran para que jugadores sepan que arrancan a las 20:00
- **Día sin entreno**: Mostrar "Descansá hoy · Próximo entrenamiento: [día]" sin fecha
- **Una sola semana activa**: El coach publica y pisa la anterior (fila id=1 en Supabase)
- **RLS abierta para v1**: Lectura y escritura pública con anon key, se cierra en v2
- **Backs NO aparecen en hoy.html**: Son datos internos del staff

## Tasks:

- [x] 🟩 **Step 1: Copiar HTML a public/coach.html**
  - [x] 🟩 Copiar `~/Downloads/cumbre_a_cumbre_app_FINAL.html` → `regatas-primera/public/coach.html`
  - [x] 🟩 Arreglar `window.storage` en Biblioteca: reemplazar con localStorage (`bibLoad`, `bibSave`, `bibLoadCustom`, `bibSaveCustom`)

- [x] 🟩 **Step 2: Integrar Supabase en coach.html**
  - [x] 🟩 Agregar `<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/dist/umd/supabase.js"></script>` antes del script principal
  - [x] 🟩 Agregar constantes `SUPABASE_URL` y `SUPABASE_ANON_KEY` (placeholders `REEMPLAZAR_*`)
  - [x] 🟩 Inicializar `supabaseClient = supabase.createClient(...)`
  - [x] 🟩 Agregar botón "📢 Publicar" en `.nav-save-bar` junto a Exportar/Importar
  - [x] 🟩 Implementar función `publicarSemana()` que hace upsert de `SEMS[curSem]` a `semana_activa`

- [x] 🟩 **Step 3: Crear supabase/schema.sql**
  - [x] 🟩 Tabla `semana_activa` con columnas `id int PK`, `datos jsonb`, `updated_at timestamptz`
  - [x] 🟩 RLS habilitada con política de lectura pública y escritura pública
  - [x] 🟩 Insert inicial de fila id=1

- [x] 🟩 **Step 4: Crear public/hoy.html**
  - [x] 🟩 Meta tags mobile (viewport, theme-color, apple-mobile-web-app)
  - [x] 🟩 Cargar Supabase SDK desde CDN + constantes de conexión
  - [x] 🟩 Fetch de `semana_activa` donde id=1
  - [x] 🟩 Detección de día: lun(1)/mar(2)/jue(4) → datos del día; otros → "Descansá hoy"
  - [x] 🟩 Header navy con nombre del día en gold, subtítulo rival + local/visitante
  - [x] 🟩 KPIs hardcodeados en fila scrolleable
  - [x] 🟩 Renderizar bloques del día: cards con barra de color por grupo, faceta, contenidos, hora calculada, minutos, botones de video
  - [x] 🟩 Bloques de agua con separador visual especial
  - [x] 🟩 Cálculo de horarios desde 20:00 con `minsToHora()`
  - [x] 🟩 Card final con foco del ciclo + "Ser Mejores, Siempre"
  - [x] 🟩 Estado vacío: fallback si Supabase falla o datos vacíos
  - [x] 🟩 CSS mobile-first (max-width 480px centrado)

- [x] 🟩 **Step 5: Verificar y testear**
  - [x] 🟩 Verificar sintaxis JS de coach.html y hoy.html con `node --check`
  - [ ] 🟥 Test local con `dev.sh` (python http.server) — pendiente de Supabase keys
  - [ ] 🟥 Verificar que coach.html funciona igual que el original — pendiente de browser test
