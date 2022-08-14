-- CONSTRANS (CONDTIONS)
-- NOT NULL, UNIQUE, DEFAULT, PRIMARY KEY, FOREIGN KEY, 

-- NOT NULL

USE HR;

CREATE TABLE T1(
EMP_ID INT UNSIGNED,
FIRST_NAME VARCHAR(20),
LAST_NAME VARCHAR(20),
SALARY DECIMAL(8,3));
DESC T1;

INSERT INTO T1(FIRST_NAME, LAST_NAME) VALUES ('SURAJ', 'HK');
SELECT *FROM T1;

CREATE TABLE T2(
EMP_ID INT UNSIGNED NOT NULL,
FIRST_NAME VARCHAR(20),
LAST_NAME VARCHAR(20),
SALARY DECIMAL(8,3));
DESC T2;

INSERT INTO T2(EMP_ID, FIRST_NAME, LAST_NAME) VALUES (1,'SURAJ', 'HK');
SELECT *FROM T2;



-- UNIQUE 


CREATE TABLE T3(
EMP_ID INT UNSIGNED NOT NULL UNIQUE,
FIRST_NAME VARCHAR(20),
LAST_NAME VARCHAR(20),
SALARY DECIMAL(8,3));
DESC T3;

INSERT INTO T3(EMP_ID, FIRST_NAME, LAST_NAME) VALUES (1,'SURAJ', 'HK');
SELECT *FROM T3;

ALTER TABLE T3 MODIFY FIRST_NAME VARCHAR(20) NOT NULL;
DESC T3;



-- TO SEE THE INFORMATION ABOUT CONSTRAINS
-- (REFERENCED_COLUMN_NAME, REFERENCED_TABLE_VALUE)

SELECT COLUMN_NAME, CONSTRAINT_NAME 
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'T3';

ALTER TABLE T3 DROP CONSTRAINT EMP_ID;

ALTER TABLE T3 ADD CONSTRAINT T_U UNIQUE (EMP_ID);

SELECT COLUMN_NAME, CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'T3';

ALTER TABLE T3 DROP CONSTRAINT T_U;
SELECT COLUMN_NAME, CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'T3';



-- DEFAULT 


CREATE TABLE T4(
EMP_ID INT UNSIGNED NOT NULL DEFAULT 0,
FIRST_NAME VARCHAR(20),
LAST_NAME VARCHAR(20),
SALARY DECIMAL(8,3));
DESC T4;

INSERT INTO T4(EMP_ID, FIRST_NAME, LAST_NAME) VALUES (1,'SURAJ', 'HK');
SELECT * FROM T4;

INSERT INTO T4(FIRST_NAME, LAST_NAME) VALUES ('SURAJ', 'HK');
SELECT * FROM T4;

SELECT COLUMN_NAME, CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'T4';



-- PRIMARY KEY

-- PRIMARY LEVEL CONSTRAINS

CREATE TABLE T5(
EMP_ID INT UNSIGNED NOT NULL UNIQUE,
FIRST_NAME VARCHAR(20),
LAST_NAME VARCHAR(20) UNIQUE,
SALARY DECIMAL(8,3) UNIQUE);
DESC T5;

SELECT COLUMN_NAME, CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'T5';

--- TABLE LEVEL CONSTRAINS

CREATE TABLE T6(
EMP_ID INT UNSIGNED NOT NULL,
FIRST_NAME VARCHAR(20),
LAST_NAME VARCHAR(20),
SALARY DECIMAL(8,3),
UNIQUE (EMP_ID, LAST_NAME, SALARY));
DESC T6;

SELECT COLUMN_NAME, CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'T6';

ALTER TABLE T6 DROP CONSTRAINT EMP_ID;

SELECT COLUMN_NAME, CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'T6';

CREATE TABLE T8(
EMP_ID INT UNSIGNED,
FIRST_NAME VARCHAR(20),
LAST_NAME VARCHAR(20),
SALARY DECIMAL(8,3),
PRIMARY KEY (EMP_ID, LAST_NAME, SALARY));
DESC T8;

SELECT COLUMN_NAME, CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'T8';


CREATE TABLE T9(
EMP_ID INT UNSIGNED,
FIRST_NAME VARCHAR(20),
LAST_NAME VARCHAR(20),
SALARY DECIMAL(8,3));
DESC T9;

ALTER TABLE T9 ADD PRIMARY KEY (EMP_ID, FIRST_NAME, SALARY);

SELECT COLUMN_NAME, CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'T9';

ALTER TABLE T9 DROP PRIMARY KEY;

ALTER TABLE T9 ADD CONSTRAINT P_I PRIMARY KEY (EMP_ID, FIRST_NAME, SALARY);

SELECT COLUMN_NAME, CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'T9';



