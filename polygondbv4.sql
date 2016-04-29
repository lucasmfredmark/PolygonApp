DROP DATABASE IF EXISTS polygon;

CREATE DATABASE polygon;
USE polygon;

CREATE TABLE users (
    userid INT AUTO_INCREMENT PRIMARY KEY,
    udate DATETIME DEFAULT CURRENT_TIMESTAMP,
    usermail VARCHAR(255) UNIQUE,
    userpass VARCHAR(20),
    usertype ENUM('CUSTOMER','ADMIN') DEFAULT 'CUSTOMER',
    fullname VARCHAR(50)
);

INSERT INTO users (usermail, userpass, fullname) VALUES ('test@user.dk','test','Test User');
INSERT INTO users (usermail, userpass, usertype, fullname) VALUES ('admin@polygon.dk','admin','ADMIN','Admin User');

CREATE TABLE buildings (
    buildingid INT AUTO_INCREMENT PRIMARY KEY,
    bdate DATETIME DEFAULT CURRENT_TIMESTAMP,
    bname VARCHAR(40),
    address VARCHAR(50),
    parcelnumber VARCHAR(20),
    size INT,
    fk_userid INT,
    FOREIGN KEY (fk_userid) REFERENCES users(userid)
);

INSERT INTO buildings (bname, address, parcelnumber, size, fk_userid) VALUES ('Building 1', 'Roadway 1', '1a', 16, 1);
INSERT INTO buildings (bname, address, parcelnumber, size, fk_userid) VALUES ('Building 2', 'Roadway 2', '1b', 32, 1);
INSERT INTO buildings (bname, address, parcelnumber, size, fk_userid) VALUES ('Building 3', 'Roadway 3', '1c', 64, 1);
INSERT INTO buildings (bname, address, parcelnumber, size, fk_userid) VALUES ('Building 4', 'Roadway 4', '1d', 128, 1);
INSERT INTO buildings (bname, address, parcelnumber, size, fk_userid) VALUES ('Building 5', 'Roadway 5', '1e', 256, 1);
INSERT INTO buildings (bname, address, parcelnumber, size, fk_userid) VALUES ('Building 6', 'Roadway 6', '1f', 512, 1);
INSERT INTO buildings (bname, address, parcelnumber, size, fk_userid) VALUES ('Building 7', 'Roadway 7', '1g', 1024, 1);
INSERT INTO buildings (bname, address, parcelnumber, size, fk_userid) VALUES ('Building 8', 'Roadway 8', '1h', 2048, 1);

CREATE TABLE documents (
	documentid INT AUTO_INCREMENT PRIMARY KEY,
    ddate DATETIME DEFAULT CURRENT_TIMESTAMP,
    dnote VARCHAR(100),
    dpath VARCHAR(255) UNIQUE,
    fk_buildingid INT,
    FOREIGN KEY (fk_buildingid) REFERENCES buildings(buildingid) ON DELETE CASCADE
);

CREATE TABLE orders (
	orderid INT AUTO_INCREMENT PRIMARY KEY,
    odate DATETIME DEFAULT CURRENT_TIMESTAMP,
    ostatus INT DEFAULT 0,
    odone DATETIME,
    fk_buildingid INT,
    FOREIGN KEY (fk_buildingid) REFERENCES buildings(buildingid) ON DELETE CASCADE
);

CREATE TABLE checkups (
	checkupid INT AUTO_INCREMENT PRIMARY KEY,
    cdate DATETIME DEFAULT CURRENT_TIMESTAMP,
    cpath VARCHAR(255) UNIQUE,
    conditionlevel INT,
    fk_buildingid INT,
    fk_orderid INT,
    FOREIGN KEY (fk_buildingid) REFERENCES buildings(buildingid) ON DELETE CASCADE,
    FOREIGN KEY (fk_orderid) REFERENCES orders(orderid)
);

CREATE TABLE damages (
	damageid INT AUTO_INCREMENT PRIMARY KEY,
    dmgdate DATETIME DEFAULT CURRENT_TIMESTAMP,
    dmgtitle VARCHAR(50),
    dmgdesc TEXT,
    fk_buildingid INT,
    FOREIGN KEY (fk_buildingid) REFERENCES buildings(buildingid) ON DELETE CASCADE
);

CREATE TABLE tickets (
	ticketid INT AUTO_INCREMENT PRIMARY KEY,
    ticketdate DATETIME DEFAULT CURRENT_TIMESTAMP,
    tickettitle varchar (50),
    tickettext varchar (1000),
    ticketstate INT DEFAULT 1,
    ticketanswer varchar (1000) DEFAULT null,
    fk_userid INT,
    FOREIGN KEY (fk_userid) REFERENCES users(userid)
);
