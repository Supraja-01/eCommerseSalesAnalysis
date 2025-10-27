CREATE   FUNCTION dbo.ufn_GenerateUniqueKey
(
    @Source1 VARCHAR(MAX),
    @Source2 VARCHAR(MAX)  
)
RETURNS INT
AS
BEGIN
    RETURN ABS(
        CHECKSUM(
            UPPER(TRIM(@Source1)) + '|' +
            UPPER(TRIM(@Source2))
        )
    );
END;