
--Load data to temp table
SELECT
*
INTO #Orders
FROM Sales.Orders

SELECT
*
FROM Sales.Orders

-- Transform data in temp table
-- Delete data from temp tables
DELETE FROM #Orders
WHERE OrderStatus = 'Delivered'

SELECT
*
FROM #Orders

--Load Temp Table in Permate Table
SELECT
*
INTO Sales.OrderTest
FROM #Orders
