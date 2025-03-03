--Find Average Score of Customer
SELECT 
CustomerID,
Score,
COALESCE(Score,0) Score2,
AVG(COALESCE(Score,0)) OVER() AS AvgScore
FROM Sales.Customers


/*Display Full Name of customer in a single field by merging their first and last name
  and add 10 bonus point to each customers score */
  SELECT
  FirstName,
  LastName,
  FirstName + ' ' + COALESCE(LastName,'') As FullName,
  Score,
  COALESCE(Score,0) + 10 As ScoreAfterBonus
  FROM Sales.Customers


--Sort Customers from Lowest to Highest Score with appearing NULL at Last
SELECT 
CustomerID,
Score
FROM Sales.Customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END , Score


--Find The Sales Price for Each Order by dividing the sales by the Quantity
SELECT 
OrderID,
Sales,
Quantity,
Sales / NULLIF(Quantity , 0) AS SalesPrice
FROM Sales.Orders


--Identify the customers who have no scores
SELECT *
FROM Sales.Customers
WHERE Score IS NULL


--Identify the customers who have  scores
SELECT *
FROM Sales.Customers
WHERE Score IS NOT NULL


--List All details of customers who have not placed any orders
SELECT 
c.*,
o.OrderID
FROM Sales.Customers c
LEFT JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL
