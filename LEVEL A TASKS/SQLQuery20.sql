SELECT FORMAT(OrderDate, 'yyyy-MM') AS Month, SUM(TotalDue) AS TotalSales
     FROM SalesLT.SalesOrderHeader
     GROUP BY FORMAT(OrderDate, 'yyyy-MM')
     ORDER BY Month;
