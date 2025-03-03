SELECT
OrderID,
CreationTime,
--DateTrunk Example
DATETRUNC(YEAR,CreationTime) year_dt,
DATETRUNC(DAY,CreationTime) day_dt,
DATETRUNC(MINUTE,CreationTime) minute_dt,
--Datename Example
DATENAME(MONTH,CreationTime) Month_dn,
DATENAME(WEEKDAY,CreationTime) WeekDay_dn,
DATENAME(YEAR,CreationTime) Year_dn,
DATENAME(DAY,CreationTime) day_dn,
--Simple Extraction
YEAR(CreationTime) AS Year,
MONTH(CreationTime) AS Month,
DAY(CreationTime) AS Year,
--Datepart Example
DATEPART(Year,CreationTime) Year_Part,
DATEPART(MONTH,CreationTime) Month_Part,
DATEPART(DAY,CreationTime) Day_Part,
DATEPART(HOUR,CreationTime) Hour_Part,
DATEPART(QUARTER,CreationTime) Quarter_Part,
DATEPART(WEEK,CreationTime) Week_Part
FROM Sales.Orders



SELECT
DATETRUNC(MONTH,CreationTime) Month_Count,
COUNT(*)
FROM Sales.Orders
GROUP BY DATETRUNC(MONTH,CreationTime) 




SELECT
OrderID,
CreationTime,
EOMONTH(CreationTime) EndOfMonth,
CAST(DATETRUNC(MONTH,CreationTime) AS Date) StartOfMonth
FROM Sales.Orders


-- How many Orders Are Placed each year
SELECT 
YEAR(OrderDate) AS year_no,
COUNT(YEAR(OrderDate)) NoOfOrders
FROM Sales.Orders
GROUP BY YEAR(OrderDate)


-- How many Orders Are Placed each month
SELECT 
DATENAME(MONTH,OrderDate) AS month_name,
COUNT(DATENAME(MONTH,OrderDate)) NoOfOrders
FROM Sales.Orders
GROUP BY DATENAME(MONTH,OrderDate)


-- Show all orders that are placed during the month of February
SELECT 
*
FROM Sales.Orders
WHERE MONTH(OrderDate) = 2
