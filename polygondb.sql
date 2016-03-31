CREATE DATABASE polygon;
USE polygon;

CREATE TABLE users ( /* MIDLERTIDIGT INGEN FOREIGN KEY */
    userid INT AUTO_INCREMENT PRIMARY KEY,
    udate DATETIME,
    username VARCHAR(20),
    userpass VARCHAR(20),
    usertype ENUM('customer','admin'),
    fullname VARCHAR(50),
    email VARCHAR(40)
);

CREATE TABLE buildings (
    buildingid INT AUTO_INCREMENT PRIMARY KEY,
    bdate DATETIME,
    bname VARCHAR(50),
    address VARCHAR(50),
    parcelnumber VARCHAR(20),
    size INT, /* Kvadratmeter m2 */
    conditionlevel INT,
    fk_userid INT,
    FOREIGN KEY (fk_userid) REFERENCES users(userid)
);

CREATE TABLE services ( /* ID 1 = HEALTH CHECKUPS */
	serviceid INT PRIMARY KEY,
    service VARCHAR(100)
);

CREATE TABLE documents (
	documentid INT AUTO_INCREMENT PRIMARY KEY,
    ddate DATETIME,
    dpath VARCHAR(100),
    fk_buildingid INT,
    FOREIGN KEY (fk_buildingid) REFERENCES building(buildingid)
);

CREATE TABLE orders (
	orderid INT AUTO_INCREMENT PRIMARY KEY,
    odate DATETIME,
    ostatus INT, /* 0 = Incomplete, 1 = Completed */
    fk_serviceid INT,
    fk_userid INT,
    fk_buildingid INT,
    FOREIGN KEY (fk_serviceid) REFERENCES service(serviceid),
    FOREIGN KEY (fk_userid) REFERENCES users(userid),
    FOREIGN KEY (fk_buildingid) REFERENCES buildings(buildingid)
);

CREATE TABLE checkups (
	checkupid INT AUTO_INCREMENT PRIMARY KEY,
    cdate DATETIME,
    cdate DATE,
    cpath VARCHAR(100),
    conditionlevel INT,
    fk_orderid INT,
    FOREIGN KEY (fk_orderid) REFERENCES orders(orderid)
);