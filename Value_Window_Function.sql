/* Analyse the month over month performance by finding the percentage change in sales 
   between the current and previous month */

   SELECT *,
   CurrentMonthSales - PreviousMonthSales As MOM_Change,
   ROUND(CAST((CurrentMonthSales - PreviousMonthSales) AS float) / PreviousMonthSales * 100,1) AS MOM_PER
   FROM(
   SELECT
   MONTH(OrderDate) OrderMonth,
   SUM(Sales) AS CurrentMonthSales,
   LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) AS PreviousMonthSales
   FROM Sales.Orders
   GROUP BY   MONTH(OrderDate)
      ) t


/*Analyze Customer Loyalty by Ranking Customers based On the Average number days between the orders*/
SELECT
    CustomerID,
	AVG(DaysUntilNextOrder) AvgDays,
	RANK() OVER(ORDER BY AVG(DaysUntilNextOrder)) AS RankAvg
FROM (
SELECT
   OrderId,
   CustomerID,
   OrderDate AS CurrentDate,
   LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS NextCurrentDate,
   DATEDIFF(DAY,OrderDate,LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate)) as DaysUntilNextOrder
FROM Sales.Orders
 ) t
 GROUP BY CustomerID


 /* Find the Lowest and Highest sales for each product*/
 SELECT
     OrderID,
	 ProductID,
	 Sales,
	 FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) as LowestValue,
	 LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales
	                   ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) as HighestValue
 FROM Sales.Orders