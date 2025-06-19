SELECT c.CustomerID, o.SalesOrderID, o.OrderDate, o.TotalDue
     FROM SalesLT.Customer c
     JOIN SalesLT.SalesOrderHeader o ON c.CustomerID = o.CustomerID;