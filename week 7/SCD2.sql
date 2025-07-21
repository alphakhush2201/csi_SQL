CREATE PROCEDURE UpdateCustomer_SCD2
AS
BEGIN
    DECLARE @Today DATE = GETDATE();

    UPDATE d
    SET EndDate = @Today, CurrentFlag = 0
    FROM DimCustomer d
    JOIN StgCustomer s ON s.CustomerID = d.CustomerID
    WHERE d.CurrentFlag = 1 AND (
        d.CustomerName <> s.CustomerName OR
        d.Address <> s.Address OR
        d.City <> s.City
    );

    INSERT INTO DimCustomer (CustomerID, CustomerName, Address, City, CurrentFlag, StartDate, EndDate)
    SELECT 
        s.CustomerID, s.CustomerName, s.Address, s.City, 1, @Today, NULL
    FROM StgCustomer s
    LEFT JOIN DimCustomer d
        ON s.CustomerID = d.CustomerID AND d.CurrentFlag = 1
    WHERE d.CustomerID IS NULL OR (
        d.CustomerName <> s.CustomerName OR
        d.Address <> s.Address OR
        d.City <> s.City
    );
END;