-- Acosta Planner: one JSON snapshot per authenticated user.
-- Enable Anonymous sign-ins: Dashboard → Authentication → Providers → Anonymous.

create table if not exists public.planner_data (
  user_id uuid primary key references auth.users (id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

create index if not exists planner_data_updated_at on public.planner_data (updated_at desc);

alter table public.planner_data enable row level security;

create policy "planner_data_select_own"
  on public.planner_data for select
  using (auth.uid() = user_id);

create policy "planner_data_insert_own"
  on public.planner_data for insert
  with check (auth.uid() = user_id);

create policy "planner_data_update_own"
  on public.planner_data for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
