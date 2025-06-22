CREATE TABLE EmployeeBand (
    EmpID INT,
    SubBand VARCHAR(10)
);

INSERT INTO EmployeeBand VALUES
(1, 'A1'), (2, 'A1'), (3, 'A2'),
(4, 'B1'), (5, 'A1'), (6, 'B1');
SELECT 
    SubBand,
    COUNT(*) AS Headcount,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS Percentage
FROM EmployeeBand
GROUP BY SubBand;
