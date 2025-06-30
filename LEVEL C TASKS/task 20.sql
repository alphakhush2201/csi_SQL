CREATE TABLE SourceTable (
    ID INT,
    Name VARCHAR(50)
);

CREATE TABLE TargetTable (
    ID INT,
    Name VARCHAR(50)
);

INSERT INTO SourceTable VALUES
(1, 'Alice'), (2, 'Bob'), (3, 'Carol');
INSERT INTO TargetTable (ID, Name)
SELECT s.ID, s.Name
FROM SourceTable s
EXCEPT
SELECT t.ID, t.Name
FROM TargetTable t;



