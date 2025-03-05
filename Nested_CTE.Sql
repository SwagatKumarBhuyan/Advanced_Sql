-- step 1
--Find the total sales per Each Customer
WITH CTE_Sales AS
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

-- Step 3
-- Rank The customer Based on Total Sales per Customer
 , CTE_Rank_Customer AS
   (
   SELECT
   CustomerID,
   TotalSales,
   RANK() OVER(ORDER BY TotalSales DESC) AS Rnk
   FROM CTE_Sales
   )

-- Step 4
-- Rank The customer Based on Total Sales per Customer
, CTE_Customer_Segment AS
  (
  SELECT
  CustomerID,
  CASE WHEN TotalSales > 100 THEN 'High'
       WHEN TotalSales > 50  THEN 'Medium'
	   ELSE 'Low'
  END AS CustomerSegments
  FROM CTE_Sales
  )

--Main query
SELECT
c.CustomerID,
c.FirstName,
c.LastName,
ctc.TotalSales,
cl.LastOrderDate,
crc.Rnk,
ccs.CustomerSegments
FROM Sales.Customers c
LEFT JOIN CTE_Sales ctc
ON ctc.CustomerID = c.CustomerID
LEFT JOIN CTE_Last_Order cl
ON cl.CustomerID = c.CustomerID
LEFT JOIN CTE_Rank_Customer crc
ON crc.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Segment ccs
ON ccs.CustomerID = c.CustomerID
