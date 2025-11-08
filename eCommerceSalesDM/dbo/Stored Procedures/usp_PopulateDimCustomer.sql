
CREATE   PROCEDURE dbo.usp_PopulateDimCustomer
AS
BEGIN
    SET NOCOUNT ON;

	with SourceData as(
	SELECT distinct
		   dbo.ufn_generatekey(customerName,State,City) as customerKey,
            customerName,
            State,
            City,
			dbo.ufn_GenerateUniqueHashKey(customerName, State, City) AS HashKey
        FROM eCommerceSalesDMStaging.[sales].[listOfOrders]
    ) 

    MERGE Dbo.DimCustomer AS Target
    USING 
        SourceData as Source
    ON Target.customerKey = Source.customerKey
	
    WHEN MATCHED AND Target.HashKey <> Source.HashKey THEN 
        UPDATE SET 
            Target.customerName = Source.customerName,
            Target.State = Source.State,
            Target.City = Source.City

    WHEN NOT MATCHED BY TARGET THEN 
        INSERT (customerKey,customerName, State, City,HashKey )
        VALUES (Source.customerKey, Source.customerName, Source.State, Source.City, Source.HashKey);

END;