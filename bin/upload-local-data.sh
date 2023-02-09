#! /bin/bash

ENV=.env
if test -f "$ENV"; then
  echo "$ENV exists."
  REMOTE_DB=$(grep REMOTE_DB .env | cut -d "=" -f2 | tr -d '"')
  # npx supabase init
  pg_dump postgresql://postgres:postgres@localhost:54322/postgres -n public -Fc > dump.psql 
  pg_restore -d $REMOTE_DB dump.psql
else
  echo "$ENV doesn't exist."
fi
