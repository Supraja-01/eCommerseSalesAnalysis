CREATE   PROCEDURE Dbo.usp_PopulateDimDate
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartDate DATE = '2018-01-01';
    DECLARE @EndDate   DATE = '2019-12-31';

    ;WITH DateSequence AS
    (
        SELECT @StartDate AS DateValue
        UNION ALL
        SELECT DATEADD(DAY, 1, DateValue)
        FROM DateSequence
        WHERE DateValue < @EndDate
    )
    INSERT INTO Dbo.DimDate (
        dateKey,
        fullDate,
        saleYear,
        saleMonth,
        saleMonthName
    )
    SELECT 
        CONVERT(INT, FORMAT(DateValue, 'yyyyMMdd')) AS dateKey,
        DateValue AS fullDate,
        YEAR(DateValue) AS saleYear,
        MONTH(DateValue) AS saleMonth,
        DATENAME(MONTH, DateValue) AS saleMonthName
    FROM DateSequence
	WHERE CONVERT(INT, FORMAT(DateValue, 'yyyyMMdd')) 
      NOT IN (SELECT dateKey FROM Dbo.DimDate)
    OPTION (MAXRECURSION 0);
END;