SELECT 
OrderID,
OrderDate,
DATEADD(DAY,-10,OrderDate) New_OrderDate,
DATEADD(MONTH,3,OrderDate) New_OrderDate,
DATEADD(YEAR,3,OrderDate) New_OrderDate
FROM Sales.Orders


-- Calculate the age of Employee
SELECT 
EmployeeID,
BirthDate,
DATEDIFF(YEAR,BirthDate,GETDATE()) as Age
FROM Sales.Employees


-- find Average Shiping Duration in days for each Month
SELECT
DATENAME(MONTH,OrderDate) AS OrderDate,
AVG(DATEDIFF(DAY,OrderDate,ShipDate)) AS AvgDuration
FROM Sales.Orders
GROUP BY DATENAME(MONTH,OrderDate)


-- Time Gap Analysis
-- Find Number of days Between Each order and Previouis order
SELECT 
OrderID,
OrderDate as CurretOrderDate,
LAG(OrderDate) OVER(ORDER BY OrderDate) AS PreviosOrderDate,
DATEDIFF(DAY,LAG(OrderDate) OVER(ORDER BY OrderDate),OrderDate) AS Duration
FROM Sales.Orders


-- Data Validation
SELECT
ISDATE('123') CheckDate1,
ISDATE('2025-08-20') CheckDate2,
ISDATE('20-08-2025') CheckDate3,
ISDATE('2025') CheckDate4,
ISDATE('August') CheckDate5,
ISDATE('08') CheckDate6

SELECT
--CAST(OrderDate AS DATE),
OrderDate,
--ISDATE(OrderDate) AS NewDate,
CASE WHEN ISDATE(OrderDate) = 1 THEN CAST(OrderDate AS DATE)
END NewOrderDate
FROM(
SELECT '2025-08-22' AS OrderDate UNION
SELECT '2024-07-22' UNION
SELECT '2025-09'
    ) t