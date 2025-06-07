SELECT TOP 5 ProductID, SUM(LineTotal) AS TotalSales
     FROM SalesLT.SalesOrderDetail
     GROUP BY ProductID
     ORDER BY TotalSales DESC;