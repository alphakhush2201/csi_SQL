CREATE TABLE BUFinance (
    BU VARCHAR(50),
    MonthName VARCHAR(10),
    Cost DECIMAL(10,2),
    Revenue DECIMAL(10,2)
);

INSERT INTO BUFinance VALUES
('Tech', 'Jan', 50000, 120000),
('Tech', 'Feb', 60000, 130000),
('HR', 'Jan', 20000, 40000),
('HR', 'Feb', 25000, 42000);
SELECT 
    BU,
    MonthName,
    ROUND(Cost * 1.0 / Revenue, 2) AS CostRevenueRatio
FROM BUFinance;
