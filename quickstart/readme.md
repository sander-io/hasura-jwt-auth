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

* Hasura instance will be running at http://localhost:8080 and can be accessed using `adminsecret`.
* PgAdmin4 instance will be running at http://localhost:5050 (login: `admin` / `password`). Note: use `postgres` as hostname and `postgres` as username.
* The database will have the hasura-jwt-auth service installed and ready to go.

## Queries

Role is anonymous:

```graphql
query Auth {
  hasura_auth(args: {email: "user1@example.com", cleartext_password: "password"}) {
    jwt_token
  }
}
```

Use the token in the `Authorization: Bearer ${jwt_token}` header.

```graphql
query Todos {
  hasura_user {
    id
    email
    todos {
      title
      is_public
      is_completed
    }
  }
}
```

Notice that you see all the todos of your own user and all the public todo's of the other users.

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
