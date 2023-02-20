# SUPABASE-LOCAL-DEV

## SETUP

1. Add and edit `.env` with `DB_PASSWORD` and `PROJECT_ID`
1. run `npm install`
1. run `npm run login` and paste your access [token](https://app.supabase.com/account/tokens)
1. run `npm run init`
1. run `docker ps` and get container name (e.g. `supabase_db_zeppelins-be`) for `postgres-15`
1. paste in `.env` under `LOCAL_PG` key
1. edit you `.env`
   - DB_PASSWORD for remote DB
   - PROJECT_ID for your SB instance
   - access TOKEN we used earlier
   - postgres://postgres:`<DB_PASSWORD>`@`<PROJECT_ID>`.supabase.co:6543/postgres

To run the server `npm run start|stop`. Requires docker running.
Alternative `npx supabase start|stop`

## UPLAODING SCHEMA CHENGES

1. `npx supabase db diff <name> -f <file-name>`
2. `npm run push`

## DOWNLOADING SCHEMA changes

Start script syncs schema changes from `remote` to `local`

## SYNC DATA TO LOCAL

`npm run sync:local`

## DATA TO REMOTE

`npm run sync:remote`

## NOTES

.env

```bash
DB_PASSWORD="<password>"
PROJECT_ID="<project-id>" # can be find in SP url string
TOKEN="<token>" # see link above
REMOTE_DB="postgres://postgres:<remote-db-password>@db.<remote-project-id>.supabase.co:6543/postgres"%
```

## TODO

- [x] check downstrean / upstream data syncs
- [x] local dir for dumps
- [x] handle postgres 15 installed on local system
- [x] install postgress z docker compose ? asdf
- [x] data structure
