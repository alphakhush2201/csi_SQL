-- Stored Procedure 1: InsertOrderDetails
DROP PROCEDURE IF EXISTS InsertOrderDetails;
GO
CREATE PROCEDURE InsertOrderDetails
    @OrderID INT,
    @ProductID INT,
    @UnitPrice MONEY = NULL,
    @Quantity INT,
    @Discount FLOAT = 0
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @Stock INT, @ReorderLevel INT
    IF @UnitPrice IS NULL
        SELECT @UnitPrice = ListPrice FROM Production.Product WHERE ProductID = @ProductID;
    SELECT @Stock = p.SafetyStockLevel, @ReorderLevel = p.ReorderPoint
    FROM Production.Product p
    WHERE p.ProductID = @ProductID;
    IF @Stock < @Quantity
    BEGIN
        PRINT 'Not enough product in stock. Aborting insert.';
        RETURN;
    END
    INSERT INTO Sales.SalesOrderDetail (
    SalesOrderID, 
    ProductID, 
    OrderQty, 
    UnitPrice, 
    SpecialOfferID
)
VALUES (
    @OrderID, 
    @ProductID, 
    @Quantity, 
    @UnitPrice, 
    1 -- SpecialOfferID = 1 (No Discount)
);
    IF @@ROWCOUNT = 0
    BEGIN
        PRINT 'Failed to place the order. Please try again.';
        RETURN;
    END
    UPDATE Production.Product
    SET SafetyStockLevel = SafetyStockLevel - @Quantity
    WHERE ProductID = @ProductID;
    IF @Stock - @Quantity < @ReorderLevel
        PRINT 'Warning: Stock is below Reorder Level';
END;