-- Generate a sequence of Numbers from 1 to 20
WITH Series AS
(
--Anchor Query
SELECT
1 AS MyNumber
UNION ALL
--Recursive Query
SELECT
MyNumber + 1
FROM Series
WHERE MyNumber < 20
)
--Main Query
SELECT *
FROM Series;


--Show the Employee heirarchy by displaying each employees level with in the organization
WITH CTE_Emp_Heirarchy AS
 (
	SELECT 
	EmployeeID,
	FirstName,
	ManagerID,
	1 AS Level
	FROM Sales.Employees
	WHERE ManagerID IS NULL
	UNION ALL
-- Recursive Query
   SELECT 
	e.EmployeeID,
	e.FirstName,
	e.ManagerID,
	Level + 1
	FROM Sales.Employees e
	INNER JOIN CTE_Emp_Heirarchy ceh
	ON e.ManagerID = ceh.EmployeeID
 )
 -- Main Query
 SELECT *
 FROM CTE_Emp_Heirarchy