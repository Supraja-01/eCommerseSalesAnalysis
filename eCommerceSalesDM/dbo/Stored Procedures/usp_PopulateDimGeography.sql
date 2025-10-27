CREATE   PROCEDURE dbo.usp_PopulateDimGeography
AS
BEGIN
    SET NOCOUNT ON;

    MERGE Dim.dimGeography AS Target
    USING (
        SELECT distinct
		   dbo.ufn_GenerateUniqueKey(State,City) as GeographyKey,
           dbo.ufn_GeneratehashKey(State, City) AS GeographyHashKey,
            State,
            City
        FROM eCommerceSalesDMStaging.[sales].[listOfOrders]
    ) AS Source
    ON Target.GeographyKey = Source.GeographyKey

    WHEN MATCHED AND Target.GeographyHashKey <> Source.GeographyHashKey THEN 
        UPDATE SET 
            Target.State = Source.State,
            Target.City = Source.City

    WHEN NOT MATCHED BY TARGET THEN 
        INSERT ( GeographyKey, GeographyHashKey, State, City)
        VALUES (Source. GeographyKey, Source.GeographyHashKey, Source.State, Source.City);
END;