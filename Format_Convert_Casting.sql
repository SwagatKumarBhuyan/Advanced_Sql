SELECT
OrderID,
FORMAT(CreationTime,'MM-dd-yyyy') Usa_Format,
FORMAT(CreationTime,'dd-MM-yyyy') Europe_Format,
FORMAT(CreationTime,'yy') yy,
FORMAT(CreationTime,'yyy') yyy,
FORMAT(CreationTime,'MM') MM,
FORMAT(CreationTime,'MMM') MMM,
FORMAT(CreationTime,'MMMM') MMMM,
FORMAT(CreationTime,'dd') dd,
FORMAT(CreationTime,'ddd') ddd,
FORMAT(CreationTime,'dddd') dddd
FROM Sales.Orders


--Show Creation Time Using the Following Format
-- Day Wed Jan Q1 2025 12:34:56 PM
SELECT
OrderID,
CreationTime,
'Day ' + FORMAT(CreationTime,'dd MMM') +
' Q' + DATENAME(QUARTER,CreationTime) +
' ' + FORMAT(CreationTime,'yyyy hh:mm:ss tt') CustomFormat
FROM Sales.Orders

-- Use Cases
--Data Aggregiation
SELECT
FORMAT(OrderDate,'MMM yy') OrderDate,
COUNT(*) NoOrder
FROM Sales.Orders
GROUP BY FORMAT(OrderDate,'MMM yy')


-- Convert Function
SELECT
CONVERT(INT,'123') AS [String to Int conversion],
CONVERT(DATE,'2025-05-20') AS [String to Date conversion],
CreationTime,
CONVERT(DATE,CreationTime) AS [DateTime to Date conversion],
CONVERT(VARCHAR,CreationTime,32) AS [Usa Std. Style:32]
FROM Sales.Orders


-- Cast Function
SELECT
CAST('123' AS int) [String to int],
CAST('2025-05-20' AS DATE) [String to Date],
CAST('2025-05-20' AS datetime) [String to DateTime],
CreationTime,
CAST(CreationTime AS DATE) [DateTime to Date]
FROM Sales.Orders
