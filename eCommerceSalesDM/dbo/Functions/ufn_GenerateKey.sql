CREATE   FUNCTION dbo.ufn_GenerateKey
(
    @param1 VARCHAR(MAX),
    @param2 VARCHAR(MAX),
    @param3 VARCHAR(MAX)
)
RETURNS INT
AS
BEGIN
    RETURN ABS(
        CHECKSUM(
            UPPER(TRIM(@param1)) + '|' +
            UPPER(TRIM(@param2)) + '|' +
            UPPER(TRIM(@param3))
        )
    );
END;