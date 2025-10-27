create   function dbo.ufn_GenerateCustomerHashKey(
	@customername varchar(50),
	@state varchar(30),
	@city varchar(30)
)
returns char(32)
as
begin
	declare @hashkey char(32);

	select @hashkey=convert(char(32),
		hashbytes('MD5',UPPER(TRIM(@customerName)) + '|' +
            UPPER(TRIM(@State)) + '|' +
            UPPER(TRIM(@City))
        ), 2);
	return @hashkey;
end;