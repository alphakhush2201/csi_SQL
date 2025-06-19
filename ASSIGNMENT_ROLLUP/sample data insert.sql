-- Step 1: Create the Sales table
CREATE TABLE Sales (
    ProductCategory VARCHAR(50),
    ProductName VARCHAR(50),
    SaleAmount DECIMAL(10, 2)
);

-- Step 2: Insert sample data
INSERT INTO Sales (ProductCategory, ProductName, SaleAmount) VALUES
('Electronics', 'Laptop', 1000.00),
('Electronics', 'Phone', 800.00),
('Electronics', 'Tablet', 500.00),
('Clothing', 'Shirt', 300.00),
('Clothing', 'Pants', 400.00),
('Furniture', 'Sofa', 1200.00),
('Furniture', 'Bed', 900.00);
