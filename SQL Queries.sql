-- _______________________________________________________________________

-- STEPS TO FOLLOW FOR GOOD SCHEMA DESIGN AND IMPLEMENTATIONS

-- --  Initial Ideas
-- -- 1. business requirement - basis
-- -- 2. table
-- -- 3. data type 
-- -- 4. remove repitions
-- -- 5. relationship b/w tables

-- _______________________________________________________________________

-- Next Pointers

-- 1. Business requirement 
-- -> type of entities invloved
-- -> type of users that will be using
-- -> type of access to be given for reading the data
-- -> data sensitivity
-- -> automations required

-- 2. Entity relation
-- -> Entity attributes and their type
-- -> Relationship between entities
-- -> redundant attributes/values

-- 3. Table specific constraints
-- -> Entity relation, constraints and keys - primary, unique and foreign 
-- -> datatype -> most apt datatype..
-- -> Indexes 
-- -> redundancy relevancy
-- -> implementation of encryptions

-- 4. Table creation and db schema design

-- 5. Review of tables and db schema

-- 6. Automations/programming
-- Reviews and alteration of table for and with: 
-- -> transactions
-- -> triggers
-- -> stored procedures

-- 7. Maintenance:
-- -> updation of constraints and indexes if required
-- -> implementation of encryptions
-- -> backup and recovery
-- -> replication
-- -> user management and security

	
-- Creating the Database and Table
	-- Creating a Database:
	CREATE DATABASE `company_database`;

	-- Selecting a database as default -> usually already set as default in Workbench
	USE `company_database`;

	-- Creating you First Table:
	CREATE TABLE `company_database`.`adminuser` (
	  `id` INT NOT NULL AUTO_INCREMENT,
	  `name` VARCHAR(75) NOT NULL,
	  `password` VARCHAR(45) NOT NULL,
	  `is_admin` TINYINT NOT NULL DEFAULT 0,
	  PRIMARY KEY (`id`));

-- Altering a Table

	-- Altering the table to rename it 
		-- Method 1
		ALTER TABLE `adminuser` RENAME TO `companyusers`;
		-- Method 2
		ALTER TABLE `company_database`.`adminuser` RENAME TO  `company_database`.`companyusers` ;
	
	-- Altering a table to add new column
	ALTER TABLE `companyusers` ADD `email` VARCHAR(45) NOT NULL;

-- Insert Statements

	-- Inserting Values in form of Tuples
	INSERT INTO `companyusers` (`name`,`password`,`email`) VALUES ('John Doe','123456','doe@johnney.com');
	
	-- Inserting Values in form of tuples with attributes(column names) in different order
	INSERT INTO `companyusers` (`name`,`password`,`email`,`is_admin`) VALUES ('Jane Doe','123456','doe@jane.com',1);

	-- Inserting Multiple Tuples
	INSERT INTO `companyusers` 
	(`name`,`password`,`email`,`is_admin`) 
	VALUES 
	('Sam','123456','sam@google.com',0),
	('Kenny','123456','kenny@google.com',1),
	('Tim','123456','tim@google.com',1);

-- Update Statements

	-- Updating an existing row in the table
	UPDATE `companyusers` SET `password`='abcde' WHERE `name` LIKE 'Sam';

	UPDATE `companyusers` SET `password`='qwerty' WHERE `name` LIKE '%a%';

	-- Updating multiple columns of a row at same time
	UPDATE `companyusers` SET `password`='qwerty', `email`="tim@lee.com" WHERE `name` LIKE 'Tim';

	--  Update the coloumn - movie_category as classic if movie was released in 1970's

	UPDATE `movie_database` SET `movie_category`='classic' WHER `release_year` LIKE '197_'

		-- '197%' = 1978888
		-- '197_' = 1971 or 197a

	-- first names that have 3 letters

	SELECT * FROM `marks` WHERE CHAR_LENGTH(`name`) = 3;

		-- OR

	SELECT * FROM `marks` WHERE `name` like '___';
-- Deleting multiple rows

	INSERT INTO `companyusers` (`name`,`password`,`email`) VALUES ('John Doe','123456','doe@johnney.com');
	-- Method 1
		DELETE FROM `companyusers` WHERE `id` = 6 || `id` = 7 or `id` = 8;
	-- Method 2
		DELETE FROM `companyusers` WHERE `id` in (6,7,8);

