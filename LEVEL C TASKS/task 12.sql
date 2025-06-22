CREATE TABLE JobFamilyCost (
    JobFamily VARCHAR(50),
    Location VARCHAR(50),
    Cost DECIMAL(10,2)
);

INSERT INTO JobFamilyCost VALUES
('Engineering', 'India', 50000),
('Engineering', 'International', 70000),
('HR', 'India', 20000),
('HR', 'International', 30000);
SELECT 
    JobFamily,
    ROUND(SUM(CASE WHEN Location = 'India' THEN Cost ELSE 0 END) * 100.0 / SUM(Cost), 2) AS India_Percentage,
    ROUND(SUM(CASE WHEN Location = 'International' THEN Cost ELSE 0 END) * 100.0 / SUM(Cost), 2) AS International_Percentage
FROM JobFamilyCost
GROUP BY JobFamily;
