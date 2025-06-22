CREATE TABLE Numbers (n INT);


WITH Nums AS (
    SELECT TOP (1000) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects
)
INSERT INTO Numbers (n)
SELECT n FROM Nums;
WITH Primes AS (
    SELECT n
    FROM Numbers AS outer_n
    WHERE n >= 2 AND NOT EXISTS (
        SELECT 1
        FROM Numbers AS inner_n
        WHERE inner_n.n BETWEEN 2 AND SQRT(outer_n.n)
          AND outer_n.n % inner_n.n = 0
    )
)
SELECT * FROM Primes ORDER BY n;
SELECT STRING_AGG(CAST(n AS VARCHAR), '&') AS PrimeList
FROM (
    SELECT n
    FROM Numbers AS outer_n
    WHERE n >= 2 AND NOT EXISTS (
        SELECT 1
        FROM Numbers AS inner_n
        WHERE inner_n.n BETWEEN 2 AND SQRT(outer_n.n)
          AND outer_n.n % inner_n.n = 0
    )
) Primes;
