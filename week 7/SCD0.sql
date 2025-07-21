CREATE PROCEDURE UpdateCustomer_SCD0
AS
BEGIN
    INSERT INTO DimCustomer (CustomerID, CustomerName, Address, City)
    SELECT s.CustomerID, s.CustomerName, s.Address, s.City
    FROM StgCustomer s
    WHERE NOT EXISTS (
        SELECT 1 FROM DimCustomer d WHERE d.CustomerID = s.CustomerID
    );
END;