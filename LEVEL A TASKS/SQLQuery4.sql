SELECT c.CustomerID, COUNT(o.SalesOrderID) AS OrdersCount
     FROM SalesLT.Customer c
     JOIN SalesLT.SalesOrderHeader o ON c.CustomerID = o.CustomerID
     GROUP BY c.CustomerID
     HAVING COUNT(o.SalesOrderID) > 2;