/* Combine the data from employees and customer into one table */
SELECT 
FirstName,
LastName
FROM Sales.Customers
    UNION
SELECT 
FirstName,
LastName
FROM Sales.Employees


/* Combine the data from employees and customer into one table Iincluding Duplicates */
SELECT 
FirstName,
LastName
FROM Sales.Customers
    UNION All
SELECT 
FirstName,
LastName
FROM Sales.Employees


--Find Customers who are not Employee at the same time
SELECT 
FirstName,
LastName
FROM Sales.Customers
    Except
SELECT 
FirstName,
LastName
FROM Sales.Employees


--Find Employees who are Customer at the same time
SELECT 
FirstName,
LastName
FROM Sales.Employees
    INTERSECT
SELECT 
FirstName,
LastName
FROM Sales.Customers


--Orders Are Stored in Separate Tables (Orders and OrdersArchieve) Combine all orders into one report without duplicates
SELECT
'Orders' As SourceTable,
[OrderID]
,[ProductID]
,[CustomerID]
,[SalesPersonID]
,[OrderDate]
,[ShipDate]
,[OrderStatus]
,[ShipAddress]
,[BillAddress]
,[Quantity]
,[Sales]
,[CreationTime]
FROM Sales.Orders
  UNION
SELECT
'OrdersArchieve' As SourceTable,
[OrderID]
,[ProductID]
,[CustomerID]
,[SalesPersonID]
,[OrderDate]
,[ShipDate]
,[OrderStatus]
,[ShipAddress]
,[BillAddress]
,[Quantity]
,[Sales]
,[CreationTime]
FROM Sales.OrdersArchive