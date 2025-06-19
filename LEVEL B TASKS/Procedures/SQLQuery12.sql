-- Stored Procedure 2: UpdateOrderDetails
CREATE PROCEDURE UpdateOrderDetails
    @OrderID INT,
    @ProductID INT,
    @UnitPrice MONEY = NULL,
    @Quantity INT = NULL,
    @Discount FLOAT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @OldQuantity INT, @Stock INT;
    SELECT @OldQuantity = OrderQty 
    FROM Sales.SalesOrderDetail
    WHERE SalesOrderID = @OrderID AND ProductID = @ProductID;
    IF @OldQuantity IS NULL
    BEGIN
        PRINT 'Order detail not found.';
        RETURN;
    END
    UPDATE Sales.SalesOrderDetail
    SET
        UnitPrice = ISNULL(@UnitPrice, UnitPrice),
        OrderQty = ISNULL(@Quantity, OrderQty),
        UnitPriceDiscount = ISNULL(@Discount, UnitPriceDiscount)
    WHERE SalesOrderID = @OrderID AND ProductID = @ProductID;
    IF @Quantity IS NOT NULL
    BEGIN
        SET @Stock = @OldQuantity - @Quantity;
        UPDATE Production.Product
        SET SafetyStockLevel = SafetyStockLevel + @Stock
        WHERE ProductID = @ProductID;
    END
    DECLARE @RemainingStock INT, @ReorderLevel INT
    SELECT @RemainingStock = SafetyStockLevel, @ReorderLevel = ReorderPoint
    FROM Production.Product
    WHERE ProductID = @ProductID;
    IF @RemainingStock < @ReorderLevel
        PRINT 'Stock below Reorder Level after update.';
END;
