create extension if not exists pgcrypto;

create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = timezone('utc', now());
  return new;
end;
$$;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  role text not null default 'requester' check (role in ('requester', 'professional', 'admin')),
  full_name text not null,
  avatar_url text,
  city text,
  phone text,
  bio text,
  verified boolean not null default false,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

create table if not exists public.service_requests (
  id uuid primary key default gen_random_uuid(),
  created_by uuid references auth.users(id) on delete set null,
  requester_name text not null,
  title text not null,
  description text not null,
  category text not null default 'general',
  priority text not null default 'programable' check (priority in ('urgente', 'programable')),
  location text not null,
  budget_label text not null default 'A convenir',
  budget_min numeric(12, 2),
  budget_max numeric(12, 2),
  payment_type text not null default 'A convenir',
  client_badge text not null default 'Cliente verificado',
  gallery_urls text[] not null default '{}',
  status text not null default 'open' check (status in ('open', 'in_progress', 'closed')),
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

create table if not exists public.request_quotes (
  id uuid primary key default gen_random_uuid(),
  request_id uuid not null references public.service_requests(id) on delete cascade,
  professional_id uuid references auth.users(id) on delete set null,
  title text not null,
  details text,
  total_amount numeric(12, 2),
  currency text not null default 'ARS',
  status text not null default 'pending' check (status in ('pending', 'accepted', 'rejected', 'withdrawn')),
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

create table if not exists public.request_messages (
  id uuid primary key default gen_random_uuid(),
  request_id uuid not null references public.service_requests(id) on delete cascade,
  sender_id uuid references auth.users(id) on delete set null,
  sender_name text not null,
  message_type text not null default 'text' check (message_type in ('text', 'image', 'quote')),
  body text not null,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default timezone('utc', now())
);

create index if not exists service_requests_status_created_at_idx
  on public.service_requests(status, created_at desc);

create index if not exists service_requests_category_idx
  on public.service_requests(category);

create index if not exists request_quotes_request_id_idx
  on public.request_quotes(request_id);

create index if not exists request_messages_request_id_created_at_idx
  on public.request_messages(request_id, created_at asc);

drop trigger if exists set_profiles_updated_at on public.profiles;
create trigger set_profiles_updated_at
before update on public.profiles
for each row execute function public.set_updated_at();

drop trigger if exists set_service_requests_updated_at on public.service_requests;
create trigger set_service_requests_updated_at
before update on public.service_requests
for each row execute function public.set_updated_at();

drop trigger if exists set_request_quotes_updated_at on public.request_quotes;
create trigger set_request_quotes_updated_at
before update on public.request_quotes
for each row execute function public.set_updated_at();

alter table public.profiles enable row level security;
alter table public.service_requests enable row level security;
alter table public.request_quotes enable row level security;
alter table public.request_messages enable row level security;

drop policy if exists "profiles are viewable by everyone" on public.profiles;
create policy "profiles are viewable by everyone"
on public.profiles
for select
using (true);

drop policy if exists "users manage own profile" on public.profiles;
create policy "users manage own profile"
on public.profiles
for all
to authenticated
using (auth.uid() = id)
with check (auth.uid() = id);

drop policy if exists "open requests are viewable by everyone" on public.service_requests;
create policy "open requests are viewable by everyone"
on public.service_requests
for select
using (status = 'open');

drop policy if exists "anyone can create a request" on public.service_requests;
create policy "anyone can create a request"
on public.service_requests
for insert
to anon, authenticated
with check (status = 'open');

drop policy if exists "request owner can update own request" on public.service_requests;
create policy "request owner can update own request"
on public.service_requests
for update
to authenticated
using (created_by = auth.uid())
with check (created_by = auth.uid());

drop policy if exists "quotes are viewable by authenticated users" on public.request_quotes;
create policy "quotes are viewable by authenticated users"
on public.request_quotes
for select
to authenticated
using (true);

drop policy if exists "professionals can create quotes" on public.request_quotes;
create policy "professionals can create quotes"
on public.request_quotes
for insert
to authenticated
with check (professional_id = auth.uid());

drop policy if exists "messages are viewable by authenticated users" on public.request_messages;
create policy "messages are viewable by authenticated users"
on public.request_messages
for select
to authenticated
using (true);

drop policy if exists "authenticated users can send messages" on public.request_messages;
create policy "authenticated users can send messages"
on public.request_messages
for insert
to authenticated
with check (sender_id = auth.uid());
