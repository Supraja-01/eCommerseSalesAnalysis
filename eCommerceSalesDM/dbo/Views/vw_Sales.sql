create   view dbo.vw_Sales
as
select salekey,
	geographykey,
	productkey,
	datekey,
	totalAmount,
	TotalProfit,
	TotalQuantity 
from Fact.factSalesAnalysis