create   view dbo.vw_DimCustomer
as
select CustomerKey,
	CustomerName,
	state,
	city
from dbo.DimCustomer