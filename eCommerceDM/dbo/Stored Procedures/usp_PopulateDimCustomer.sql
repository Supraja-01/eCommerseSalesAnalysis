create   procedure usp_PopulateDimCustomer
AS
  Begin
	set nocount on;
  
  insert into Dim.dimCustomer(customerName,State,City)

  select distinct
		customerName,
		State,
		City
   from eCommerceSalesDMStaging.[sales].[listOfOrders] as s
   where not exists(
	select 1 from Dim.dimCustomer d
	where d.customerName = s.customerName
	and d.state=s.state
	and d.city = s.city
	)

  END