SELECT c.CustomerID, p.Name AS ProductName, sod.OrderQty, sod.LineTotal
     FROM SalesLT.Customer c
     JOIN SalesLT.SalesOrderHeader o ON c.CustomerID = o.CustomerID
     JOIN SalesLT.SalesOrderDetail sod ON o.SalesOrderID = sod.SalesOrderID
     JOIN SalesLT.Product p ON sod.ProductID = p.ProductID;