
---- 1.Clustered Index
--SELECT
--*
--INTO Sales.CustomerDB
--FROM Sales.Customers

--SELECT
--*
--FROM Sales.CustomerDB
--WHERE CustomerID = '1'

----Clustered Index Create
--CREATE CLUSTERED INDEX idx_CustomerDB_CustomerID
--ON Sales.CustomerDB(CustomerID)


-- 1.NON-Clustered Index
SELECT
*
INTO Sales.CustomerDB
FROM Sales.Customers

--fOR Searching data
SELECT
*
FROM Sales.CustomerDB
WHERE FirstName = 'jossef'

--Non-Clustered Index Create
CREATE NONCLUSTERED INDEX idx_CustomerDB_FirstName
ON Sales.CustomerDB(FirstName);

DROP  INDEX idx_DBCustomer_FirstName
ON Sales.DBCustomer

-- COMPOSITE INDEX
SELECT
*
FROM Sales.CustomerDB
WHERE Country = 'USA' AND Score > 500

-- Create Composite Index
CREATE INDEX idx_CustomerDB_CountryScore
ON Sales.CustomerDB(Country,Score);