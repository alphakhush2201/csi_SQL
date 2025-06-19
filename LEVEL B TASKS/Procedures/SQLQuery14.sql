-- Stored Procedure 3: GetOrderDetails
CREATE PROCEDURE GetOrderDetails
    @OrderID INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (
        SELECT 1 FROM Sales.SalesOrderDetail WHERE SalesOrderID = @OrderID
    )
    BEGIN
        PRINT 'The OrderID ' + CAST(@OrderID AS VARCHAR(10)) + ' does not exist.';
        RETURN 1;
    END
    SELECT * 
    FROM Sales.SalesOrderDetail
    WHERE SalesOrderID = @OrderID;
END;