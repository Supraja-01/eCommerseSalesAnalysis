CREATE   PROCEDURE dbo.usp_PopulateDimGeography
AS
BEGIN
    SET NOCOUNT ON;

    MERGE Dbo.DimGeography AS Target
    USING (
        SELECT distinct
		   dbo.ufn_GenerateUniqueKey(State,City) as GeographyKey,
           dbo.ufn_GenerateHashKey(State, City) AS HashKey,
            State,
            City
        FROM eCommerceSalesDMStaging.[sales].[listOfOrders]
    ) AS Source
    ON Target.GeographyKey = Source.GeographyKey

    WHEN MATCHED AND Target.HashKey <> Source.HashKey THEN 
        UPDATE SET 
            Target.State = Source.State,
            Target.City = Source.City

    WHEN NOT MATCHED BY TARGET THEN 
        INSERT ( GeographyKey, State, City, HashKey)
        VALUES (Source. GeographyKey, Source.State, Source.City, Source.HashKey);
END;