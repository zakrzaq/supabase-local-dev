#! /bin/bash

ENV=.env
if test -f "$ENV"; then
  echo "$ENV exists."
  [ -d dumps ] || mkdir dumps
  REMOTE_DB=$(grep REMOTE_DB .env | cut -d "=" -f2 | tr -d '"')
  # npx supabase init
  pg_dump $REMOTE_DB -n public -Fc > dumps/dump.psql
  psql -d "postgresql://postgres:postgres@localhost:54322/postgres" -c "drop schema if exists public cascade;;"
  pg_restore -d postgresql://postgres:postgres@localhost:54322/postgres dumps/dump.psql
else
  echo "$ENV doesn't exist."
fi
