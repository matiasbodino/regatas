-- Regatas Bellavista Primera · Cumbre a Cumbre
-- Tabla para publicar la semana activa de entrenamiento (coach → jugadores)

create table semana_activa (
  id int primary key,
  datos jsonb not null default '{}',
  updated_at timestamptz default now()
);

alter table semana_activa enable row level security;

-- Cualquiera puede leer (jugadores sin login)
create policy "lectura publica"
  on semana_activa for select
  using (true);

-- Escritura abierta para v1 (coach usa anon key)
create policy "escritura publica"
  on semana_activa for all
  using (true);

-- Fila inicial
insert into semana_activa (id, datos)
  values (1, '{}');
