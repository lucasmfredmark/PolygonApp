DROP DATABASE IF EXISTS polygon;
CREATE DATABASE polygon;

USE polygon;

DROP TABLE IF EXISTS documents;
DROP TABLE IF EXISTS checkups;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS services;
DROP TABLE IF EXISTS buildings;
DROP TABLE IF EXISTS users;

CREATE TABLE users ( /* MIDLERTIDIGT INGEN FOREIGN KEY */
    userid INT AUTO_INCREMENT PRIMARY KEY,
    udate DATETIME DEFAULT CURRENT_TIMESTAMP,
    username VARCHAR(20),
    userpass VARCHAR(20),
    usertype ENUM('CUSTOMER','ADMIN') DEFAULT 'CUSTOMER',
    fullname VARCHAR(50),
    email VARCHAR(40)
);

INSERT INTO users (username, userpass, fullname, email) VALUES ('test','123','Power User','test@polygon.dk');
INSERT INTO users (username, userpass, fullname, email) VALUES ('Admin','foobar','Power User','admin@polygon.dk');
INSERT INTO users (username, userpass, fullname, email) VALUES ('John','123','John Doe','john@doe.com');
INSERT INTO users (username, userpass, fullname, email) VALUES ('Jane','321','Jane Doe','jane@doe.com');

CREATE TABLE buildings (
    buildingid INT AUTO_INCREMENT PRIMARY KEY,
    bdate DATETIME DEFAULT CURRENT_TIMESTAMP,
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
    ddate DATETIME DEFAULT CURRENT_TIMESTAMP,
    dpath VARCHAR(100),
    fk_buildingid INT,
    FOREIGN KEY (fk_buildingid) REFERENCES buildings(buildingid)
);

CREATE TABLE orders (
	orderid INT AUTO_INCREMENT PRIMARY KEY,
    odate DATETIME DEFAULT CURRENT_TIMESTAMP,
    ostatus INT, /* 0 = Incomplete, 1 = Complete */
    fk_serviceid INT,
    fk_userid INT,
    fk_buildingid INT,
    FOREIGN KEY (fk_serviceid) REFERENCES services(serviceid),
    FOREIGN KEY (fk_userid) REFERENCES users(userid),
    FOREIGN KEY (fk_buildingid) REFERENCES buildings(buildingid)
);

CREATE TABLE checkups (
	checkupid INT AUTO_INCREMENT PRIMARY KEY,
    cdate DATETIME DEFAULT CURRENT_TIMESTAMP,
    cpath VARCHAR(100),
    conditionlevel INT,
    fk_orderid INT,
    FOREIGN KEY (fk_orderid) REFERENCES orders(orderid)
);
