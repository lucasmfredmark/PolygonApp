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

CREATE TABLE buildings (
    buildingid INT AUTO_INCREMENT PRIMARY KEY,
    bdate DATETIME DEFAULT CURRENT_TIMESTAMP, /* Oprettelses dato */ 
    bname VARCHAR(40), /* Navneidentifikation for kunden */
    address VARCHAR(50),
    parcelnumber VARCHAR(20),
    size INT, /* Kvadratmeter m2 */
    fk_userid INT,
    FOREIGN KEY (fk_userid) REFERENCES users(userid) ON DELETE CASCADE
);

CREATE TABLE services ( 
	serviceid INT PRIMARY KEY,
    stype VARCHAR(50), /* Forskellige services som Polygon tilbyder */
    sdesc VARCHAR(255)
);

CREATE TABLE eventlogs (
	logid INT PRIMARY KEY AUTO_INCREMENT,
    ltype VARCHAR(255), /* Type af ændring */
    fk_userid INT,
    fk_buildingID INT,
    FOREIGN KEY (fk_userid) REFERENCES users(userid),
    FOREIGN KEY (fk_buildingid) REFERENCES buildings(buildingid)
);

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

SELECT * FROM buildings;
