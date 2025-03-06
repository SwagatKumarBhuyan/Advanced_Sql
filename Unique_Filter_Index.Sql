

SELECT *
FROM Sales.Customers


-- Unique Index
CREATE UNIQUE NONCLUSTERED INDEX idx_CustomerDB_Product
ON Sales.Products(Product)
-- Check Unique Index working
INSERT INTO Sales.Products(ProductID,Product) VALUES(104,'FREEZ')


-- FILTER INDEX
CREATE  NONCLUSTERED INDEX idx_Customers_Country
ON Sales.Customers(Country)
WHERE Country = 'USA'