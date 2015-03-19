
conn / as sysdba

PROMPT 'Creating Tablespaces'

-- Create tablespaces
CREATE TABLESPACE ts_emp_system DATAFILE 'C:\ORACLEXE\APP\ORACLE\ORADATA\XE\emp_system_01.dbf' SIZE 200M AUTOEXTEND ON;
PROMPT '.... Tablespace creation completed.'


DROP USER emp_user CASCADE;

-- Creating users
PROMPT 'Creating user'
CREATE USER emp_user IDENTIFIED BY password DEFAULT TABLESPACE ts_emp_system QUOTA UNLIMITED ON ts_emp_system;
GRANT CREATE SESSION TO emp_user;
GRANT RESOURCE TO emp_user;
PROMPT '.... User created with required privileges'

-- Connect as the schema user
PROMPT 'Connecting as Employee user'
conn emp_user/password

-- Cleanup object before creating 
/* Uncomment when necessary */
-- DROP TABLE department CASCADE CONSTRAINTS;
-- DROP TABLE employee CASCADE CONSTRAINTS;
-- DROP SEQUENCE seq_emp_id;


-- Create Employee table
CREATE TABLE employee (
id			NUMBER(10),
name		VARCHAR(50) NOT NULL,
pan_number	VARCHAR(10) NOT NULL UNIQUE,
gender		CHAR(1),
cell_phone	VARCHAR(15),
CONSTRAINT emp_pk PRIMARY KEY(id),
CONSTRAINT emp_gender_chk CHECK(gender IN ('M', 'F','T') )
);

-- Create Department table - an example to create a table in a desired tablespace
CREATE TABLE department (
id			NUMBER(10),
dept_name	VARCHAR(50),
CONSTRAINT dept_pk PRIMARY KEY(id)
) TABLESPACE ts_emp_system; 

-- Create constraints
ALTER TABLE department ADD CONSTRAINT dept_name_u UNIQUE(dept_name);

-- Sequence
CREATE SEQUENCE seq_emp_id START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;


-- Let us add SALARY column to employee table
ALTER TABLE employee ADD (salary number(10) );
ALTER TABLE employee ADD (dept_id NUMBER(10) );

-- Insert sample data
INSERT INTO department VALUES (2001,'PRODUCTION');
INSERT INTO department VALUES (2002,'SALES');
INSERT INTO department VALUES (2003,'MARKETING');
INSERT INTO department VALUES (2004,'SUPPORT');

COMMIT;

INSERT INTO employee VALUES (seq_emp_id.nextval,'AAAA','ABCXX1000Z','M',9999900001,20000,2002);
INSERT INTO employee VALUES (seq_emp_id.nextval,'AAAB','ABCXX1001Z','M',9999900002,18500,2001);
INSERT INTO employee VALUES (seq_emp_id.nextval,'AAAC','ABCXX1002Z','F',9999900003,63000,2001);
INSERT INTO employee VALUES (seq_emp_id.nextval,'AAAD','ABCXX1003Z','M',9999900004,7500,2003);
INSERT INTO employee VALUES (seq_emp_id.nextval,'AAAE','ABCXX1004Z','F',9999900005,30000,2002);
INSERT INTO employee VALUES (seq_emp_id.nextval,'AAAF','ABCXX1005Z','F',9999900006,24000,2001);
INSERT INTO employee VALUES (seq_emp_id.nextval,'AAAF','ABCXX1006Z','F',9999900007,52000,2002);
INSERT INTO employee VALUES (seq_emp_id.nextval,'AAAG','ABCXX1007Z','M',9999900008,14000,2003);
INSERT INTO employee VALUES (seq_emp_id.nextval,'AAAH','ABCXX1008Z','M',9999900009,18500,2003);
INSERT INTO employee VALUES (seq_emp_id.nextval,'AAAI','ABCXX1009Z','M',9999900010,18500,2001);

COMMIT;