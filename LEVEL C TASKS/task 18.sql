CREATE TABLE EmployeeCost (
    BU VARCHAR(50),
    MonthName VARCHAR(10),
    EmpID INT,
    Cost DECIMAL(10,2),
    Weight FLOAT
);

INSERT INTO EmployeeCost VALUES
('Tech', 'Jan', 1, 50000, 1.0),
('Tech', 'Jan', 2, 60000, 0.5),
('Tech', 'Feb', 3, 65000, 1.5),
('HR', 'Jan', 4, 20000, 1.0);
SELECT 
    BU,
    MonthName,
    ROUND(SUM(Cost * Weight) / SUM(Weight), 2) AS WeightedAvgCost
FROM EmployeeCost
GROUP BY BU, MonthName;
    