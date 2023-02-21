#! /bin/bash

current_dir=${PWD##*/}
docker_cont_name=supabase_db_${current_dir}
docker_cont_id=$(docker ps -q -f name=$docker_cont_name)
echo $docker_cont_id

