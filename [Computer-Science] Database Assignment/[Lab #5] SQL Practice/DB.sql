sqlplus "/" as sysdba

grant all privileges to knu;

conn knu/comp322;

DROP TABLE DEPARTMENT CASCADE CONSTRAINT;

CREATE TABLE EMPLOYEE(
	Fname	VARCHAR(15)	NOT NULL,
	Minit	CHAR,
	Lname	VARCHAR(15),
	Ssn	CHAR(9),
	Bdate	DATE,
	Address	VARCHAR(30),
	Sex	CHAR,
	Salary	NUMBER(10,2),
	Super_ssn	CHAR(9),
	Dno	NUMBER DEFAULT 1 NOT NULL,
	PRIMARY KEY	(Ssn)
);

CREATE TABLE DEPARTMENT(
	Dname	VARCHAR(15)	NOT NULL,
	Dnumber	NUMBER		NOT NULL,
	Mgr_ssn	CHAR(9)		DEFAULT '888665555' NOT NULL,
	Mgr_start_date		DATE,
	PRIMARY KEY	(Dnumber),
	UNIQUE	(Dname),
	FORIEIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn)
);

CREATE TABLE DEPT_LOCATIONS(
	Dnumber		NUMBER		NOT NULL,
	Dlocation		VARCHAR(15)	NOT NULL,
	PRIMARY KEY	(Dnumber, Dlocation),
	FOREIGN KEY	(Dnumber) REFERENCES DEPARTMENT(Dnumber)
);

CREATE TABLE PROJECT(
	Pname		VARCHAR(15)	NOT NULL,
	Pnumber		NUMBER		NOT NULL,
	Plocation	VARCHAR(15),
	Dnum		NUMBER 		NOT NULL,
	PRIMARY KEY	(Pnumber),
	UNIQUE	(Pname),
	FORIEIGN KEY (Dnum) REFERENCES DEPARTMENT(Dnumber)
);

CREATE TABLE WORKS_ON(
	Essn	CHAR(9)		NOT NULL,
	Pno	NUMBER		NOT NULL,
	Hours	DECIMAL(3,1),
	PRIMARY KEY	(Essn, Pno),
	FOREIGN KEY	(Essn) REFERENCES EMPLOYEE(Ssn),
	FOREIGN KEY	(Pno) REFERENCES PROJECT(Pnumber)
);

-- Add
ALTER TABLE DEPARTMENT ADD FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn) ON DELETE SET NULL;
ALTER TABLE EMPLOYEE ADD FOREIGN KEY (Super_ssn) REFERENCES EMPLOYTEE(Ssn) ON DELETE SET NULL;

-- INSERT DEPT_LOCATIONS
INSET INTO DEPT_LOCATIONS VALUES (1, 'Houston');
INSET INTO DEPT_LOCATIONS VALUES (4, 'Stafford');
INSET INTO DEPT_LOCATIONS VALUES (5, 'Bellaire');
INSET INTO DEPT_LOCATIONS VALUES (5, 'Houston');
INSET INTO DEPT_LOCATIONS VALUES (5, 'Sugarland');

-- INSERT WORKS_ON
INSERT INTO WORKS_ON VALUES ('123456789', 1, 32.5);
INSERT INTO WORKS_ON VALUES ('123456789', 2, 7.5);
INSERT INTO WORKS_ON VALUES ('666884444', 3, 40);
INSERT INTO WORKS_ON VALUES ('453453453', 1, 20);
INSERT INTO WORKS_ON VALUES ('453453453', 2, 20);
INSERT INTO WORKS_ON VALUES ('333445555', 2, 10);
INSERT INTO WORKS_ON VALUES ('333445555', 3, 10);
INSERT INTO WORKS_ON VALUES ('333445555', 10, 10);
INSERT INTO WORKS_ON VALUES ('333445555', 20, 10);
INSERT INTO WORKS_ON VALUES ('999887777', 30, 30);
INSERT INTO WORKS_ON VALUES ('999887777', 10, 10);
INSERT INTO WORKS_ON VALUES ('987987987', 10, 35);
INSERT INTO WORKS_ON VALUES ('987987987', 30, 5);
INSERT INTO WORKS_ON VALUES ('987654321', 30, 20);
INSERT INTO WORKS_ON VALUES ('987654321', 20, 15);
INSERT INTO WORKS_ON VALUES ('987654321', 20);

-- Lab #5-3
SELECT Fname, Minit, Lname FROM EMPLOYEE WHERE Salary >= 25000 ORDER BY Lname ASC;
SELECT Fname, Lname FROM EMPLOYEE WHERE LIKE '%Houston, TX%' AND Ssn='333445555';
SELECT Pname FROM PROJECT ORDER BY DESC;

-- Lab #5-4
DELETE FROM DEPENDENT WHERE Essn='987654321';
SELECT * FROM DEPENDENT;

DELETE FROM DEPARTMENT WHERE Dnumber=1;
SELECT * FROM DEPARTMENT;

DELETE FROM WORKS_ON WHERE Pno=30;
SELECT * FROM WORKS_ON;

UPDATE PROJECT SET Plocation='Houston', Dnum=1 WHERE Dnum=5;
SELECT * FROM PROJECT;
UPDATE EMPLOYEE SET Super_ssn=null WHERE Super_ssn='888665555';
SELECT * FROM EMPLOYEE;
UPDATE PROJECT SET Pnumber=40 WHERE Pnumber=30;
SELECT * FROM PROJECT;

** set default Orcle ���� X