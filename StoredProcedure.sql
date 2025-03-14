--Create databse datawarehouse
use master;

CREATE DATABASE DataWarehouse;

Use SalesDB;

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;

--Stored Procedure
--Step 2
-- Write a query for US customers to find total number of customers and avg score
SELECT 
COUNT(*) TotalScore,
AVG(Score) AvgScore
FROM Sales.Customers
Where Country = 'USA'

--Step 2
--Turning the query into Store Procedure
CREATE PROCEDURE GetCustomerSummary  
AS
BEGIN
SELECT 
COUNT(*) TotalScore,
AVG(Score) AvgScore
FROM Sales.Customers
Where Country = 'USA'
END

-- Execute the stored procedure
EXEC GetCustomerSummary 


--STEP 4
--Update procedure using parameter

ALTER PROCEDURE GetCustomerSummary  @Country NVARCHAR(50) 
AS
BEGIN
SELECT 
COUNT(*) TotalScore,
AVG(Score) AvgScore
FROM Sales.Customers
Where Country = @Country
END

-- Execute the stored procedure
EXEC GetCustomerSummary @Country = 'USA'
EXEC GetCustomerSummary @Country = 'Germany'

--Using Multiple statement in single stored procedure
ALTER PROCEDURE GetCustomerSummary  @Country NVARCHAR(50) 
AS
BEGIN
SELECT 
COUNT(*) TotalScore,
AVG(Score) AvgScore
FROM Sales.Customers
Where Country = @Country;
-- Find total number of orders and Total Sales
SELECT
COUNT(OrderID) AS TotalOrders,
sum(Sales) as TotalSales
FROM Sales.Orders o
JOIN  Sales.Customers c
on c.CustomerID = o.CustomerID
WHERE Country = @Country
END

EXEC GetCustomerSummary @Country = 'USA'
