CREATE   FUNCTION dbo.ufn_GenerateFactHashKey(
    @param1 CHAR(32),   
    @param2 CHAR(32),   
    @param3 INT         
)
RETURNS CHAR(32)
AS
BEGIN
    DECLARE @hashkey CHAR(32);

    SELECT @hashkey = CONVERT(CHAR(32),
        HASHBYTES('MD5', 
            UPPER(TRIM(@param1)) + '|' +
            UPPER(TRIM(@param2)) + '|' +
            CAST(@param3 AS NVARCHAR(20))
        ), 2);

    RETURN @hashkey;
END;