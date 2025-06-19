WITH Numbered AS (
    SELECT *,
           DATEADD(DAY, -ROW_NUMBER() OVER (ORDER BY Start_Date), Start_Date) AS grp
    FROM Projects
),
Grouped AS (
    SELECT MIN(Start_Date) AS ProjectStart,
           MAX(End_Date) AS ProjectEnd,
           DATEDIFF(DAY, MIN(Start_Date), MAX(End_Date)) AS Duration
    FROM Numbered
    GROUP BY grp
)
SELECT *
FROM Grouped
ORDER BY Duration, ProjectStart;
