-- Create SubjectAllotments table
CREATE TABLE SubjectAllotments (
    StudentId VARCHAR(20),
    SubjectId VARCHAR(20),
    Is_Valid BIT
);

-- Insert sample data
INSERT INTO SubjectAllotments (StudentId, SubjectId, Is_Valid) VALUES
('159103036', 'PO1491', 1),
('159103036', 'PO1492', 0),
('159103036', 'PO1493', 0),
('159103036', 'PO1494', 0),
('159103036', 'PO1495', 0),
('159103037', 'PO1497', 1),
('159103038', 'PO1499', 1);

GO

-- Create SubjectRequest table
CREATE TABLE SubjectRequest (
    StudentId VARCHAR(20),
    SubjectId VARCHAR(20)
);

-- Insert sample data into SubjectRequest
INSERT INTO SubjectRequest (StudentId, SubjectId) VALUES
('159103036', 'PO1496'), -- existing student, new subject
('159103037', 'PO1497'), -- existing student, same subject
('159103039', 'PO1500'); -- new student

GO

-- Stored Procedure must be in a new batch
CREATE PROCEDURE sp_ProcessSubjectRequests
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StudentId VARCHAR(20), @RequestedSubjectId VARCHAR(20), @CurrentSubjectId VARCHAR(20);

    DECLARE request_cursor CURSOR FOR
    SELECT StudentId, SubjectId
    FROM SubjectRequest;

    OPEN request_cursor;

    FETCH NEXT FROM request_cursor INTO @StudentId, @RequestedSubjectId;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SELECT @CurrentSubjectId = SubjectId
        FROM SubjectAllotments
        WHERE StudentId = @StudentId AND Is_Valid = 1;

        IF @CurrentSubjectId IS NULL
        BEGIN
            INSERT INTO SubjectAllotments (StudentId, SubjectId, Is_Valid)
            VALUES (@StudentId, @RequestedSubjectId, 1);
        END
        ELSE IF @CurrentSubjectId != @RequestedSubjectId
        BEGIN
            UPDATE SubjectAllotments
            SET Is_Valid = 0
            WHERE StudentId = @StudentId AND Is_Valid = 1;

            INSERT INTO SubjectAllotments (StudentId, SubjectId, Is_Valid)
            VALUES (@StudentId, @RequestedSubjectId, 1);
        END

        FETCH NEXT FROM request_cursor INTO @StudentId, @RequestedSubjectId;
    END

    CLOSE request_cursor;
    DEALLOCATE request_cursor;
END;

GO
 