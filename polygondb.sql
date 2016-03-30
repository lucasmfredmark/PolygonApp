CREATE DATABASE Polygon;
USE Polygon;

CREATE TABLE Building(
bname varchar(10),
adress varchar(10),
parcelnumber int(5),
size_m2 varchar(3),
coditionlevel int(1)
);

CREATE TABLE Document(
type varchar(100)
);

CREATE TABLE Service(
type varchar(100)
);

CREATE TABLE Checkup(
conditionlvl int(1)
);

CREATE TABLE Users (
userid INT AUTO_INCREMENT PRIMARY KEY,
username VARCHAR(30),
userpass VARCHAR(30),
usertype ENUM('customer','admin'),
fullname VARCHAR(50),
email VARCHAR(40)
);

CREATE TABLE Municipality(
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




