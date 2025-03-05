-- step 1
--Find the total sales per Each Customer
WITH CTESales AS
  (
SELECT 
CustomerID,
Sum(Sales) AS TotalSales
FROM Sales.Orders
GROUP BY CustomerID
  )

--step2
-- Find the last oredr date per each customer
,CTE_Last_Order AS
  (
	SELECT 
	CustomerID,
	MAX(OrderDate) AS LastOrderDate
	FROM Sales.Orders
	GROUP BY CustomerID
  )

--Main query
SELECT
c.CustomerID,
c.FirstName,
c.LastName,
ctc.TotalSales,
cl.LastOrderDate
FROM Sales.Customers c
LEFT JOIN CTESales ctc
ON ctc.CustomerID = c.CustomerID
LEFT JOIN CTE_Last_Order cl
ON cl.CustomerID = c.CustomerID