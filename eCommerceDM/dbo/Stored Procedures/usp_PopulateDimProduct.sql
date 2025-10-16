create   procedure usp_PopulateDimProduct
AS
  Begin
	set nocount on;
  
  insert into Dim.dimProduct(Category, subCategory)

  select distinct
		Category, 
		subCategory

   from eCommerceSalesDMStaging.[sales].[orderDetails] as s
   where not exists(
	select 1 from Dim.dimProduct d
	where d.Category = s.Category
	and d.subCategory=s.subCategory
	)

  END
