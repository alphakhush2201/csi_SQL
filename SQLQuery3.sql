SELECT TOP 10 CustomerID, COUNT(*) AS OrderCount
     FROM SalesLT.SalesOrderHeader
     GROUP BY CustomerID
     ORDER BY OrderCount DESC;