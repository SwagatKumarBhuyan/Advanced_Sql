-- CREATE AND EXECUTED CTA
-- USING SQL SERVER
SELECT 
DATENAME(MONTH,OrderDate) AS OrderMonth,
SUM(OrderID) AS TotalOrders
-- Using CTAS Create New Table And Executed
INTO Sales.MonthlyOrders
FROM Sales.Orders
GROUP BY DATENAME(MONTH,OrderDate)

SELECT *
FROM Sales.MonthlyOrders;

--DROP CTA
DROP TABLE Sales.MonthlyOrders 

--UPDATE CTA
IF OBJECT_ID('Sales.MonthlyOrders' , 'U') IS NOT NULL
  DROP TABLE Sales.MonthlyOrders
GO
   SELECT 
DATENAME(MONTH,OrderDate) AS OrderMonth,
SUM(OrderID) AS TotalOrders
-- Using CTAS Create New Table And Executed
INTO Sales.MonthlyOrders
FROM Sales.Orders
GROUP BY DATENAME(MONTH,OrderDate)