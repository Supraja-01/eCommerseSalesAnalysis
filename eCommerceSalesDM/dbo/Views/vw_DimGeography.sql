create   view dbo.vw_DimGeography
as
select geographykey,
	state,
	city
from dbo.DimGeography