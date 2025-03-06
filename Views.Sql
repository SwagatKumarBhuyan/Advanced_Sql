--VIEWS USE CASES
-- 1. COMPLEX INTEGRATION

-- For CREATE AND EXECUTE VIEW

--Find the running total of  sales per each month
CREATE VIEW Sales.V_Monthly_Summary AS
        (
        SELECT
	DATETRUNC(MONTH,OrderDate) AS OrderMonth,
	SUM(Sales) AS TotalSales,
	COUNT(OrderID) AS TotalOrders,
	SUM(Quantity) AS TotalQuantities
	FROM Sales.Orders
	GROUP BY DATETRUNC(MONTH,OrderDate)
	)
--Main Query
SELECT
OrderMonth,
TotalSales,
SUM(TotalSales) OVER(ORDER BY OrderMonth) AS RunninTotal
FROM V_Monthly_Summary


-- FOR DROP VIEW
DROP VIEW Sales.V_Monthly_Summary

--FOR UPDATE VIEW

-- USING SQL SERVER
IF OBJECT_ID('Sales.V_Monthly_Summary' , 'V') IS NOT NULL
DROP VIEW Sales.V_Monthly_Summary
GO
CREATE VIEW Sales.M_Monthly_Summary AS
    (
    SELECT
	DATETRUNC(MONTH,OrderDate) AS OrderMonth,
	SUM(Sales) AS TotalSales,
	COUNT(OrderID) AS TotalOrders,
	SUM(Quantity) AS TotalQuantities
	FROM Sales.Orders
	GROUP BY DATETRUNC(MONTH,OrderDate)
	)

--Using Postgres Sql
CREATE OR REPLACE VIEW Sales.M_Monthly_Summary AS
    (
    SELECT
	DATETRUNC(MONTH,OrderDate) AS OrderMonth,
	SUM(Sales) AS TotalSales,
	COUNT(OrderID) AS TotalOrders,
	SUM(Quantity) AS TotalQuantities
	FROM Sales.Orders
	GROUP BY DATETRUNC(MONTH,OrderDate)
	)

-- 2. HIDE COMPLEXITY

--Provide a view that combines details from orders, products, customers and employees
CREATE VIEW Sales.V_Order_Details AS
    (
SELECT 
o.OrderID,
o.OrderDate,
p.Product,
p.Price,
COALESCE(c.FirstName,'') + '' + COALESCE(c.LastName,'') CustomerName,
c.Country CustomerCountry,
COALESCE(e.FirstName,'') + '' + COALESCE(e.LastName,'') EmployeeName,
e.Gender,
o.Sales,
o.Quantity
FROM Sales.Orders o
LEFT JOIN Sales.Products p
ON p.ProductID = o.ProductID
LEFT JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID
LEFT JOIN Sales.Employees e
ON e.EmployeeID = o.SalesPersonID
    )
--Main Query
SELECT
*
FROM Sales.V_Order_Details

-- 3.Data Security

 /* provide a view for the EU Sales team that combines
    details from all tables and exclude data related to the usa */
CREATE VIEW Sales.E_Details_EU AS
  (
SELECT 
o.OrderID,
o.OrderDate,
p.Product,
p.Price,
COALESCE(c.FirstName,'') + '' + COALESCE(c.LastName,'') CustomerName,
c.Country CustomerCountry,
COALESCE(e.FirstName,'') + '' + COALESCE(e.LastName,'') EmployeeName,
e.Gender,
o.Sales,
o.Quantity
FROM Sales.Orders o
LEFT JOIN Sales.Products p
ON p.ProductID = o.ProductID
LEFT JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID
LEFT JOIN Sales.Employees e
ON e.EmployeeID = o.SalesPersonID
WHERE c.Country != 'USA'
     )
--Main Query
SELECT
*
FROM Sales.E_Details_EU

-- 4.Flexibility and Dynamic
-- 5.Multilangegual
