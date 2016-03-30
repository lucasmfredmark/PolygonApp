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

CREATE TABLE Users
(
customer varchar(30),
admin varchar(30)
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





