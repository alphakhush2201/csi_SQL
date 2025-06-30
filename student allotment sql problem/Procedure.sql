CREATE PROCEDURE AllotSubjects
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StudentId INT;
    DECLARE @SubjectId VARCHAR(20);
    DECLARE @Preference INT;
    DECLARE @RemainingSeats INT;
    DECLARE @Found BIT;

    DECLARE StudentCursor CURSOR FOR
        SELECT StudentId
        FROM StudentDetails
        ORDER BY GPA DESC;

    OPEN StudentCursor;
    FETCH NEXT FROM StudentCursor INTO @StudentId;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @Preference = 1;
        SET @Found = 0;

        WHILE @Preference <= 5 AND @Found = 0
        BEGIN
            SELECT @SubjectId = SubjectId
            FROM StudentPreference
            WHERE StudentId = @StudentId AND Preference = @Preference;

            IF @SubjectId IS NOT NULL
            BEGIN
                SELECT @RemainingSeats = RemainingSeats
                FROM SubjectDetails
                WHERE SubjectId = @SubjectId;

                IF @RemainingSeats > 0
                BEGIN
                    -- Allot the student
                    INSERT INTO Allotments(SubjectId, StudentId)
                    VALUES (@SubjectId, @StudentId);

                    -- Decrease the seat count
                    UPDATE SubjectDetails
                    SET RemainingSeats = RemainingSeats - 1
                    WHERE SubjectId = @SubjectId;

                    SET @Found = 1;
                END
            END

            SET @Preference = @Preference + 1;
        END

        IF @Found = 0
        BEGIN
            INSERT INTO UnallottedStudents(StudentId)
            VALUES (@StudentId);
        END

        FETCH NEXT FROM StudentCursor INTO @StudentId;
    END

    CLOSE StudentCursor;
    DEALLOCATE StudentCursor;
END;
