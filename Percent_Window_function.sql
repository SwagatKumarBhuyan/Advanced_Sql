/* Find The Products That fall within the highest 40% of the prices  */
SELECT *,
CONCAT(DistRank * 100 ,'%') AS PercentDistRank
FROM (
SELECT 
 Product,
 Price,
 CUME_DIST() OVER(ORDER BY Price) AS DistRank
FROM Sales.Products
     ) AS t WHERE DistRank <= 0.4;


 SELECT *,
CONCAT(PercentRank * 100 ,'%') AS PercentDistRank
FROM (
SELECT 
 Product,
 Price,
 PERCENT_RANK() OVER(ORDER BY Price) AS PercentRank
FROM Sales.Products
     ) AS t WHERE PercentRank <= 0.40


	 PERCENT_RANK() OVER(ORDER BY Price) AS PercentRank