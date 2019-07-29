create database example;
alter database example set "hasura.jwt_secret_key" to 'jwtsecret of 32 characters or more';

\connect example
create extension if not exists pgcrypto;
