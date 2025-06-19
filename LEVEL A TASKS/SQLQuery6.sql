SELECT ProductID, COUNT(*) AS OrderCount
     FROM SalesLT.SalesOrderDetail
     GROUP BY ProductID
     HAVING COUNT(*) > 3;