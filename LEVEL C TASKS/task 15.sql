CREATE TABLE Employees (
    EmpID INT,
    Name VARCHAR(50),
    Salary INT
);

INSERT INTO Employees VALUES
(1, 'Alice', 80000),
(2, 'Bob', 75000),
(3, 'Carol', 95000),
(4, 'David', 72000),
(5, 'Eva', 91000),
(6, 'Frank', 87000);
SELECT EmpID, Name, Salary
FROM (
    SELECT *, DENSE_RANK() OVER (ORDER BY Salary DESC) AS rnk
    FROM Employees
) AS ranked
WHERE rnk <= 5;
