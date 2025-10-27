create   function dbo.ufn_GeneratehashKey(
	@param1 varchar(30),
	@param2 varchar(30)
)
returns char(32)
as
begin
	declare @hashkey char(32);

	select @hashkey=convert(char(32),
		hashbytes('MD5',UPPER(TRIM(@param1)) + '|' +
            UPPER(TRIM(@param2))
        ), 2);
	return @hashkey;
end;