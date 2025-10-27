create   view dbo.vw_categories
as
select productkey,
	category,
	subCategory
from Dim.dimProduct