-- CHECK

CREATE TABLE T10(
EMP_ID INT UNSIGNED,
FIRST_NAME VARCHAR(20),
LAST_NAME VARCHAR(20),
SALARY DECIMAL(8,3) CHECK(SALARY >0));
DESC T10;

SELECT COLUMN_NAME, CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'T10';

INSERT INTO T10 VALUES (1,'SURAJ','HK',0); -- VIOLATE CHECK CONSTRAINT

INSERT INTO T10 VALUES (1,'SURAJ','HK',1);  -- SALARY ALWAYS GREATER THAN 'CHECK CONSTRAIN'(>0)



-- FOREIGN KEY
-- CAN HAVE MULTIPLE FOREIGN KEY


CREATE TABLE T11(
EMP_ID INT UNSIGNED PRIMARY KEY,
FIRST_NAME VARCHAR(20),
LAST_NAME VARCHAR(20),
SALARY DECIMAL(8,3),
DEPARTMENT_ID INT UNSIGNED);
DESC T11;

CREATE TABLE T12(
DEPARTMENT_ID INT UNSIGNED PRIMARY KEY,
DEPARTMENT_NAME VARCHAR(20));
DESC T12;

-----------------------------------
ALTER TABLE T11 ADD CONSTRAINT T_FK FOREIGN KEY (DEPARTMENT_ID) REFERENCES  T12 (DEPARTMENT_ID);

SELECT COLUMN_NAME, CONSTRAINT_NAME, REFERENCED_COLUMN_NAME, REFERENCED_TABLE_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'T11';

INSERT INTO T12 VALUES (60, 'IT');

INSERT INTO T11 VALUES (1, 'SURAJ','HK', 2000, 60);
SELECT * FROM T11;

DELETE FROM T12 
WHERE DEPARTMENT_ID=60;


-- ON DELETE CANCADE
-- ON DELETE SET NULL

ALTER TABLE T11 ADD CONSTRAINT T_FK FOREIGN KEY (DEPARTMENT_ID) REFERENCES  T12 (DEPARTMENT_ID) ON DELETE CASCADE;

ALTER TABLE T11 ADD CONSTRAINT T_FK FOREIGN KEY (DEPARTMENT_ID) REFERENCES  T12 (DEPARTMENT_ID) ON DELETE SET NULL;


CREATE TABLE T13(
EMP_ID INT UNSIGNED PRIMARY KEY,
FIRST_NAME VARCHAR(20),
LAST_NAME VARCHAR(20),
SALARY DECIMAL(8,3),
DEPARTMENT_ID INT UNSIGNED,
CONSTRAINT T1_FK FOREIGN KEY(DEPARTMENT_ID) REFERENCES T14 (DEPARTMENT_ID));
DESC T13;

CREATE TABLE T14(
DEPARTMENT_ID INT UNSIGNED PRIMARY KEY,
DEPARTMENT_NAME VARCHAR(20));
DESC T14;

SELECT COLUMN_NAME, CONSTRAINT_NAME, REFERENCED_COLUMN_NAME, REFERENCED_TABLE_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'T13';

CREATE TABLE T13(
EMP_ID INT UNSIGNED PRIMARY KEY,
FIRST_NAME VARCHAR(20),
LAST_NAME VARCHAR(20),
SALARY DECIMAL(8,3),
DEPARTMENT_ID INT UNSIGNED,
CONSTRAINT T1_FK FOREIGN KEY(DEPARTMENT_ID) REFERENCES T14 (DEPARTMENT_ID) ON DELETE SET NULL);
DESC T13;

CREATE TABLE T14(
DEPARTMENT_ID INT UNSIGNED PRIMARY KEY,
DEPARTMENT_NAME VARCHAR(20));
DESC T14;


CREATE TABLE T13(
EMP_ID INT UNSIGNED PRIMARY KEY,
FIRST_NAME VARCHAR(20),
LAST_NAME VARCHAR(20),
SALARY DECIMAL(8,3),
DEPARTMENT_ID INT UNSIGNED,
CONSTRAINT T1_FK FOREIGN KEY(DEPARTMENT_ID) REFERENCES T14 (DEPARTMENT_ID) ON DELETE SET NULL ON UPDATE CASCADE);
DESC T13;

CREATE TABLE T14(
DEPARTMENT_ID INT UNSIGNED PRIMARY KEY,
DEPARTMENT_NAME VARCHAR(20));
DESC T14;

INSERT INTO T14 VALUES (60, 'IT');

INSERT INTO T13 VALUES (1, 'SURAJ','HK', 2000, 60);

UPDATE T13
SET DEPARTMENT_ID=90
WHERE DEPARTMENT_ID=60;

SELECT *FROM T13;
SELECT *FROM T14;