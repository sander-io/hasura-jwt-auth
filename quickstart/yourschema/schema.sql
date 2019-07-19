-- Replace this with your own ddl for your own tables.
--
-- Below is a table from the Hasura starting tutorial. TODO - make it work with pgjwt
CREATE TABLE todos
(
    id serial PRIMARY KEY,
    title text NOT NULL,
    is_completed boolean NOT NULL DEFAULT false,
    is_public boolean NOT NULL DEFAULT false,
    created_at timestamp with time zone NOT NULL DEFAULT now(),
    user_id text NOT NULL
);


