DROP DATABASE IF EXISTS polygon;
CREATE DATABASE polygon;
USE polygon;

CREATE TABLE users ( /* MIDLERTIDIGT INGEN FOREIGN KEY */
    userid INT AUTO_INCREMENT PRIMARY KEY,
    udate DATETIME DEFAULT CURRENT_TIMESTAMP, /* Oprettelses dato */
    usermail VARCHAR(255), /* Også login navn */
    userpass VARCHAR(20),
    usertype ENUM('CUSTOMER','ADMIN') DEFAULT 'CUSTOMER',
    fullname VARCHAR(50)
);
INSERT INTO users (usermail, userpass, fullname) VALUES ('test@user.dk','test','Test User');
INSERT INTO users (usermail, userpass, usertype, fullname) VALUES ('admin@polygon.dk','admin','ADMIN','Power User');
INSERT INTO users (usermail, userpass, fullname) VALUES ('random@user.dk','123','John Doe');

CREATE TABLE buildings (
    buildingid INT AUTO_INCREMENT PRIMARY KEY,
    bdate DATETIME DEFAULT CURRENT_TIMESTAMP, /* Oprettelses dato */ 
    bname VARCHAR(40), /* Navneidentifikation for kunden */
    address VARCHAR(50),
    parcelnumber VARCHAR(20),
    size INT, /* Kvadratmeter m2 */
    fk_userid INT,
    FOREIGN KEY (fk_userid) REFERENCES users(userid)
);
INSERT INTO buildings (bname, address, parcelnumber, size, fk_userid) VALUES ('Building 1', 'Address', 'Parcel number', 100, 1);
INSERT INTO buildings (bname, address, parcelnumber, size, fk_userid) VALUES ('Building 2', 'Address', 'Parcel number', 100, 1);
INSERT INTO buildings (bname, address, parcelnumber, size, fk_userid) VALUES ('Building 3', 'Address', 'Parcel number', 100, 1);
INSERT INTO buildings (bname, address, parcelnumber, size, fk_userid) VALUES ('Building 4', 'Address', 'Parcel number', 100, 1);
INSERT INTO buildings (bname, address, parcelnumber, size, fk_userid) VALUES ('Building 5', 'Address', 'Parcel number', 100, 2);
INSERT INTO buildings (bname, address, parcelnumber, size, fk_userid) VALUES ('Building 6', 'Address', 'Parcel number', 100, 2);
INSERT INTO buildings (bname, address, parcelnumber, size, fk_userid) VALUES ('Building 7', 'Address', 'Parcel number', 100, 3);
INSERT INTO buildings (bname, address, parcelnumber, size, fk_userid) VALUES ('Building 8', 'Address', 'Parcel number', 100, 3);

CREATE TABLE services ( 
	serviceid INT PRIMARY KEY,
    stype VARCHAR(50), /* Forskellige services som Polygon tilbyder */
    sdesc VARCHAR(255)
);
INSERT INTO services (serviceid, stype, sdesc) VALUES (1, 'Health check-up', 'Lorem ipsum dolor sit amet.');

CREATE TABLE eventlogs (
	logid INT PRIMARY KEY AUTO_INCREMENT,
    ltype VARCHAR(255), /* Type af ændring */
    fk_userid INT,
    fk_buildingID INT,
    FOREIGN KEY (fk_userid) REFERENCES users(userid),
    FOREIGN KEY (fk_buildingid) REFERENCES buildings(buildingid)
);
/* INSERT INTO etc */ 

CREATE TABLE documents (
	documentid INT AUTO_INCREMENT PRIMARY KEY,
    ddate DATETIME DEFAULT CURRENT_TIMESTAMP,
    dnote VARCHAR(100), /* Beskrivelse af uploadet dokument */
    dpath VARCHAR(255), /* Tilfældigt genereret unik path */
    fk_buildingid INT,
    fk_userid INT,
    FOREIGN KEY (fk_buildingid) REFERENCES buildings(buildingid),
    FOREIGN KEY (fk_userid) REFERENCES users(userid)
);
/* INSERT INTO etc */

CREATE TABLE orders (
	orderid INT AUTO_INCREMENT PRIMARY KEY,
    odate DATETIME DEFAULT CURRENT_TIMESTAMP,
    ostatus INT, /* 0 = Incomplete, 1 = Complete */
    odone DATETIME, /* DATO FOR COMPLETION */
    odesc TEXT, /* Valgfri beskrivelse af problem */
    fk_serviceid INT,
    fk_buildingid INT,
    FOREIGN KEY (fk_serviceid) REFERENCES services(serviceid),
    FOREIGN KEY (fk_buildingid) REFERENCES buildings(buildingid)
);
INSERT INTO orders (fk_serviceid, fk_buildingid, odesc) VALUES (1, 1, 'Den er helt gal!');
INSERT INTO orders (fk_serviceid, fk_buildingid, odesc) VALUES (1, 2, 'Den er helt gal!');
INSERT INTO orders (fk_serviceid, fk_buildingid, odesc) VALUES (1, 3, 'Den er helt gal!');
INSERT INTO orders (fk_serviceid, fk_buildingid, odesc) VALUES (1, 4, 'Den er helt gal!');

CREATE TABLE checkups (
	checkupid INT AUTO_INCREMENT PRIMARY KEY,
    cdate DATETIME DEFAULT CURRENT_TIMESTAMP,
    cpath VARCHAR(255), /* Tilfældigt genereret unik sti */
    conditionlevel INT,
    fk_buildingid INT,
    fk_orderid INT,
    FOREIGN KEY (fk_buildingid) REFERENCES buildings(buildingid),
    FOREIGN KEY (fk_orderid) REFERENCES orders(orderid)
);
INSERT INTO checkups (cpath, conditionlevel, fk_buildingid, fk_orderid) VALUES ('qwerty.txt', 0, 1, 1);
INSERT INTO checkups (cpath, conditionlevel, fk_buildingid, fk_orderid) VALUES ('yuiop.txt', 3, 2, 3);
INSERT INTO checkups (cpath, conditionlevel, fk_buildingid, fk_orderid) VALUES ('asdfg.txt', 1, 3, 2);
INSERT INTO checkups (cpath, conditionlevel, fk_buildingid, fk_orderid) VALUES ('zxcvb.txt', 2, 4, 4);

CREATE TABLE damages (
	damageid INT AUTO_INCREMENT PRIMARY KEY,
    dmgdate DATETIME DEFAULT CURRENT_TIMESTAMP, /* Hvornår den er oprettet */
    dmgtitle VARCHAR(50),
    dmgdesc TEXT,
    fk_buildingid INT,
    FOREIGN KEY (fk_buildingid) REFERENCES buildings(buildingid)
);

CREATE TABLE images (
	imageid INT AUTO_INCREMENT PRIMARY KEY,
    idesc VARCHAR(255),
    ipath VARCHAR(255),
    fk_checkupid INT,
    FOREIGN KEY (fk_checkupid) REFERENCES checkups(checkupid)
);