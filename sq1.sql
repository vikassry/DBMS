(creating table space with given  datafile)
	CREATE TABLESPACE myspace DATAFILE 'C:\ORACLEXE\APP\ORACLE\ORADATA\XE\myspace.dbf'  SIZE 100M AUTOEXTEND ON;

(to see data files)
 	select name from V$datafile;

(create user on ur tablespace)
 	create user sms identified by vikashamal default tablespace myspace quota unlimited on myspace;

giving priviliges to users;
	grant resource to sms; (for creating tables)
	grant create session to sms; (for login sessions)


to see all tables tables 
	select * from tab;

create tables
	
--------------------------------------------------------------------------------------------------------
DESC V$datafile
selsect name, ts# from V$datafile

selsect name, ts# from V$tablespace;
select name, ts# from V$datafile where ts#='4';


select to_char(sysdate,'DD-MM-YYYY HH:MM:SS') from dual;
	(to convert date in given format)
----------------------------------------------------------------------------------------------------------
select * from tab; (to see all tables and views sequenc creasted  by the user)
---------------------------------------------------------------------
sequenc 
	create sequenc emp_pk start with 1;
		select emp_pk.nextval from dual;
---------------------------------------------------------------------------------------------------
	select * from employee where rownum <= 4;		(selection)


select e.id, e.name, d.dept_name from employee e, department d where e.dept_id = d.id;

select e.id, e.name, d.dept_name from employee e JOIN department d on (e.dept_id = d.id);  //for same column but differnt column-names

select e.id, e.name, d.dept_name from employee e join department d on (dept_id); // for same coulumn with same name;

select sum(e.salary) from employee e join department d on(e.dept_id=d.id) where d.dept_name='SALES' AND e.gender='F'; (sum of females salary from sales dept.)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

grant create view to emp_user; (to grant privilige)

CREATE VIEW sales_employ AS select e.name, d.dept_name from employee e join department d on (e.dept_id=d.id) where d.dept_name='SALES';
select * from prod_employee;
(create or replace view view_name AS ...)
grant select on prod_employee to reporter; (grant view access to new user - reporter)
select * from emp_user.prod_employee;		(access from reporter after logging as reporter)
select * from all_views (all views)
select * from user_views (only user views)
-------------------------------------------------------------------------------------------------------------------

	grant create synonym to emp_user; (grant to emp_user for creating synonym)
	create SYNONYM s for prod_employee; (create synonym named 's')
	select * from s; (access synonym s)
--------------------------------------------------------------------------------------------------------------------
 (set operators)
 select e.id, e.name from employee e join department d on(e.dept_id=d.id) where d.id=2001 
 	UNION  select e.id, e.name from employee e join department d on(e.dept_id=d.id) where d.id=2002;
select distinct dept_id from employee; (to get uniq values from 1 column like union)
select unique(gender) from employee;
-------------------------------------------------------------------------------------------------------------------

create table emp_2 as 
	select * from  employee   (To create another copy of employee table as emp_2 bt wont have primary key and other constraints (except NOT NULL))

create table emp_2 as 
	select * from  employee where 1=2;	
--------------------------------------------------------------------------------------------------------------------------------
(Group by)
	select d.dept_name name ,max(e.salary)sal from employee e join department d on(e.dept_id=d.id) group by d.dept_name; 
			(get max salary from each dept)

	select d.dept_name,e.gender, max(e.salary)sal from employee e join department d on(e.dept_id=d.id) group by d.dept_name, e.gender;
			(get max salary of each gender from each dept)

select d.dept_name,e.name, e.gender,e.salary from employee e join department d on(e.dept_id=d.id) where salary in 
(select d.dept_name,e.gender, max(e.salary)sal from employee e join department d on(e.dept_id=d.id) group by d.dept_name, e.gender);


-- select e.id, e.name from employee e join department d on(e.dept_id=d.id) where e.salary in (select avg(e.salary) from employee e join department d on (d.id=e.dept_id) group by e.dept_id);
-- select d.dept_name, avg(e.salary) from employee e join department d on(e.dept_id=d.id) group by d.dept_name;
select e.id, e.name, e.salary, e.dept_id, a.avg_sal from employee e , (select dept_id, avg(salary) as avg_sal from employee group by(dept_id)) a where(a.dept_id = e.dept_id);