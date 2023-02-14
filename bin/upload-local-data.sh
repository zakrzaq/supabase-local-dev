#! /bin/bash

ENV=.env
if test -f "$ENV"; then
  echo "$ENV exists."
  [ -d dumps ] || mkdir dumps
  REMOTE_DB=$(grep REMOTE_DB .env | cut -d "=" -f2 | tr -d '"')
  # npx supabase init
  pg_dump postgresql://postgres:postgres@localhost:54322/postgres -n public -Fc > dumps/dump.psql 
  psql -d $REMOTE_DB -c "drop schema if exists public cascade;;"
  pg_restore -d $REMOTE_DB dumps/dump.psql
else
  echo "$ENV doesn't exist."
fi
