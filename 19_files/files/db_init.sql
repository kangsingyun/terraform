DROP DATABASE IF EXISTS test_board;
DROP USER IF EXISTS 'webmaster'@'%';

CREATE USER 'webmaster'@'%' IDENTIFIED BY '123';
GRANT ALL PRIVILEGES ON test_board.* TO 'webmaster'@'%';
CREATE DATABASE test_board DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE test_board;
CREATE TABLE users (username CHAR(16) NOT NULL PRIMARY KEY, password CHAR(41));

INSERT INTO users VALUES ('user1', '1234');
INSERT INTO users VALUES ('user2', '1234');

CREATE TABLE board (
id INT UNSIGNED AUTO_INCREMENT,
user VARCHAR(100) NOT NULL,
title VARCHAR(100) NOT NULL,
comment TEXT NOT NULL,
file VARCHAR(100),
date DATETIME NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY (user) REFERENCES users (username));

