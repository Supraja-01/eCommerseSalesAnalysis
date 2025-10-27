CREATE   FUNCTION dbo.ufn_GenerateTargetHashKey
(
    @param1 INT,         
    @param2 int    
      
)
RETURNS CHAR(32)
AS
BEGIN
    DECLARE @hashkey CHAR(32);

    SELECT @hashkey = CONVERT(CHAR(32),
        HASHBYTES('MD5',
            CAST(@param1 AS NVARCHAR(max)) + '|' +
            CAST(@param2 AS NVARCHAR(max)) 
            
        ), 2
    );

    RETURN @hashkey;
END;