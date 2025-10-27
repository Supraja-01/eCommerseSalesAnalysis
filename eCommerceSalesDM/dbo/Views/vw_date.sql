create   view dbo.vw_date
as 
select datekey,
	fulldate,
	saleyear,
	saleMonthName 
from Dim.dimDate