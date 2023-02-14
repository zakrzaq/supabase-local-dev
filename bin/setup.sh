#! /bin/bash
ENV=.env
if test -f "$ENV"; then
  echo "$ENV exists."
  DB_PASSWORD=$(grep DB_PASSWORD .env | cut -d "=" -f2 | tr -d '"')
  PROJECT_ID=$(grep PROJECT_ID .env | cut -d "=" -f2 | tr -d '"')
  # npx supabase init
  npx supabase link --project-ref $PROJECT_ID -p $DB_PASSWORD
  mkdir supabase
  mkdir supabase/.temp
  touch supabase/.temp/project-ref
  cat $PROJECT_ID > supabase/.temp/project-ref
else
  echo "$ENV doesn't exist."
fi
