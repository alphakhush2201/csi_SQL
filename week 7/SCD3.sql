CREATE PROCEDURE UpdateCustomer_SCD3
AS
BEGIN
    MERGE DimCustomer AS TARGET
    USING StgCustomer AS SOURCE
    ON TARGET.CustomerID = SOURCE.CustomerID
    WHEN MATCHED AND TARGET.Address <> SOURCE.Address THEN
        UPDATE SET 
            TARGET.PreviousAddress = TARGET.Address,
            TARGET.Address = SOURCE.Address
    WHEN NOT MATCHED THEN
        INSERT (CustomerID, CustomerName, Address, City)
        VALUES (SOURCE.CustomerID, SOURCE.CustomerName, SOURCE.Address, SOURCE.City);
END;