SELECT
    ISNULL(ProductCategory, 'Total') AS ProductCategory,
    CASE 
        WHEN ProductCategory IS NOT NULL AND ProductName IS NULL THEN 'Total'
        WHEN ProductCategory IS NULL AND ProductName IS NULL THEN 'Total'
        ELSE ProductName
    END AS ProductName,
    SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY ROLLUP(ProductCategory, ProductName)
ORDER BY
    GROUPING(ProductCategory),      
    ProductCategory,
    GROUPING(ProductName),         
    ProductName;
