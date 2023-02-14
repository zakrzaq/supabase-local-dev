#! /bin/bash

ENV=.env
if test -f "$ENV"; then
  echo "$ENV exists."
  [ -d dumps ] || mkdir dumps
  REMOTE_DB=$(grep REMOTE_DB .env | cut -d "=" -f2 | tr -d '"')
  SP_POSTGRESS_ID=$(docker ps -f name=supabase_db_supabase-local-dev -q)
  # USING LOCAL POSTGRES
  # pg_dump postgresql://postgres:postgres@localhost:54322/postgres -n public -Fc > dumps/dump.psql 
  # psql -d $REMOTE_DB -c "drop schema if exists public cascade;;"
  # pg_restore -d $REMOTE_DB dumps/dump.psql
  # USING DOCKER OWN PPOSTGRES
  docker exec $SP_POSTGRESS_ID psql -d $REMOTE_DB -c "drop schema if exists public cascade"
  docker exec $SP_POSTGRESS_ID pg_dump -U postgres -n public -Fc | pg_restore -U postgres -d $REMOTE_DB
else
  echo "$ENV doesn't exist."
fi
