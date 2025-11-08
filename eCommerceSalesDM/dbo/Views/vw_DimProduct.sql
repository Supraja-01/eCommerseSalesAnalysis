create   view dbo.vw_DimProduct
as
select productkey,
	category,
	subCategory
from dbo.DimProduct