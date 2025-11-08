create   view dbo.vw_FactSalesTargets
as
select datekey,
	productkey,
	Salekey,
	totalTarget 
from dbo.FactSalesTargets