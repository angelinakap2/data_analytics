/*
Inner Joins, Full/Left/Right/ Outer Joins
*/

--Select *
--FROM SQL_Tutorial.dbo.EmployeeDemographics

--Select *
--From SQL_Tutorial.dbo.EmployeeSalary


/* Inner Join combines both tables, with EmployeeID in common - only displays what they both have (AND) */
--SELECT *
--FROM SQL_Tutorial.dbo.EmployeeDemographics
--Inner Join SQL_Tutorial.dbo.EmployeeSalary
--	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


/* everything from the left table, and everything overlapping - but if only in the right table, we DO NOT want it */
/* left table is FROM '____' */
--SELECT *
--FROM SQL_Tutorial.dbo.EmployeeDemographics
--Left Outer Join SQL_Tutorial.dbo.EmployeeSalary
--	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


/* Full Outer join is going to show everything from Table A and Table B, regardless of if it has a match based on what they are being joined with */
--SELECT * 
--FROM SQL_Tutorial.dbo.EmployeeDemographics
--Full Outer Join SQL_Tutorial.dbo.EmployeeSalary
--	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID 

/* this will only show columns specified... have to specify a certain table if two tables have a column in common */
--SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary
--FROM SQL_Tutorial.dbo.EmployeeDemographics
--Left Outer Join SQL_Tutorial.dbo.EmployeeSalary
--	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

/* let's say we want to find employee with the highest salary, one that is not Michael Scott */
--SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, Salary
--FROM SQL_Tutorial.dbo.EmployeeDemographics
--Inner Join SQL_Tutorial.dbo.EmployeeSalary
--	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--WHERE FirstName <> 'Michael'
--ORDER BY Salary DESC

/* calculate average salary for the salesmen */
--SELECT JobTitle, AVG(Salary) as AvgSalesmenSalary
--FROM SQL_Tutorial.dbo.EmployeeDemographics
--Inner Join SQL_Tutorial.dbo.EmployeeSalary
--	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--WHERE JobTitle = 'Salesman'
--GROUP BY JobTitle

------------------------------------------------------------------------------

/*
Union, Union ALL
*/

/* with union, able to select all the data from both tables and put them into one output where all the data isn't in each column */


/* this combines the table with the same columns together as one */
--SELECT *
--FROM SQL_Tutorial.dbo.EmployeeDemographics
--UNION
--SELECT *
--FROM SQL_Tutorial.dbo.WarehouseEmployeeDemographics
--ORDER BY EmployeeID


--SELECT *
--FROM SQL_Tutorial.dbo.EmployeeDemographics
--Full Outer Join SQL_Tutorial.dbo.WareHouseEmployeeDemographics
--	ON EmployeeDemographics.EmployeeID = WareHouseEmployeeDemographics.EmployeeID

/* this is not what you want to do because the columns are not the same - they just have the same amount of columns */
--SELECT EmployeeID, FirstName, Age
--FROM SQL_Tutorial.dbo.EmployeeDemographics
--UNION
--SELECT EmployeeID, JobTitle, Salary 
--FROM SQL_Tutorial.dbo.EmployeeSalary
--ORDER BY EmployeeID

--------------------------------------------------------------------------------------------

/*
Case Statement
*/

/* creates new column with case outputs */
--SELECT FirstName, LastName, Age,
--CASE
--	WHEN Age > 30 THEN 'Old'
--	WHEN Age BETWEEN 27 AND 30 THEN 'Young'
--	ELSE 'Baby'
--END AS OldOrYoung
--FROM SQL_Tutorial.dbo.EmployeeDemographics
--WHERE Age is NOT NULL
--ORDER BY Age


/* calculating salary after a raise */

--SELECT FirstName, LastName, JobTitle, Salary,
--CASE
--	WHEN JobTitle = 'Salesman' THEN Salary + (Salary * 0.10)
--	WHEN JobTitle = 'Accountant' THEN Salary + (Salary * 0.05)
--	WHEN JobTitle = 'HR' THEN Salary + (Salary * 0.000001)
--	ELSE Salary + (Salary * 0.03)
--END as SalaryAfterRaise
--FROM SQL_Tutorial.dbo.EmployeeDemographics
--JOIN SQL_Tutorial.dbo.EmployeeSalary
--	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


-----------------------------------------------------------------------------

/*
Having Clause
*/

