CREATE PROCEDURE UpdateCustomer_SCD1
AS
BEGIN
    MERGE DimCustomer AS TARGET
    USING StgCustomer AS SOURCE
    ON TARGET.CustomerID = SOURCE.CustomerID
    WHEN MATCHED THEN 
        UPDATE SET 
            TARGET.CustomerName = SOURCE.CustomerName,
            TARGET.Address = SOURCE.Address,
            TARGET.City = SOURCE.City
    WHEN NOT MATCHED THEN
        INSERT (CustomerID, CustomerName, Address, City)
        VALUES (SOURCE.CustomerID, SOURCE.CustomerName, SOURCE.Address, SOURCE.City);
END;