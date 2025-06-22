CREATE TABLE OCCUPATIONS (
    Name VARCHAR(50),
    Occupation VARCHAR(50)
);

INSERT INTO OCCUPATIONS (Name, Occupation) VALUES
('Samantha', 'Doctor'),
('Julia', 'Actor'),
('Maria', 'Actor'),
('Meera', 'Singer'),
('Ashely', 'Professor'),
('Ketty', 'Professor'),
('Christeen', 'Professor'),
('Jane', 'Actor'),
('Jenny', 'Doctor'),
('Priya', 'Singer');

WITH Doctors AS (
    SELECT Name, ROW_NUMBER() OVER (ORDER BY Name) AS rn
    FROM OCCUPATIONS
    WHERE Occupation = 'Doctor'
),
Professors AS (
    SELECT Name, ROW_NUMBER() OVER (ORDER BY Name) AS rn
    FROM OCCUPATIONS
    WHERE Occupation = 'Professor'
),
Singers AS (
    SELECT Name, ROW_NUMBER() OVER (ORDER BY Name) AS rn
    FROM OCCUPATIONS
    WHERE Occupation = 'Singer'
),
Actors AS (
    SELECT Name, ROW_NUMBER() OVER (ORDER BY Name) AS rn
    FROM OCCUPATIONS
    WHERE Occupation = 'Actor'
)
SELECT
    d.Name AS Doctor,
    p.Name AS Professor,
    s.Name AS Singer,
    a.Name AS Actor
FROM Doctors d
FULL OUTER JOIN Professors p ON d.rn = p.rn
FULL OUTER JOIN Singers s ON COALESCE(d.rn, p.rn) = s.rn
FULL OUTER JOIN Actors a ON COALESCE(d.rn, p.rn, s.rn) = a.rn
ORDER BY
    COALESCE(d.rn, p.rn, s.rn, a.rn);

