CREATE PROCEDURE UpdateCustomer_SCD4
AS
BEGIN
    DECLARE @Today DATE = GETDATE();

    INSERT INTO DimCustomerHistory (CustomerID, CustomerName, Address, City, ChangedDate)
    SELECT d.CustomerID, d.CustomerName, d.Address, d.City, @Today
    FROM DimCustomer d
    JOIN StgCustomer s ON s.CustomerID = d.CustomerID
    WHERE d.Address <> s.Address;

    UPDATE d
    SET d.CustomerName = s.CustomerName,
        d.Address = s.Address,
        d.City = s.City
    FROM DimCustomer d
    JOIN StgCustomer s ON s.CustomerID = d.CustomerID;

    INSERT INTO DimCustomer (CustomerID, CustomerName, Address, City)
    SELECT s.CustomerID, s.CustomerName, s.Address, s.City
    FROM StgCustomer s
    WHERE NOT EXISTS (
        SELECT 1 FROM DimCustomer d WHERE d.CustomerID = s.CustomerID
    );
END;