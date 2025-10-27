CREATE   PROCEDURE dbo.usp_PopulateDimCustomer
AS
BEGIN
    SET NOCOUNT ON;

	with SourceData as(
	SELECT distinct
		   dbo.ufn_generatekey(customerName,State,City) as customerKey,
           dbo.ufn_GenerateCustomerHashKey(customerName, State, City) AS customerHashKey,
            customerName,
            State,
            City
        FROM eCommerceSalesDMStaging.[sales].[listOfOrders]
    ) 

    MERGE Dim.dimCustomer AS Target
    USING 
        SourceData as Source
    ON Target.customerKey = Source.customerKey
	
    WHEN MATCHED AND Target.customerHashKey <> Source.customerHashKey THEN 
        UPDATE SET 
            Target.customerName = Source.customerName,
            Target.State = Source.State,
            Target.City = Source.City

    WHEN NOT MATCHED BY TARGET THEN 
        INSERT (customerKey, customerHashKey, customerName, State, City)
        VALUES (Source.customerKey, Source.customerHashKey, Source.customerName, Source.State, Source.City);

END;