-- Select Statements

	SELECT `name` from `companyusers` WHERE `is_admin`=1; -- Getting list of names from rows with the given condition
	SELECT count(`name`) from `companyusers` WHERE `is_admin`=1; -- Counts the number of rows with the given condition
	SELECT max(`id`) from `companyusers`; -- Extracts Max id value in the given records
	SELECT avg(`id`) from `companyusers`; -- Extracts Average of all the id values in the given records
	SELECT sum(`id`) from `companyusers`; -- Extracts Sum of all the id values in the given records
	SELECT 2+2 from `companyusers`; -- Prints result of arithmetic operators instead of rows.
	
	--Using logical operators - && and also condition of BETWEEN
	SELECT `id`,`name` from `companyusers` WHERE `id` BETWEEN 2 AND 4 && `name` LIKE 'Kenny';
	
	-- Orders the rows in alphabetical descending order with respect to the value in column 'name'
	SELECT `id`,`name` from `companyusers` ORDER BY `name` DESC;
	
	-- Orders the rows in numeric ascending order with respect to the value in column 'id'
	SELECT `id`,`name` from `companyusers` ORDER BY `id` ASC;

	--  wildcard comparisions with '%'
	SELECT * FROM `companyusers` WHERE `name` LIKE '%e' or `name` LIKE 'S%';

	-- DISTINCT

	-- fetching distinct/unique values in a column
	SELECT DISTINCT `password` FROM `companyusers`;

	-- ORDER BY
	SELECT `id` from `companyusers` ORDER BY `id` DESC; -- Normal Order BY - sorts by id in descending order
	SELECT `id` from `companyusers` ORDER BY `id` DESC LIMIT 0,1; -- same as SELECT `id` from `companyusers` ORDER BY `id` DESC LIMIT 1;  
	SELECT `id` from `companyusers` ORDER BY `id` DESC LIMIT 1,1; -- Fetches Second item in the fetched rows
	SELECT `id` from `companyusers` ORDER BY `id` DESC LIMIT 0,2; -- Same as SELECT `id` from `companyusers` ORDER BY `id` DESC LIMIT 2; 
	SELECT `id` from `companyusers` ORDER BY `id` DESC LIMIT 1,2; -- Fetches 2nd and 3rd value of the fetched rows
	SELECT `id` from `companyusers` ORDER BY `id` DESC LIMIT 2,1; -- Fetches the item on index 2 of fetched rows
	SELECT `id` from `companyusers` ORDER BY `id` DESC LIMIT 2,3; -- Fetches 3 rows after the index 2, with index 2 included
	SELECT `id` from `companyusers` ORDER BY `id` DESC LIMIT 1,3; -- Fetches 3 rows after the index 1, with index 1 included

	-- using length() function in queries
	SELECT `name`, length(`name`) FROM `companyusers` where length(`name`)<5;
	SELECT `password`, length(`password`) FROM `companyusers`;

	-- GROUP BY

	-- Using Group by to fetch the frequency of items in one category
	SELECT `password` as 'UnqiuePasswords',count(`name`) as 'NamesPass' FROM `companyusers` group by `password`;
	-- Applying Condition on Group Size 
	SELECT `password` as 'UnqiuePasswords',count(`name`) as 'NamesPass' FROM `companyusers` group by `password` HAVING NamesPass>2;





-- ______________________________________________


