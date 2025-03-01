/*find the total sales for each product
  Additionally provide details such as Order ID and order date*/
select 
 ProductID,
 OrderID,
 sum(sales) over(Partition By ProductID) as Total_Sales
from sales.Orders;

/*
find the total sales across all product also
find the total sales for each product
  Additionally provide details such as Order ID and order date
  */
  select 
 ProductID,
 OrderID,
 sales,
 sum(sales) over() as Total_Sales,
 sum(sales) over(Partition By ProductID) as Total_Sales_byProductID
from sales.Orders;

/* Find the total sales for each combination of product and Product Status */
SELECT
   ProductID,
   OrderID,
   Sales,
   OrderStatus,
   SUM(Sales) OVER(PARTITION BY ProductID , OrderStatus) AS Total_Sales_By_Productstatus
FROM Sales.Orders

/* Find The rank Each Order based on Their sales From Highest To Lowest 
Additionally provide details such as Order ID and order date */

SELECT
   ProductID,
   OrderID,
   OrderDate,
   Sales,
   OrderStatus,
   RANK() OVER(ORDER BY Sales DESC) AS rnk
FROM Sales.Orders;

/* Rank Customer Based On their Total sales */
SELECT
   CustomerID,
   SUM(Sales) AS TOTAL_Sales,
   RANK() OVER(ORDER BY SUM(Sales) DESC) AS Rnk
FROM Sales.Orders
GROUP BY CustomerID;

/* Find Total Number of Orders Additionally provide OrderID and OrderDate */
SELECT
   CustomerID,
   OrderDate,
   OrderID,
   COUNT(*) OVER() TotalOrders
FROM Sales.Orders


/* Find Total Number of Orders  
    For Each Customer Additionally provide OrderID and OrderDate */
SELECT
   CustomerID,
   OrderDate,
   OrderID,
   COUNT(*) OVER() TotalOrders,
   COUNT(*) OVER(PARTITION BY CustomerID) TotalOrders
FROM Sales.Orders

/* Find Total Number of Customers  
   Find Total Number of Scores  
    Additionally provide all customer details */
	SELECT 
    *,
	Count(*) OVER() TotalCustomers,
	Count(Score) OVER() TotalCustomers
	FROM Sales.Customers;

/* Check Whether the Order Table contains any duplicates or not*/
SELECT *
FROM (
 SELECT
   OrderID,
   COUNT(*) OVER(PARTITION BY OrderID) CheckPk
FROM Sales.OrdersArchive
   ) t WHERE CheckPk > 1 ;

/* Find the Total Sales across all Product and The Total Sales For Each Product */
SELECT
    OrderDate,
    OrderID, 
	ProductID,
   Sales,
  SUM(Sales) OVER() TotalSales,
  SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesByProductId
FROM Sales.Orders

/* Find The Percentage Contribution of Each product to the Total Sales */
SELECT
     OrderID,
	 ProductID,
	 Sales,
	 SUM(Sales) OVER() TotalSales,
	 ROUND(CAST(Sales as float)/ SUM(Sales) OVER() * 100 ,2) PercentageOfTotal
FROM Sales.Orders;

/*Find The Average sales across all product and for Each Product and
Additionally provide details OrderID and OrderDate*/
SELECT
     OrderID,
	 OrderDate,
	 ProductID,
	 Sales,
	 AVG(Sales) OVER() Avg_Total_Sales ,
	  AVG(Sales) OVER(PARTITION BY ProductID ) Avg_Sales_ByProduct 
FROM Sales.Orders;

/*Find The Average Scores of Customers */
SELECT *,
COALESCE(Score,0) AS CoalScore,
AVG(Score) OVER() AS Avg_score ,
AVG(COALESCE(Score,0)) OVER() AS Avg_score_WithoutNull 
FROM Sales.Customers;

/*Find all Orders Where sales are higher than the average sales across all orders*/
SELECT *
FROM(
SELECT
     OrderID,
	 OrderDate,
	 ProductID,
	 Sales,
	 AVG(Sales) OVER() Avg_Total_Sales
FROM Sales.Orders) t
WHERE Sales > Avg_Total_Sales;

/*Calculate The Deviation of Each Sales from Both Minimum and Maximum Sales*/
SELECT 
     OrderID,
	 OrderDate,
	 ProductID,
	 Sales,
	 MAX(Sales) OVER() HighestSalary,
	 MIN(Sales) OVER() LowestSalary,
	 Sales-MIN(Sales) OVER() Mindeviation,
	 MAX(Sales)OVER() - Sales MaxDeviation
FROM Sales.Orders;

