# Hasura-PGJWT Quickstart

Intent is to allow for a quick and simple boilerplate from the Hasura PGJWT scripts, with an initial schema defined as code in the SQL files here.

## Setup

```bash
docker-compose up -d

# load the metadata
curl -H "x-hasura-admin-secret: adminsecret" \
    -d '{"type":"replace_metadata", "args":'$(cat metadata.json)'}' \
    http://localhost:8080/v1/query
```

Environment variables can also be set in the `.env` file.

## Result

* PgAdmin4 instance will be running at http://localhost:5050 (login: `admin` / `password`). Note: use `postgres` as hostname and `postgres` as username.
* Hasura instance will be running at http://localhost:8080 and can be accessed using `adminsecret`.
* The database will have the hasura-jwt-auth service installed and ready to go.

## Interactive SQL

```bash
# connect with psql
docker exec -u postgres -t -i postgres psql example
# \dt lists the tables
# \df lists the functions
```

## Cleanup

```bash
docker-compose down && docker volume prune -f
```
