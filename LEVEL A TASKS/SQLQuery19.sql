SELECT DISTINCT c.CustomerID
     FROM SalesLT.Customer c
     JOIN SalesLT.SalesOrderHeader o ON c.CustomerID = o.CustomerID
     JOIN SalesLT.SalesOrderDetail sod ON o.SalesOrderID = sod.SalesOrderID
     WHERE sod.ProductID = 707;