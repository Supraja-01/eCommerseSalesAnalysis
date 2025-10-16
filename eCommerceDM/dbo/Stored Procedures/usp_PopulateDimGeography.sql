create   procedure usp_PopulateDimGeography
AS
  Begin
	set nocount on;
  
  insert into Dim.dimGeography(state,city)

  select distinct
		state,
		city
   from eCommerceSalesDMStaging.[sales].[listOfOrders] as s
   where not exists(
	select 1 from Dim.dimGeography d
	where d.state=s.state
	and d.city = s.city
	)

  END