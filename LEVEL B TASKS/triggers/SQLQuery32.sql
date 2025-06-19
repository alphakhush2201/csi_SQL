INSERT INTO Sales.SalesOrderDetail (
    SalesOrderID,
    ProductID,
    OrderQty,
    UnitPrice,
    SpecialOfferID
)
VALUES (
    43659,   -- Use an existing SalesOrderID from SalesOrderHeader
    707,     -- ProductID with only 4 units
    10,      -- Too much quantity ? should trigger trigger
    100.00,
    1
);
