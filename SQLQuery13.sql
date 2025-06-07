SELECT CustomerID, COUNT(*) AS TotalOrders
     FROM SalesLT.SalesOrderHeader
     GROUP BY CustomerID;