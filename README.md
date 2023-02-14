# SUPABASE-LOCAL-DEV

## SETUP

1. Add and edit `.env` with `DB_PASSWORD` and `PROJECT_ID`
1. run `npm install`
1. run `npm run login` and paste your access [token](https://app.supabase.com/account/tokens)
1. run `npm run init`

To run the server `npm run start|stop`. Requires docker running.

## UPLAODING SCHEMA CHENGES

1. `npx supabase db diff <name> -f <file-name>`
2. `npm run push`

## UPLOAD LOCAL DATA TO REMOTE

`npm run sync:local`

## DOWNLAOD REMOTE DATA TO LOCAL

`npm run sync:remote`

## NOTES

start script syncs schema changes from `remote` to `local`

## TODO

- [x] check downstrean / upstream data syncs
- [ ] local dir for dumps
- [ ] handle postgres 15 installed on local system
- [ ] install postgress z docker compose ? asdf
- [x] data structure 
