CREATE PROCEDURE UpdateCustomer_SCD6
AS
BEGIN
    DECLARE @Today DATE = GETDATE();

    UPDATE DimCustomer
    SET EndDate = @Today, CurrentFlag = 0
    WHERE CustomerID IN (
        SELECT d.CustomerID
        FROM DimCustomer d
        JOIN StgCustomer s ON s.CustomerID = d.CustomerID
        WHERE d.CurrentFlag = 1 AND (
            d.CustomerName <> s.CustomerName OR
            d.Address <> s.Address OR
            d.City <> s.City
        )
    );

    INSERT INTO DimCustomer (
        CustomerID, CustomerName, Address, City, PreviousAddress,
        CurrentFlag, StartDate, EndDate, Version
    )
    SELECT 
        s.CustomerID,
        s.CustomerName,
        s.Address,
        s.City,
        d.Address,
        1,
        @Today,
        NULL,
        ISNULL(d.Version, 1) + 1
    FROM StgCustomer s
    LEFT JOIN DimCustomer d ON s.CustomerID = d.CustomerID AND d.CurrentFlag = 1
    WHERE d.CustomerID IS NULL OR (
        d.CustomerName <> s.CustomerName OR
        d.Address <> s.Address OR
        d.City <> s.City
    );
END;