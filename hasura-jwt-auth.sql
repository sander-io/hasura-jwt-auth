\set ON_ERROR_STOP true

drop function if exists hasura_auth(varchar, varchar);
drop table if exists hasura_user;
create table hasura_user(
    user_id serial primary key,
    email varchar unique,
    crypt_password varchar,
    cleartext_password varchar,
    default_role varchar default 'user',
    allowed_roles jsonb default '["user"]',
    enabled boolean default true,
    jwt_token text
);

create or replace function hasura_encrypt_password(cleartext_password in text, salt in text) returns varchar as $$
    select crypt(
        encode(hmac(cleartext_password, current_setting('hasura.jwt_secret_key'), 'sha256'), 'escape'),
        salt);
$$ language sql stable;

create or replace function hasura_user_encrypt_password() returns trigger as $$
begin
    if new.cleartext_password is not null and trim(new.cleartext_password) <> '' then
        new.crypt_password := (hasura_encrypt_password(new.cleartext_password, gen_salt('bf')));
    end if;
    new.cleartext_password = null;
    new.jwt_token = null;
    return new;
end;
$$ language 'plpgsql';

create trigger hasura_user_encrypt_password_trigger
before insert or update on hasura_user
for each row execute procedure hasura_user_encrypt_password();

-- https://docs.hasura.io/1.0/graphql/manual/auth/authentication/jwt.html#configuring-jwt-mode
create or replace function hasura_auth(email in varchar, cleartext_password in varchar) returns setof hasura_user as $$
    select
        user_id,
        email,
        crypt_password,
        cleartext_password,
        default_role,
        allowed_roles,
        enabled,
        sign(
            json_build_object(
                'sub', user_id::text,
                'iss', 'Hasura-JWT-Auth',
                'iat', round(extract(epoch from now())),
                'exp', round(extract(epoch from now() + interval '24 hour')),
                'https://hasura.io/jwt/claims', json_build_object(
                    'x-hasura-user-id', user_id::text,
                    'x-hasura-default-role', default_role,
                    'x-hasura-allowed-roles', allowed_roles
                )
            ), current_setting('hasura.jwt_secret_key')) as jwt_token
    from hasura_user h
    where h.email = hasura_auth.email
    and h.enabled
    and h.crypt_password = hasura_encrypt_password(hasura_auth.cleartext_password, h.crypt_password);
$$ language 'sql' stable;

--  insert an example user and print a jwt_token
insert into hasura_user(email, cleartext_password) values ('user@example.com', 'password');

do $$ begin
    raise notice 'Example jwt_token: %s', (select jwt_token from hasura_auth('user@example.com', 'password'));
end $$;
