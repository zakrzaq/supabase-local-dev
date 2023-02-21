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
  # pg_dump postgresql://postgres:postgres@localhost:54322/postgres -n public -Fc > dumps/dump.psql 
  # psql -d $REMOTE_DB -c "drop schema if exists public cascade;;"
  # pg_restore -d $REMOTE_DB dumps/dump.psql
  
  # USING DOCKER OWN PPOSTGRES
  docker exec $SP_POSTGRESS_ID psql -d $REMOTE_DB -c "drop schema if exists public cascade"
  docker exec $SP_POSTGRESS_ID pg_dump -U postgres -n public -Fc | pg_restore -U postgres -d $REMOTE_DB
  echo "Data dump & restore complete"
else
  echo "$ENV doesn't exist."
fi
