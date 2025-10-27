create   view dbo.vw_SaleTarget
as
select datekey,
	productkey,
	salekey,
	totalTarget 
from Fact.factSaleTargets