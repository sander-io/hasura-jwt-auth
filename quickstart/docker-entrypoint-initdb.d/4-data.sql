\connect example

insert into hasura_user(email, cleartext_password) values ('user1@example.com', 'password');
insert into hasura_user(email, cleartext_password) values ('user2@example.com', 'password');

insert into todos(title, is_public, user_id)
values
    ('Check out Hasura', true, 1),
    ('Drink coffee', false, 1),
    ('Deploy webapp', false, 2),
    ('Excercise', true, 2),
    ('Holiday', false, 2);
