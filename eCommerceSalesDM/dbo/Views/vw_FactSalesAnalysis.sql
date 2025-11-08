create   view dbo.vw_FactSalesAnalysis
as
select salekey,
	geographykey,
	productkey,
	datekey,
	totalAmount,
	TotalProfit,
	TotalQuantity 
from dbo.FactSalesAnalysis