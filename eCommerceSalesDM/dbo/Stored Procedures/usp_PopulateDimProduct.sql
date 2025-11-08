CREATE   PROCEDURE dbo.usp_PopulateDimProduct
AS
BEGIN
    SET NOCOUNT ON;

    MERGE Dbo.dimProduct AS Target
    USING (
        SELECT distinct
		   dbo.ufn_GenerateUniqueKey(Category,subCategory) as ProductKey,
            Category,
            SubCategory,
			dbo.ufn_GeneratehashKey(Category, SubCategory) AS HashKey
        FROM eCommerceSalesDMStaging.[sales].[orderDetails]
    ) AS Source
    ON Target.ProductKey = Source.ProductKey

    WHEN MATCHED AND  Target.HashKey <> Source.HashKey THEN 
        UPDATE SET 
            Target.Category = Source.Category,
            Target.subCategory = Source.subCategory

    WHEN NOT MATCHED BY TARGET THEN 
        INSERT ( ProductKey, Category, subCategory,HashKey)
        VALUES (Source. ProductKey, Source.Category, Source.subCategory,Source.HashKey);

END;