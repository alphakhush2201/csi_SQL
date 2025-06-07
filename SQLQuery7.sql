SELECT c.CustomerID
     FROM SalesLT.Customer c
     LEFT JOIN SalesLT.SalesOrderHeader o ON c.CustomerID = o.CustomerID
     WHERE o.SalesOrderID IS NULL;