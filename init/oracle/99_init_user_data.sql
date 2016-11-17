ALTER SESSION SET CURRENT_SCHEMA = penny;

INSERT INTO users(username,password,enabled) VALUES ('leonard','password', 1);
INSERT INTO users(username,password,enabled) VALUES ('sheldon','password', 1);
INSERT INTO users(username,password,enabled) VALUES ('howard','password', 0);
INSERT INTO users(username,password,enabled) VALUES ('rajesh','password', 1);

INSERT INTO user_roles (username, role) VALUES ('leonard', 'ROLE_USER');
INSERT INTO user_roles (username, role) VALUES ('leonard', 'ROLE_ADMIN');
INSERT INTO user_roles (username, role) VALUES ('sheldon', 'ROLE_USER');
INSERT INTO user_roles (username, role) VALUES ('howard', 'ROLE_USER');
INSERT INTO user_roles (username, role) VALUES ('howard', 'ROLE_ADMIN');