--Generate a report Showing the total sales for Each Category
--     High: If the Sales is greater than 50
--     Medium: If the Sales is Between 20 and 50
--     Low: If the Sales is Less than 20
-- Sort the Result From lowest to Highest
SELECT
Category,
SUM(Sales) As TotalSales
FROM (
SELECT
OrderID,
Sales,
CASE 
    WHEN Sales > 50 THEN 'Higher'
	WHEN Sales > 20 THEN 'Medium'
	Else 'Low'
END AS Category
FROM Sales.Orders 
     )t
GROUP BY Category
ORDER BY TotalSales


-- Retrieve Employee Details with Gender Displayed As Full Text
SELECT 
EmployeeID,
FirstName,
LastName,
CASE WHEN Gender = 'F' THEN 'Female'
     WHEN Gender = 'M' THEN 'Male'
END AS FullGender
FROM Sales.Employees


-- Retrive Customer Details With Abbrebiate Country Code
SELECT
CustomerID,
FirstName,
LastName,
CASE    WHEN Country = 'USA' THEN 'U'
        WHEN Country = 'Germany' THEN 'G'
END AS CountryCode
FROM Sales.Customers

--OR
SELECT
CustomerID,
FirstName,
LastName,
CASE  Country
        WHEN 'USA' THEN 'U'
        WHEN 'Germany' THEN 'G'
END AS CountryCode
FROM Sales.Customers


-- Find Average Scores Of Customers Treats Nulls As Zero and provide details such as CustomerID , LastName
SELECT 
CustomerID,
LastName,
CASE WHEN Score IS NULL THEN 0
     ELSE Score
END AS ScoreClean,
AVG(CASE WHEN Score IS NULL THEN 0
     ELSE Score
    END ) OVER() AS AvgScoreClean
FROM Sales.Customers


-- Count How Many times Each Customer has made an Order With Sales Greater than 30
SELECT
	CustomerID,
	SUM(CASE 
	   WHEN Sales > 30 THEN 1
	    ELSE 0
		END  ) SalesCount
FROM Sales.Orders
GROUP BY CustomerID