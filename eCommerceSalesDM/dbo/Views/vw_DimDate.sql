create   view dbo.vw_DimDate
as 
select datekey,
	fulldate,
	saleyear,
	saleMonthName 
from dbo.DimDate