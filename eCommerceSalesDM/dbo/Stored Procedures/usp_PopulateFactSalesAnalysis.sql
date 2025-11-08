CREATE   PROCEDURE dbo.usp_PopulateFactSalesAnalysis
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH AggregatedData AS (
        SELECT 
            dbo.ufn_GenerateUniqueKey(o.state,o.city) as GeographyKey,
            dbo.ufn_GenerateUniqueKey(l.category,l.subcategory) as ProductKey,
            CONVERT(INT, FORMAT(o.OrderDate, 'yyyyMMdd')) AS dateKey,
            SUM(l.Amount) AS TotalAmount,
            SUM(l.Profit) AS TotalProfit,
            SUM(l.Quantity) AS TotalQuantity
        FROM eCommerceSalesDMStaging.sales.orderDetails AS l
        INNER JOIN eCommerceSalesDMStaging.sales.listOfOrders AS o
            ON l.orderId = o.orderId
        GROUP BY 
            dbo.ufn_GenerateUniqueKey(o.state,o.city),
            dbo.ufn_GenerateUniqueKey(l.category,l.subcategory),
            CONVERT(INT, FORMAT(o.OrderDate, 'yyyyMMdd'))
    )
    MERGE dbo.factSalesAnalysis AS Target
    USING (
        SELECT DISTINCT
		    dbo.ufn_GenerateKey(ProductKey,GeographyKey,datekey) as salekey,
            GeographyKey,
            ProductKey,
            datekey,
            TotalAmount,
            TotalProfit,
            TotalQuantity,
			dbo.ufn_GenerateUniqueHashKey(ProductKey, GeographyKey, datekey) AS HashKey
        FROM AggregatedData
    ) AS Source
    ON Target.SaleKey = Source.SaleKey

    WHEN MATCHED AND  Target.HashKey <> Source.HashKey THEN 
        UPDATE SET
            Target.TotalAmount = Source.TotalAmount,
            Target.TotalProfit = Source.TotalProfit,
            Target.TotalQuantity = Source.TotalQuantity

    WHEN NOT MATCHED BY TARGET THEN 
        INSERT (SaleKey, GeographyKey, ProductKey, datekey, TotalAmount, TotalProfit, TotalQuantity,HashKey)
        VALUES (Source.SaleKey, Source.GeographyKey, Source.ProductKey, Source.datekey, Source.TotalAmount, Source.TotalProfit, Source.TotalQuantity,Source.HashKey);
END;