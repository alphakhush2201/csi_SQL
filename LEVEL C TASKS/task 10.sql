-- Drop if exists (for clean re-runs)
DROP TABLE IF EXISTS Employee, Manager, Senior_Manager, Lead_Manager, Company;

-- Company Table
CREATE TABLE Company (
    company_code VARCHAR(20) PRIMARY KEY,
    founder VARCHAR(100)
);

-- Lead Manager Table
CREATE TABLE Lead_Manager (
    lead_manager_code VARCHAR(20) PRIMARY KEY,
    company_code VARCHAR(20)
);

-- Senior Manager Table
CREATE TABLE Senior_Manager (
    senior_manager_code VARCHAR(20) PRIMARY KEY,
    lead_manager_code VARCHAR(20),
    company_code VARCHAR(20)
);

-- Manager Table
CREATE TABLE Manager (
    manager_code VARCHAR(20) PRIMARY KEY,
    senior_manager_code VARCHAR(20),
    lead_manager_code VARCHAR(20),
    company_code VARCHAR(20)
);

-- Employee Table
CREATE TABLE Employee (
    employee_code VARCHAR(20) PRIMARY KEY,
    manager_code VARCHAR(20),
    senior_manager_code VARCHAR(20),
    lead_manager_code VARCHAR(20),
    company_code VARCHAR(20)
);
-- Company
INSERT INTO Company VALUES 
('C1', 'Alice'), 
('C2', 'Bob');

-- Lead Managers
INSERT INTO Lead_Manager VALUES 
('LM1', 'C1'),
('LM2', 'C1'),
('LM3', 'C2');

-- Senior Managers
INSERT INTO Senior_Manager VALUES 
('SM1', 'LM1', 'C1'),
('SM2', 'LM1', 'C1'),
('SM3', 'LM2', 'C1'),
('SM4', 'LM3', 'C2');

-- Managers
INSERT INTO Manager VALUES 
('M1', 'SM1', 'LM1', 'C1'),
('M2', 'SM2', 'LM1', 'C1'),
('M3', 'SM4', 'LM3', 'C2');

-- Employees
INSERT INTO Employee VALUES 
('E1', 'M1', 'SM1', 'LM1', 'C1'),
('E2', 'M1', 'SM1', 'LM1', 'C1'),
('E3', 'M2', 'SM2', 'LM1', 'C1'),
('E4', 'M3', 'SM4', 'LM3', 'C2');
SELECT
    c.company_code,
    c.founder,
    COUNT(DISTINCT lm.lead_manager_code) AS lead_manager_count,
    COUNT(DISTINCT sm.senior_manager_code) AS senior_manager_count,
    COUNT(DISTINCT m.manager_code) AS manager_count,
    COUNT(DISTINCT e.employee_code) AS employee_count
FROM
    Company c
LEFT JOIN Lead_Manager lm ON c.company_code = lm.company_code
LEFT JOIN Senior_Manager sm ON c.company_code = sm.company_code
LEFT JOIN Manager m ON c.company_code = m.company_code
LEFT JOIN Employee e ON c.company_code = e.company_code
GROUP BY
    c.company_code, c.founder
ORDER BY
    c.company_code;
