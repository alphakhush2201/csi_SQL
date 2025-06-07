SELECT ProductID, SUM(LineTotal) AS TotalSalesAmount
     FROM SalesLT.SalesOrderDetail
     GROUP BY ProductID;