#! /bin/bash

ENV=.env
if test -f "$ENV"; then
  echo "$ENV exists."
  REMOTE_DB=$(grep REMOTE_DB .env | cut -d "=" -f2 | tr -d '"')
  # npx supabase init
  pg_dump $REMOTE_DB -n public -Fc > dump.psql
  # psql -d "postgresql://postgres:postgres@localhost:54322/postgres" -c "select drop table if exists "' || tablename || '" cascade;' from pg_tables where schemaname = 'public';;"
  pg_restore -d postgresql://postgres:postgres@localhost:54322/postgres dump.psql
else
  echo "$ENV doesn't exist."
fi
