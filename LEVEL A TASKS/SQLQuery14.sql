SELECT ProductID, SUM(OrderQty) AS TotalQuantity
     FROM SalesLT.SalesOrderDetail
     GROUP BY ProductID;