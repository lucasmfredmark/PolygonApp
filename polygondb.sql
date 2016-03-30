CREATE DATABASE polygon;
USE polygon;

CREATE TABLE buildings (
    buildingid INT AUTO_INCREMENT PRIMARY KEY,
    bname varchar(10),
    address varchar(10),
    parcelnumber int(5),
    size_m2 varchar(3),
    conditionlevel int(1),
    userid INT
);

CREATE TABLE documents (
    type varchar(100)
);

CREATE TABLE services (
    type varchar(100)
);

CREATE TABLE checkups (
    conditionlevel int(1)
);

CREATE TABLE users (
    userid INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(30),
    userpass VARCHAR(30),
    usertype ENUM('customer','admin'),
    fullname VARCHAR(50),
    email VARCHAR(40)
);

CREATE TABLE municipalities (
    mname varchar(30),
    phonenumber varchar(10)
);

CREATE TABLE housingassociations (
    hname varchar(30),
    phonenumber varchar(10)
);

CREATE TABLE privatepersons (
    pname varchar(30),
    phonenumber varchar(10)
);

INSERT INTO users (userid, username, userpass, usertype, fullname, email) VALUES (1, 'Lucas', 1234, 'Admin', 'Lucas Fredmark', 'lucas.m.fredmark@gmail.com');