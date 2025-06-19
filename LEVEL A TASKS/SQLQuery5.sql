SELECT p.ProductID, p.Name
     FROM SalesLT.Product p
     LEFT JOIN SalesLT.SalesOrderDetail sod ON p.ProductID = sod.ProductID
     WHERE sod.ProductID IS NULL;