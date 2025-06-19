-- Trigger 1: Prevent delete if order details exist
CREATE TRIGGER trg_PreventOrderDelete
ON Sales.SalesOrderHeader
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1 
        FROM Sales.SalesOrderDetail od
        JOIN deleted d ON od.SalesOrderID = d.SalesOrderID
    )
    BEGIN
        PRINT 'Cannot delete order until corresponding details are deleted.';
        RETURN;
    END
    DELETE FROM Sales.SalesOrderHeader
    WHERE SalesOrderID IN (SELECT SalesOrderID FROM deleted);
END;
