create database Cars_Admin;

use Class_Info;

CREATE TABLE IF NOT EXISTS students(
   id INT UNSIGNED AUTO_INCREMENT,
   stuNum VARCHAR(15) NOT NULL,
   stuName VARCHAR(10) NOT NULL,
   stuPhone VARCHAR(11),
   etype int NOT NULL,
   QQNum VARCHAR(20),
   Mail VARCHAR(20),
   pwd VARCHAR(15) NOT NULL,
   PRIMARY KEY ( id )
);

ALTER TABLE students ADD unique(`stuNum`);