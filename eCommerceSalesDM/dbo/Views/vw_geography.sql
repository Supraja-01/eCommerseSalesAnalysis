create   view dbo.vw_geography
as
select geographykey,
	state,
	city
from Dim.dimGeography