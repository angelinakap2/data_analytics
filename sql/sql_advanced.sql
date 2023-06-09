/* CTEs - common table expression, a named temporary result set which is used to manipulate the complex subqueries data */
/* only exists within the scope of the statement we are about to write */
/* once out of the query - it's like it never existed */
/* created in memory */

/* heavy lifting is done in CTE for us, and query off of what we want - creates CTE over and over */
--WITH CTE_Employee as
--(SELECT FirstName, LastName, Gender, Salary
--, COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender
--, AVG(Salary) OVER (PARTITION BY Gender) as AvgSalary
--FROM SQL_Tutorial..EmployeeDemographics emp
--JOIN SQL_Tutorial..EmployeeSalary sal
--	ON emp.EmployeeID = sal.EmployeeID
--WHERE Salary > '45000'
--)
--Select FirstName, AvgSalary
--FROM CTE_Employee

/* have to put select statement right after CTE */

---------------------------------------------------------------------------------------------

/* Temp Tables */

--CREATE TABLE #temp_Employee (
--EmployeeID int,
--JobTitle varchar(100),
--Salary int
--)

--SELECT *
--FROM #temp_Employee

--INSERT INTO #temp_Employee VALUES (
--'1001', 'HR', '45000'
--)

/* taking all data from EmployeeSalary table and inserting it into the temp table */
--INSERT INTO #temp_Employee
--SELECT *
--FROM SQL_Tutorial..EmployeeSalary

/* let's say the EmployeeSalary table had a lot of rows - use subsection of table in temp table for convenience */

/* tip: delete table if can't find and want to create it again */
--DROP TABLE IF EXISTS #Temp_Employee2

--CREATE TABLE #Temp_Employee2 (
--JobTitle varchar(50),
--EmployeesPerJob int,
--AvgAge int,
--AvgSalary int)

--/* inserts certain subquery into Temp Table */
--INSERT INTO #Temp_Employee2
--SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(Salary)
--FROM SQL_Tutorial..EmployeeDemographics emp
--JOIN SQL_Tutorial..EmployeeSalary sal
--	ON emp.EmployeeID = sal.EmployeeID
--GROUP BY JobTitle

--SELECT *
--FROM #Temp_Employee2

---------------------------------------------------------------------------------------

/* String Functions - TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower */

--Drop Table Employee Errors;

--CREATE TABLE EmployeeErrors (
--EmployeeID varchar(50),
--FirstName varchar(50),
--LastName varchar(50)
--)

/* errors in table */
--INSERT INTO EmployeeErrors VALUES
--('1001', 'Jimbo', 'Halbert'),
--('  1002', 'Pamela', 'Beasley'),
--('1005', 'TOby', 'Flenderson - Fired')

--SELECT *
--FROM EmployeeErrors


-- Using Trim, LTRIM, RTRIM


/* TRIM gets rid of blank spaces on either the right or left side */
--SELECT EmployeeID, TRIM(EmployeeID) as IDTRIM
--FROM EmployeeErrors

/* LTRIM gets rid of left blank space */
--SELECT EmployeeID, LTRIM(EmployeeID) as IDTRIM
--FROM EmployeeErrors

/* RTRIM gets rid of right black space */
--SELECT EmployeeID, RTRIM(EmployeeID) as IDTRIM
--FROM EmployeeErrors

-- Using Replace: REPLACE(column to replace, what to replace, replaced with this)
--SELECT LastName, REPLACE(LastName, '- Fired', '') as LastNameFixed
--FROM EmployeeErrors


-- Using Substring: specify place you want to start and how many characters
--SELECT SUBSTRING(FirstName,1,3) /*starts at first letter/number, forward three spaces (three total) */
--FROM EmployeeErrors

/* fuzzy matching - just took first three letters so names matched! */
--SELECT err.FirstName, SUBSTRING(err.FirstName, 1, 3), dem.FirstName, SUBSTRING(dem.FirstName, 1, 3)
--FROM EmployeeErrors err
--JOIN SQL_Tutorial..EmployeeDemographics dem
--	ON SUBSTRING(err.FirstName, 1, 3) = SUBSTRING(dem.FirstName, 1, 3)


-- Using UPPER and LOWER: takes all the characters in text and make them upper or lower */
--SELECT FirstName, UPPER(FirstName)
--From EmployeeErrors

-----------------------------------------------------------------------------------------------------------------

/* Stored Procedures - a group of SQL statements that have been created and stored in database */
/* can accept input paramaters */
/* a single stored procedure can be used over a network by several different users */
/* can all be using different input data */
/* reduces network traffic, increases performance */
/* modifying stored procedures would be shown to everyone else */


/* creates stored procedure called TEST */
--CREATE PROCEDURE TEST
--AS
--SELECT *
--FROM SQL_Tutorial..EmployeeDemographics

/* execute - returns select statement */
--EXEC TEST

/* creating stored procedure Temp_Employee */
/* modify it and insert input paramter */
--CREATE PROCEDURE Temp_Employee
--AS
--Create table #t_employee (
--JobTitle varchar(100),
--EmployeesPerJob int,
--AvgAge int,
--AvgSalary int
--)

--INSERT INTO #t_employee
--SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
--FROM EmployeeDemographics emp
--JOIN EmployeeSalary sal
--	ON emp.EmployeeID = sal.EmployeeID
--GROUP BY JobTitle

--SELECT *
--FROM #t_employee

--EXEC Temp_Employee @JobTitle = 'Salesman'


--------------------------------------------------------------------------------------------

/* Subqueries (In the Select, From, and Where Statement) */
/* a query within a query */
/* used to return data that will be used in the main query */


--Select *
--FROM EmployeeSalary

-- Subquery in Select

--SELECT EmployeeID, Salary, (Select AVG(Salary) From EmployeeSalary) as AllAvgSalary
--FROM EmployeeSalary

-- Using Partition By
--SELECT EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
--FROM EmployeeSalary

-- Why Group By doesn't work
/* not able to get correct all average salary */
--SELECT EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
--FROM EmployeeSalary
--GROUP BY EmployeeId, Salary
--Order By 1, 2


-- Subquery in From
--SELECT a.EmployeeID, AllAvgSalary
--FROM (SELECT EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
--	FROM EmployeeSalary) a

-- Subquery in Where
--Select EmployeeID, JobTitle, Salary
--From EmployeeSalary
--WHERE EmployeeID in (
--		Select EmployeeID
--		From EmployeeDemographics
--		Where Age > 30)