--SELECT JobTitle, COUNT(JobTitle)
--FROM SQL_Tutorial.dbo.EmployeeDemographics
--JOIN SQL_Tutorial.dbo.EmployeeSalary
--	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--GROUP BY JobTitle
--HAVING COUNT(JobTitle) > 1 /* HAVING statement is dependent on GROUP BY statement */

/* finding average job salaries, greater than 45000, ascending order */
--SELECT JobTitle, AVG(Salary)
--FROM SQL_Tutorial.dbo.EmployeeDemographics
--JOIN SQL_Tutorial.dbo.EmployeeSalary
--	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--GROUP BY JobTitle
--HAVING AVG(Salary) > 45000
--ORDER BY AVG(Salary)


/* Updating/Deleting Data */

/* insert into creates a new row into table, updating alters preexisting row, deleting removes a row */
/* SET specifies what column and what value to insert into it */

/* updating 'Holly Flax' EmployeeID */
--SELECT *
--FROM SQL_Tutorial.dbo.EmployeeDemographics
--UPDATE SQL_Tutorial.dbo.EmployeeDemographics
--SET EmployeeID = 1012
--WHERE FirstName = 'Holly' AND LastName = 'Flax'

--SELECT *
--FROM SQL_Tutorial.dbo.EmployeeDemographics
--UPDATE SQL_Tutorial.dbo.EmployeeDemographics
--SET Age = 32, Gender = 'Female'
--WHERE FirstName = 'Holly' AND LastName = 'Flax'


/* deleting a row */
--DELETE FROM SQL_Tutorial.dbo.EmployeeDemographics
--WHERE EmployeeID = 1005

/* safe practice to check where you will be deleting first */
--SELECT *
--FROM SQL_Tutorial.dbo.EmployeeDemographics
--WHERE EmployeeID = 1004


/* Aliasing: temporarily changing column name - helps readability of script */

/* specifies first and last name are combined */
--SELECT FirstName + ' ' + LastName as FullName /* or alias */
--FROM SQL_Tutorial.dbo.EmployeeDemographics

/* aliasing a table name will need to be prefaced in the column name with the alias */
--SELECT Demo.EmployeeID, Sal.Salary
--FROM SQL_Tutorial.dbo.EmployeeDemographics as Demo
--JOIN SQL_Tutorial.dbo.EmployeeSalary as Sal
--	ON Demo.EmployeeID = Sal.EmployeeID


/* do not want to do this in aliasing - use more specific aliases */
--SELECT a.EmployeeID, a.FirstName, a.FirstName, b.JobTitle, c.Age
--FROM SQL_Tutorial.dbo.EmployeeDemographics a
--LEFT JOIN SQL_Tutorial.dbo.EmployeeSalary b
--	ON a.EmployeeID = b.EmployeeID
--LEFT JOIN SQL_Tutorial.dbo.WareHouseEmployeeDemographics c
--	ON a.EmployeeID = c.EmployeeID


/* good alias practice */
--SELECT Demo.EmployeeID, Demo.FirstName, Demo.FirstName, Sal.JobTitle, Ware.Age
--FROM SQL_Tutorial.dbo.EmployeeDemographics Demo
--LEFT JOIN SQL_Tutorial.dbo.EmployeeSalary Sal
--	ON Demo.EmployeeID = Sal.EmployeeID
--LEFT JOIN SQL_Tutorial.dbo.WareHouseEmployeeDemographics Ware
--	ON Demo.EmployeeID = Ware.EmployeeID


/* Partition By - Group By reduces the number of rows in output by rolling them up and calculating sums/avgs/each group */
/* Partition By divides the result set into partitions and changes how the window function is calculated - doesn't reduce the number of rows in output */


--SELECT FirstName, LastName, Gender, Salary,
--COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender /* able to isolate one column */
--FROM SQL_Tutorial..EmployeeDemographics dem
--JOIN SQL_Tutorial..EmployeeSalary sal
--	ON dem.EmployeeID = sal.EmployeeID

/* with GROUP BY, we cannot have the same results unless we remove display of First, LastName, and Salary */
SELECT  Gender, COUNT(Gender)
FROM SQL_Tutorial..EmployeeDemographics dem
JOIN SQL_Tutorial..EmployeeSalary sal
	ON dem.EmployeeID = sal.EmployeeID
GROUP BY Gender