CREATE TABLE `company_database`.`companyroles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user` INT NOT NULL,
  e`dpartment` INT NOT NULL,
  `salary` DOUBLE NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_user_idx` (`user` ASC) VISIBLE,
  INDEX `fk_department_idx` (`department` ASC) VISIBLE,
  CONSTRAINT `fk_user`
    FOREIGN KEY (`user`)
    REFERENCES `company_database`.`companyusers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_department`
    FOREIGN KEY (`department`)
    REFERENCES `company_database`.`departments` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


ALTER TABLE `company_database`.`companyusers` 
ADD INDEX `ind_email` (`email` ASC) VISIBLE;
;

ALTER TABLE `company_database`.`companyusers` 
ADD UNIQUE INDEX `uq_email` (`email` ASC) VISIBLE;
;


-- ______________________________________________

-- 1. Aliases
	Select * from `companyusers` `cu`;
-- 2. Joins

	Select colnames from table1 t1 join name table2 t2 on t1.col operator t2.col;

	-- Inner - Old format
		Select * from `companyusers` `cu`,`companyroles` `cr` where `cu`.`id`=`cr`.`id`;

	-- 	cu	
	-- 	1
	-- 	2
	-- 	3
	-- 	4
	-- 	5

	-- 	cr
	-- 	1 dsfsd

	-- 	when no condition is given
	-- 	1	1 dsfsd
	-- 	2	1 dsfsd
	-- 	3	1 dsfsd

	-- 	where cu.id=cr.id
	-- 	1	1 dsfsd


	-- Inner - New format

		SELECT cu.username AS Name, cr.salary AS Sal FROM companyusers cu INNER JOIN companyroles cr ON cu.id=cr.id

		-- Name 		Sal
		-- john doe	364877


	-- Outer Left - or Left Join

		SELECT `cu`.`username` AS Name, cr.salary AS Sal FROM companyusers cu LEFT JOIN companyroles cr ON cu.id=cr.id;

		-- John doe 	364877
		-- Jane doe 	NULL
		-- Tim Lee		NULL

	-- Outer Right - or Right Join

		SELECT cu.username AS Name, cr.salary AS Sal FROM companyusers cu RIGHT JOIN companyroles cr ON cu.id=cr.id;

		-- John doe 	364877
		-- NULL 		125565

	-- Complete - Full Outer

		-- SELECT cu.username AS Name, cr.salary AS Sal FROM companyusers cu FULL OUTER JOIN companyroles cr ON cu.id=cr.id

		(SELECT `cu`.`username` AS Name, cr.salary AS Sal FROM companyusers cu LEFT JOIN companyroles cr ON cu.id=cr.id)
		UNION
		(SELECT cu.username AS Name, cr.salary AS Sal FROM companyusers cu RIGHT JOIN companyroles cr ON cu.id=cr.id);


		-- John doe 	364877
		-- NULL 		125565
		-- Jane doe 	NULL
		-- Tim Lee		NULL

		--- UNION ALL, INTERSECT and EXCEPT/MINUS

		(SELECT `cu`.`username` AS Name, cr.salary AS Sal FROM companyusers cu LEFT JOIN companyroles cr ON cu.id=cr.id)
		UNION ALL
		(SELECT cu.username AS Name, cr.salary AS Sal FROM companyusers cu RIGHT JOIN companyroles cr ON cu.id=cr.id);


		-- John doe 	364877
		-- John doe 	364877
		-- NULL 		125565
		-- Jane doe 	NULL
		-- Tim Lee		NULL

		-- (SELECT `cu`.`username` AS Name, cr.salary AS Sal FROM companyusers cu LEFT JOIN companyroles cr ON cu.id=cr.id)
		-- MINUS
		-- (SELECT cu.username AS Name, cr.salary AS Sal FROM companyusers cu RIGHT JOIN companyroles cr ON cu.id=cr.id);

		-- NULL 		125565
		-- Jane doe 	NULL
		-- Tim Lee		NULL

		-- ONLY WORKS in MS SQL or ORACLE not in MYSQL.. Alternate to Minus/Except in Mysql is to use left/right joins

		-- (SELECT `cu`.`username` AS Name, cr.salary AS Sal FROM companyusers cu LEFT JOIN companyroles cr ON cu.id=cr.id)
		-- INTERSECT
		-- (SELECT cu.username AS Name, cr.salary AS Sal FROM companyusers cu RIGHT JOIN companyroles cr ON cu.id=cr.id);

		-- John doe 	364877

		-- ONLY WORKS in MS SQL or ORACLE not in MYSQL.. Alternate to Intersect in Mysql is to use inner joins


	-- Find second largest salary in a table.

	Select cr1.salary from companyroles cr1 inner join companyroles cr2 on cr1.salary < cr2.salary

	Select cr1.salary from companyroles cr1 where cr1.salary not in (select cr2.salary from companyroles cr2 order by DESC Limit 3,-1)

-- NESTED QUERY


-- -> Select Statement/Delete 
-- -> Base Table Name
-- -> Where Clause
-- -> Operand 
-- -> operator 
-- -> SubQuery

-- Find the number of employees who has been allocated a department in the company database.
-- Select count(*) 
-- from company_user 
-- where 
-- id 
-- in 
-- (Select DISTINCT user from company_roles);

-- Find the number of employees who had been allocated a department in the company database before their termination.
-- Select count(*) 
-- from company_user 
-- where 
-- (id 
-- in 
-- (Select DISTINCT user from company_roles))
-- and
-- (id
-- in
-- (Select Distinct user from termnitated_employees));


-- usertab

-- id
-- name
-- email



-- salary
-- id
-- user_id
-- designation
-- salary


select ut.* from usertab ut where ut.id in (Select sal.user_id from salary sal where sal.salary>20000);
-- ____________________________________________________

-- DISTICT and EXISTS	and NOT EXISTS	

-- stores

-- id	store_type
-- 1	fashion
-- 2	pawn
-- 3 	auto


-- cities_stores
-- id 		city_name 		store_type
-- 1 		delhi		 	fashion
-- 2		delhi 			auto
-- 3		gwalior			auto
-- 4 		mumbai		 	auto
-- 5		mumbai		 	fasion
-- 6		shimla			auto			



-- What kind of store is present in one or more cities?
SELECT DISTINCT store_type FROM stores 
WHERE EXISTS 
(SELECT * FROM cities_stores WHERE cities_stores.store_type = stores.store_type);
-- What kind of store is present in no cities?
SELECT DISTINCT store_type FROM stores 
WHERE NOT EXISTS 
(SELECT * FROM cities_stores WHERE cities_stores.store_type = stores.store_type);

SELECT s1 FROM t1 WHERE s1 > ALL (SELECT s1 FROM t2);

-- fetch the movies released after the classics were release
SELECT movie_name from movie_db where movie_year > ALL (SELECT movie_year from movie_list where movie_category like 'classic');
-- > (1971, 1998, 1992, 1994)

-- ________________________________


-- - USING CONDITIONS in MYSQL

-- 1. IF functions

-- if(condition,truestatement,falsestatement)

-- if(a%2==0,"even","odd")

Select user,salary, if(salary%2==0,"even","odd") as "even-odd" FROM company_roles;

-- 2. CASE blocks

-- CASE

-- 	WHEN cond1 THEN statement1
-- 	WHEN cond2 THEN statement2
-- 	WHEN cond3 THEN statement3
-- 	.
-- 	.
-- 	.
-- 	ELSE final-statement

-- END

-- marks	grade
-- 0-39	 F
-- 40-70	 C
-- 70-80	 B
-- 80-100	 A

Select student_name,marks, 
CASE
	WHEN (marks<=39) THEN "F"
	WHEN (marks>39 and marks<=70) THEN "C"
	WHEN (marks>70 and marks<=80) THEN "B"
	WHEN (marks>80) THEN "A"
	ELSE "N-A"
END
as "Grade"
FROM student_marks;

-- ________________________________

-- LOOPS as used in stored procedures

-- BEGIN

--    DECLARE income INT;

--    SET income = 0;

--    label1: LOOP
--      SET income = income + starting_value;
--      IF income < 4000 THEN
--        ITERATE label1;
--      END IF;
--      LEAVE label1;
--    END LOOP label1;

--    RETURN income;

-- END; //


-- ____________________________________


-- Formating date as per our requirement using DATE_FORMAT()

Select DATE_FORMAT(`hire_date`,'%d/%m/%Y') from `employees`;

-- _______________________________________________________________________
-- Exercise queries

-- Show all employees who have managers with a salary higher than $15,000. Show the following data: employee name, manager name, manager salary, and salary grade of the manager salary



-- alias: 	em- table for manager data
-- 		ee- table for employee data

-- ______________________________ QUERY METHOD 1 

SELECT `ee`.`first_name` as 'employee', `em`.`first_name` as 'manager', `em`.`salary` as 'manager salary', `gr`.`grade_level` 
FROM `employees` `ee` 
INNER JOIN `employees` `em` ON `em`.`employee_id` = `ee`.`manager_id` AND `em`.`salary` >= 15000
INNER JOIN `grades` `gr` ON `em`.`salary`>=`gr`.`lowest_salary` AND `em`.`salary`<=`gr`.`highest_salary` -- using normal and condition
;

-- ______________________________ QUERY METHOD 2 

SELECT `ee`.`first_name` as 'employee', `em`.`first_name` as 'manager', `em`.`salary` as 'manager salary', `gr`.`grade_level` 
FROM `employees` `ee` 
INNER JOIN `employees` `em` ON `em`.`employee_id` = `ee`.`manager_id` AND `em`.`salary` >= 15000
INNER JOIN `grades` `gr` ON `em`.`salary` BETWEEN `gr`.`lowest_salary` AND `gr`.`highest_salary` -- using between operator 
;

-- _______________________________________________________________________

-- _______________________________________________________________________

-- Data Backup and recovery - IMPORT/EXPORT
-- _______________________________________________________________________

-- DATA EXPORT
-- mysqldump -u [uname] -p db_name > db_backup.sql

-- DATA IMPORT
-- mysql -u [uname] -p db_name < db_backup.sql

-- _______________________________________________________________________


-- TRANSACTIONS

-- __________________________________


-- Transaction - a complete unit... 
-- -> consistent sequences of tasks, once it is completed

-- 2 prerequisite:
-- -> 1. Database should already be consistent..
-- -> 2. List of tasks should be defined and completed within the transaction

-- ACID properties - property of a transaction:

-- Atomicity - a transaction is an atomic unit.. no sub task of a transaction can exist independently outside that transaction..  

-- Consistency - it ensures that database is consistent once the transaction is complete

-- Isolation - one transaction remains independent with respect to other transactions.. Hence there can be multiple transaction, but each transaction will still act as a isolated independent process.

-- Durability - the changes done by a transaction will persist in the database once the transaction is completed succesfully.


-- EXAMPLE - Ecommerce pay

-- Accnt X - ICICI
-- paytm - paytm
-- Accnt Amazon - axis

-- Super Transaction begins for amount 100:

-- Sub Transaction A - Payment Gateway
-- 0. Fetch X. -- rollback if error/exception
-- 1. X=X-100. -- rollback if error/exception
-- 1.1 set refcode -- rollback if error/exception
-- 2. Update X. -- rollback if error/exception
-- 3. Fetch paytm  -- rollback if error/exception
-- 4. paytm=paytm+100 -- rollback if error/exception
-- 4.1 save refcode -- rollback if error/exception
-- 5. Update paytm -- rollback if error/exception
-- 6. Acknowledge Amazon -- rollback if error/exception
-- 6.1. confirm refcode -- rollback if error/exception
-- 6.2 Confirm order to X -- rollback if error/exception
-- Commit Transaction A

-- Sub Transaction B - NEFT/RTGS/IMPS
-- 7. Fetch Paytm
-- 7.1 Paytm=paytm-100
-- 7.2 update paytm
-- 8. Fetch Amazon
-- 8.1 Amazon = Amazon+100
-- 8.2 Update Amazon
-- Commit Transaction B

-- Super Transaction Completes

CREATE TABLE `sal_report` (
  `id` int NOT NULL AUTO_INCREMENT,
  `summary` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

START TRANSACTION;
SELECT @A:=SUM(salary) FROM employees;
INSERT INTO `emp1`.`sal_report` (`summary`) VALUES (@A);
-- UPDATE sal_report SET summary=@A where id=1;
COMMIT;

-- Improper Reading Levels/Phenomena:
-- Dirty read - When data being read is not yet committed - inter transaction
-- Non repeatable read - When data being read reflect different value each time it is queried - inter transaction
-- Phantom read - When 2 same queries return different values each time. - inter and intra transaction


-- Isolation strategies
-- 4. READ UNCOMMITTED 
-- -> uncommitted of one transaction to be read by the other transaction. 
-- -> dirty read allowed.
-- 3. READ COMMITTED 
-- ->  only committed data of other transactions can be read by any particular transaction 
-- -> may use read or write lock on the data being read to prevent other transactions from accessing uncommitted data. 
-- 2. REPEATABLE READ 
-- -> Read lock : for rows it tries to only access for reading - this lock will not allow any other transaction to write
-- -> Write lock : for the rows it modifies (update or insert) - this lock will not allow any other transaction to read or write
-- 1. SERIALIZABLE
-- -> virtually sequenced transactions, hence only one transaction reads or writes at one particular time.

























