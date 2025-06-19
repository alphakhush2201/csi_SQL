-- Function 1: Format Date MM/DD/YYYY
CREATE FUNCTION fn_FormatDate_MMDDYYYY (@InputDate DATETIME)
RETURNS VARCHAR(10)
AS
BEGIN
    RETURN RIGHT('0' + CAST(MONTH(@InputDate) AS VARCHAR(2)), 2) + '/' +
           RIGHT('0' + CAST(DAY(@InputDate) AS VARCHAR(2)), 2) + '/' +
           CAST(YEAR(@InputDate) AS VARCHAR(4));
END;
