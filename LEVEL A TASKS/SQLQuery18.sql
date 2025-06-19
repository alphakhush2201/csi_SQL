SELECT TOP 5 CustomerID, SUM(TotalDue) AS TotalSpent
     FROM SalesLT.SalesOrderHeader
     GROUP BY CustomerID
     ORDER BY TotalSpent DESC;