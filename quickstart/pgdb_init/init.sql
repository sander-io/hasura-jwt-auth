-- Entrypoint for the Postgres docker image to write schemas on initialise

-- load some variables from the env
\set current_db `echo $DB_NAME`
\set jwt_secret_key `echo $JWT_SECRET_KEY`

\echo # Altering global database settings

\echo # Loading database definition
begin;

\echo # Load pgjwt file
\ir ../../pgjwt.sql

\echo # Load hasura-jwt-auth file
\ir ../../hasura-jwt-auth.sql

\echo # Load your schema
\ir ../yourschema/schema.sql

\echo # Specify JWT key for database
alter database example set "hasura.jwt_secret_key" to ':jwt_secret_key';


commit;
\echo # ==========================================
