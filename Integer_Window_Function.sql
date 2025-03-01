/* Ranked The Orders Based On their Sales From Highest To Lowest*/
SELECT 
    OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) AS Rank_Row,
	RANK() OVER(ORDER BY Sales DESC) AS Rank_Rank,
	DENSE_RANK() OVER(ORDER BY Sales DESC) AS Rank_DenseRank
FROM Sales.Orders;

/* Find The Top Highest Sales For Each Product */
SELECT *
FROM
   (
SELECT 
    OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) AS Rank_Row
FROM Sales.Orders
    ) AS RN WHERE Rank_Row = 1;

/*Find The Lowest two Customers Based On their Total Sales*/
SELECT *
FROM
  (
SELECT 
    CustomerID
	Sales,
	SUM(Sales) AS TotalSales,
	ROW_NUMBER() OVER( ORDER BY SUM(Sales)) AS LowestRank
FROM Sales.Orders
GROUP BY CustomerID
   ) AS t WHERE LowestRank < 3;

/* Assign Unique IDs to the row of the 'OrdersArchieve' table */
SELECT 
ROW_NUMBER() OVER(ORDER BY OrderID,OrderDate) AS UniqueID,
*
FROM Sales.OrdersArchive


/* Identify Duplicate Rows in the OrdersArchieve table and return a clean result without any duplicate */
SELECT * FROM
(
SELECT 
ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) AS RN,
*
FROM Sales.OrdersArchive
) AS t WHERE RN = 1;


/* Segment All Orders Into 3categories : Higher , Medium , Lower */
SELECT *,
CASE WHEN Categories = 1 THEN 'High'
     WHEN Categories = 2 THEN 'Medium'
	 WHEN Categories = 3 THEN 'Low'
END AS SalesByCategory
FROM (
SELECT 
    OrderID,
	Sales,
    NTILE(3) OVER(ORDER BY Sales DESC) AS Categories
FROM Sales.Orders
    ) AS t


/* In Order to Export The Data , Divide The Order Into Two Groups */
SELECT 
    *,
    NTILE(2) OVER(ORDER BY OrderID) AS Buckets
FROM Sales.Orders