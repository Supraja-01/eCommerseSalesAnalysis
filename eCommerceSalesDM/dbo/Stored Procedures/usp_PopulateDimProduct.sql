CREATE   PROCEDURE dbo.usp_PopulateDimProduct
AS
BEGIN
    SET NOCOUNT ON;

    MERGE Dim.dimProduct AS Target
    USING (
        SELECT distinct
		   dbo.ufn_GenerateUniqueKey(Category,subCategory) as ProductKey,
           dbo.ufn_GeneratehashKey(Category, subCategory) AS ProductHashKey,
            Category,
            subCategory
        FROM eCommerceSalesDMStaging.[sales].[orderDetails]
    ) AS Source
    ON Target.ProductKey = Source.ProductKey

    WHEN MATCHED AND  Target.ProductHashKey <> Source.ProductHashKey THEN 
        UPDATE SET 
            Target.Category = Source.Category,
            Target.subCategory = Source.subCategory

    WHEN NOT MATCHED BY TARGET THEN 
        INSERT ( ProductKey, ProductHashKey, Category, subCategory)
        VALUES (Source. ProductKey, Source.ProductHashKey, Source.Category, Source.subCategory);

END;