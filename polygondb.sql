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

CREATE TABLE municipality(
    mname varchar(30),
    phonenubmer varchar(10)
);

CREATE TABLE HousingAssociation(
    hname varchar(30),
    phonenubmer varchar(10)
);

CREATE TABLE PrivatePerson(
    pname varchar(30),
    phonenubmer varchar(10)
);
