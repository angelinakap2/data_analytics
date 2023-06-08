--/* employee demographics table */

--CREATE TABLE EmployeeDemographics
--(EmployeeID int,
--FirstName varchar(50),
--LastName varchar(50),
--Age int,
--Gender varchar(50)
--)

--CREATE TABLE EmployeeSalary
--(EmployeeID int,
--JobTitle varchar(50),
--Salary int)

/* insert data into our newly created tables */

--INSERT INTO EmployeeDemographics VALUES
--(1001, 'Jim', 'Halpert', 30, 'Male')

--/* more data */
--INSERT INTO EmployeeDemographics VALUES
--(1002, 'Pam', 'Beasley', 30, 'Female'),
--(1003, 'Dwight', 'Schrute', 29, 'Male'),
--(1004, 'Angela', 'Martin', 31, 'Female'),
--(1005, 'Toby', 'Flenderson', 32, 'Male'),
--(1006, 'Michael', 'Scott', 35, 'Male'),
--(1007, 'Meredith', 'Palmer', 32, 'Female'),
--(1008, 'Stanley', 'Hudson', 38, 'Male'),
--(1009, 'Kevin', 'Malone', 31, 'Male')


--Insert Into EmployeeSalary VALUES
--(1001, 'Salesman', 45000),
--(1002, 'Receptionist', 36000),
--(1003, 'Salesman', 63000),
--(1004, 'Accountant', 47000),
--(1005, 'HR', 50000),
--(1006, 'Regional Manager', 65000),
--(1007, 'Supplier Relations', 41000),
--(1008, 'Salesman', 48000),
--(1009, 'Accountant', 42000)

--------------------------------------------------
/*
Select Statement
*, Top, Distinct, Count, As, Max, Min, Avg
*/


/* select all data from table */
--SELECT *
--FROM EmployeeDemographics

/* select first & last name */
--SELECT FirstName, LastName
--FROM EmployeeDemographics

/* select top five of everything */
--SELECT TOP 5 *
--FROM EmployeeDemographics


/* DISTINCT feature: want the unique values in a specific column */
--SELECT DISTINCT(EmployeeID)
--FROM EmployeeDemographics
/* gives UNIQUE VALUE - only one appearance */

/* male or female */
--SELECT DISTINCT(Gender)
--FROM EmployeeDemographics

/* gives amount of rows with last name (not unique) */
--SELECT COUNT(LastName)
--FROM EmployeeDemographics

/* gives column a name */
--SELECT COUNT (LastName) AS LastNameCount
--FROM EmployeeDemographics

/* job with most money */
--SELECT MAX(Salary)
--FROM EmployeeSalary

/* job with least money */
--SELECT MIN(Salary)
--FROM EmployeeSalary

/* average salary */
--SELECT AVG(Salary)
--FROM EmployeeSalary

/* tapping into the "SQL_Tutorial" database from the "master" database */
--SELECT *
--FROM SQL_Tutorial.dbo.EmployeeSalary


-----------------------------------------------

/*
Where Statement
=, <>, <, >, And, Or, Like, Null, Not Null, In
*/

/* all rows with FirstName 'Jim' */
--SELECT *
--FROM EmployeeDemographics
--WHERE FirstName = 'Jim'

/* all rows without FirstName 'Jim' */
--SELECT *
--FROM EmployeeDemographics
--WHERE FirstName <> 'Jim'

/* everyone equal to or over the age of 32 and Male */
--SELECT *
--FROM EmployeeDemographics
--WHERE Age <= 32 AND Gender = 'Male'

/* every LastName that starts with 'S', wildcard (%) after 'S' means 'S' at the start */
--SELECT *
--FROM EmployeeDemographics
--WHERE LastName LIKE 'S%'

/* every LastName that starts with 'S', and also has an 'o' anywhere in it */
--SELECT *
--FROM EmployeeDemographics
--WHERE LastName LIKE 'S%o%'

/* everythig will show because nothing is null */
--SELECT *
--FROM EmployeeDemographics
--WHERE FirstName is NOT NULL

/* IN command helps to use equal for multiple things */
--SELECT *
--FROM EmployeeDemographics
--WHERE FirstName IN ('Jim', 'Michael')

/*
Group By, Order By
*/

/* do not have to include COUNT(GENDER) in GROUP BY */
/* AGE and GENDER are actual columns in the table, and have to be in GROUP BY */
--SELECT Gender, Age, COUNT(Gender)
--FROM EmployeeDemographics
--WHERE Age > 31
--GROUP BY Gender, Age


/* with ORDER BY */
--SELECT Gender, COUNT(Gender) AS CountGender
--FROM EmployeeDemographics
--WHERE Age > 31
--GROUP BY Gender
--ORDER BY Gender /* naturally ascends; can use ASC or DESC */

/* entire table sorted as oldest to youngest */
--SELECT *
--FROM EmployeeDemographics
--ORDER BY Age DESC

/* entire table sorted as age first, and then by gender (Female first, then Male)*/
--SELECT *
--FROM EmployeeDemographics
--ORDER BY Age, Gender

/* using column number instead of column name */
--SELECT *
--FROM EmployeeDemographics
--ORDER BY 4 Desc, 5 Desc