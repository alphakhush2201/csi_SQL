-- Trigger 2: Check stock before insert
CREATE TRIGGER trg_CheckStockBeforeInsert
ON Sales.SalesOrderDetail
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @ProductID INT, @Qty INT, @Stock INT;
    SELECT @ProductID = ProductID, @Qty = OrderQty FROM inserted;
    SELECT @Stock = SafetyStockLevel FROM Production.Product WHERE ProductID = @ProductID;
    IF @Qty > @Stock
    BEGIN
        RAISERROR('Insufficient stock. Order cannot be placed.', 16, 1);
        ROLLBACK;
        RETURN;
    END
    UPDATE Production.Product
    SET SafetyStockLevel = SafetyStockLevel - @Qty
    WHERE ProductID = @ProductID;
END;