# Hasura-PGJWT Quickstart

Intent is to allow for a quick and simple production-ready boilerplate from the Hasura PGJWT scripts, with an initial schema defined as code in the SQL files here.

Steps: 

1. (Optional) Change the .env file parameters to something secure
2. Run `docker-compose up -d --force-recreate` to start with the enviroment defaults. 
3. Connect to http://localhost:5050 for PGAdmin interface, and http://localhost:8080 for Hasura.

Result:

* A PgAdmin4 instance will be running on port 5050, and can be logged into with the PGADMIN_EMAIL and PGADMIN_PASSWORD specified in the .env file. Note: Use 'postgres', NOT 'localhost' as the hostname in PgAdmin4
* A Hasura instance will be running on port 8080, and can be accessed using the HASURA_ADMIN_SECRET in the .env file
* A Postgres database will be running on port 5432, with the username, password and hostname (default postgres) specified in the .env file.

Note: TO connect from PGAdmin4 or Hasura to Postgres, use the docker service name (default 'postgres') as the hostname of the database.

