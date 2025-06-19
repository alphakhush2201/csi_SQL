-- Stored Procedure 4: DeleteOrderDetails
CREATE PROCEDURE DeleteOrderDetails
    @OrderID INT,
    @ProductID INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (
        SELECT 1 FROM Sales.SalesOrderDetail 
        WHERE SalesOrderID = @OrderID AND ProductID = @ProductID
    )
    BEGIN
        PRINT 'Invalid OrderID or ProductID for the order.';
        RETURN -1;
    END
    DELETE FROM Sales.SalesOrderDetail
    WHERE SalesOrderID = @OrderID AND ProductID = @ProductID;
END;