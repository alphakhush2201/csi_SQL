CREATE VIEW MyProducts AS
SELECT 
    p.ProductID,
    p.Name AS ProductName,
    ISNULL(p.Size, '') + ' ' + ISNULL(CAST(p.Weight AS VARCHAR(10)), '') AS QuantityPerUnit,
    p.ListPrice AS UnitPrice,
    v.Name AS CompanyName,
    pc.Name AS CategoryName
FROM Production.Product p
JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
JOIN Purchasing.ProductVendor pv ON p.ProductID = pv.ProductID
JOIN Purchasing.Vendor v ON pv.BusinessEntityID = v.BusinessEntityID
WHERE p.DiscontinuedDate IS NULL;
