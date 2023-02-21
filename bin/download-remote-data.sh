#! /bin/bash

ENV=.env
if test -f "$ENV"; then
  echo "$ENV exists."
  [ -d dumps ] || mkdir dumps
  REMOTE_DB=$(grep REMOTE_DB .env | cut -d "=" -f2 | tr -d '"')

  current_dir=${PWD##*/}
  docker_cont_name=supabase_db_${current_dir}
  docker_cont_id=$(docker ps -q -f name=$docker_cont_name)
  echo $docker_cont_id
  SP_POSTGRESS_ID=$docker_cont_id

  
  
  # USING LOCAL POSTGRES
  # pg_dump $REMOTE_DB -n public -Fc > dumps/dump.psql
  # psql -d "postgresql://postgres:postgres@localhost:54322/postgres" -c "drop schema if exists public cascade;;"
  # pg_restore -d postgresql://postgres:postgres@localhost:54322/postgres dumps/dump.psql
  
  # USING DOCKER POSTGRESS
  docker exec $SP_POSTGRESS_ID psql -U postgres -c "drop schema if exists public cascade"
  docker exec -it $SP_POSTGRESS_ID /bin/bash -c "pg_dump -U postgres -d ${REMOTE_DB} -n public -Fc | pg_restore -U postgres -d postgres"
  echo 'Data dump & restore complete'
  # docker exec -it supabase_db_supabase-local-dev find ./ -name 'dump.psql'
else
  echo "$ENV doesn't exist."
fi
