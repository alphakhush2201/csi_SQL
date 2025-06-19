CREATE VIEW vwCustomerOrders AS
SELECT 
    s.Name AS CompanyName,
    soh.SalesOrderID AS OrderID,
    soh.OrderDate,
    sod.ProductID,
    p.Name AS ProductName,
    sod.OrderQty AS Quantity,
    sod.UnitPrice,
    (sod.OrderQty * sod.UnitPrice) AS Total
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Sales.Customer cu ON soh.CustomerID = cu.CustomerID
JOIN Sales.Store s ON cu.StoreID = s.BusinessEntityID;
