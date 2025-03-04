--Scalar Subquery
SELECT
AVG(Sales)
FROM Sales.Orders

--Row Subquery
SELECT
OrderID
FROM Sales.Orders

--Table Subquery
SELECT
OrderID,
OrderDate
FROM Sales.Orders


--Subquery in From Clause
-- Find the products that have a price higher than the average price of all products
SELECT *
FROM(
SELECT 
ProductID,
Price,
AVG(Price) OVER() AS AvgPrice
FROM Sales.Products
    ) t
WHERE AvgPrice < Price


-- Rank the customer based on their Total Amount of sales
SELECT 
  *,
 RANK() OVER(ORDER BY TotalSales DESC) AS RankOfCustomer
FROM (
		SELECT 
		CustomerID,
		SUM(Sales) AS TotalSales
		FROM Sales.Orders
		GROUP BY CustomerID
	) t


--Subquery In Select Clause
-- show the productIds, product Names , prices and total number of orders

    --Main Query
	SELECT
	ProductID,
	Product,
	Price,
	--Subquery
		(SELECT COUNT(*) FROM Sales.Orders) AS TotalOrders
	FROM Sales.Products


-- Subqueries In Join 
-- Show all customer details and find the total orders for each customer
SELECT 
c.*,
o.TotalOrders
FROM Sales.Customers c
LEFT JOIN
     (
		SELECT 
		CustomerID,
		COUNT(*) AS TotalOrders
		FROM Sales.Orders
		GROUP BY CustomerID
     ) o
ON c.CustomerID = o.CustomerID


-- Subquery In Where Clause Using Comparison operator
-- Find the products that have a price higher than the avg price of all products 
SELECT
*
FROM Sales.Products
WHERE Price > 
		( SELECT AVG(Price) FROM Sales.Products )
	 

--Using In operator in Subquery
-- show all the details of Orders made by customers in Germany
SELECT *
FROM Sales.Orders
WHERE CustomerID In (SELECT CustomerID FROM Sales.Customers WHERE COUNTRY = 'Germany' )

-- Subquery using any operator with Where clause
-- find all female Employees whose salary is greater than the any male employees
SELECT 
EmployeeID,
FirstName,
Salary
FROM Sales.Employees
WHERE Gender = 'F' AND Salary > ANY (SELECT Salary FROM Sales.Employees WHERE Gender = 'M');


-- find all female Employees whose salary is greater than the all male employees
SELECT 
EmployeeID,
FirstName,
Salary
FROM Sales.Employees
WHERE Gender = 'F' AND Salary > ALL (SELECT Salary FROM Sales.Employees WHERE Gender = 'M');

-- Using Correlated subquery
-- Show all customer details and find the total orders for each customer
SELECT 
*,
 (SELECT COUNT(*) FROM Sales.Orders o WHERE C.CustomerID = O.CustomerID) TotalOrders
FROM Sales.Customers c


-- Subqueries Using Exists Operator 
-- show the order details of customers in Germany
SELECT *
FROM Sales.Orders o
WHERE EXISTS (
                SELECT 1
				FROM Sales.Customers c
				WHERE Country = 'Germany'
				AND c.CustomerID = o.CustomerID
			 )

