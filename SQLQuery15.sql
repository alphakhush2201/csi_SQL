SELECT CustomerID, SUM(TotalDue) AS TotalSpent
     FROM SalesLT.SalesOrderHeader
     GROUP BY CustomerID;