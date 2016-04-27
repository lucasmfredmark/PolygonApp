DROP DATABASE IF EXISTS polygon;
CREATE DATABASE polygon;
USE polygon;

CREATE TABLE users (
    userid INT AUTO_INCREMENT PRIMARY KEY,
    udate DATETIME DEFAULT CURRENT_TIMESTAMP, /* Creation date */
    usermail VARCHAR(255) UNIQUE, /* Login */
    userpass VARCHAR(20),
    usertype ENUM('CUSTOMER','ADMIN') DEFAULT 'CUSTOMER',
    fullname VARCHAR(50)
);

INSERT INTO users (usermail, userpass, fullname) VALUES ('test@user.dk','test','Test User');
INSERT INTO users (usermail, userpass, usertype, fullname) VALUES ('admin@polygon.dk','admin','ADMIN','Admin User');

CREATE TABLE buildings (
    buildingid INT AUTO_INCREMENT PRIMARY KEY,
    bdate DATETIME DEFAULT CURRENT_TIMESTAMP, /* Creation date */ 
    bname VARCHAR(40), /* Building identification */
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
    ddate DATETIME DEFAULT CURRENT_TIMESTAMP, /* Creation date */
    dnote VARCHAR(100), /* Description of document */
    dpath VARCHAR(255) UNIQUE, /* Unique path */
    fk_buildingid INT,
    fk_userid INT, /* To identify admin uploads */
    FOREIGN KEY (fk_buildingid) REFERENCES buildings(buildingid),
    FOREIGN KEY (fk_userid) REFERENCES users(userid)
);

CREATE TABLE orders (
	orderid INT AUTO_INCREMENT PRIMARY KEY,
    odate DATETIME DEFAULT CURRENT_TIMESTAMP, /* Creation date */
    ostatus INT DEFAULT 0, /* 0 = Incomplete : 1 = Complete */
    odone DATETIME, /* Completion date */
    fk_buildingid INT,
    FOREIGN KEY (fk_buildingid) REFERENCES buildings(buildingid)
);
INSERT INTO orders (fk_buildingid) VALUES (1);
INSERT INTO orders (fk_buildingid) VALUES (3);
INSERT INTO orders (fk_buildingid) VALUES (5);
INSERT INTO orders (fk_buildingid) VALUES (7);

CREATE TABLE checkups (
	checkupid INT AUTO_INCREMENT PRIMARY KEY,
    cdate DATETIME DEFAULT CURRENT_TIMESTAMP, /* Creation date */
    cpath VARCHAR(255) UNIQUE, /* Unique path */
    conditionlevel INT,
    fk_buildingid INT,
    fk_orderid INT,
    FOREIGN KEY (fk_buildingid) REFERENCES buildings(buildingid),
    FOREIGN KEY (fk_orderid) REFERENCES orders(orderid)
);

CREATE TABLE damages (
	damageid INT AUTO_INCREMENT PRIMARY KEY,
    dmgdate DATETIME DEFAULT CURRENT_TIMESTAMP, /* Creation date */
    dmgtitle VARCHAR(50),
    dmgdesc TEXT,
    fk_buildingid INT,
    FOREIGN KEY (fk_buildingid) REFERENCES buildings(buildingid)
);

CREATE TABLE tickets (
	ticketid INT AUTO_INCREMENT PRIMARY KEY,
    ticketdate DATETIME DEFAULT CURRENT_TIMESTAMP, /* Creation date */
    tickettitle varchar (50),
    tickettext varchar (1000),
    ticketstate INT DEFAULT 1,
    ticketanswer varchar (1000) DEFAULT null,
    fk_userid INT,
    FOREIGN KEY (fk_userid) REFERENCES users(userid)
)
