CREATE TABLE EMPLOYEES (
    EmpID INT,
    Salary INT
);

INSERT INTO EMPLOYEES VALUES
(1, 1000), (2, 2000), (3, 3000), (4, 1050), (5, 2050);
SELECT 
    CEILING(AVG(CAST(Salary AS FLOAT)) 
    - AVG(CAST(REPLACE(Salary, '0', '') AS FLOAT))) AS Error;
