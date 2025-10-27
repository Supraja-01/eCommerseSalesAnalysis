CREATE   PROCEDURE dbo.[usp_PopulateFactSaleTargets]
AS
BEGIN
    SET NOCOUNT ON;

    WITH TargetData AS (
        SELECT DISTINCT
		    CONVERT(INT, FORMAT(o.OrderDate, 'yyyyMMdd')) AS dateKey,
            dbo.ufn_GenerateUniqueKey(l.category,l.subcategory) as ProductKey,
			fs.Salekey,
            MAX(st.Target) AS TotalTarget
		FROM eCommerceSalesDMStaging.sales.orderDetails AS l
        INNER JOIN eCommerceSalesDMStaging.sales.listOfOrders AS o
            ON l.orderId = o.orderId
		Inner join eCommerceSalesDMStaging.sales.salesTarget AS st
		 ON FORMAT(o.OrderDate, 'yy-MMM') = st.[MonthOfOrderDate]
		INNER JOIN Fact.factSalesAnalysis AS fs
        ON fs.ProductKey = dbo.ufn_GenerateUniqueKey(l.category, l.subcategory)
       AND fs.DateKey = CONVERT(INT, FORMAT(o.OrderDate, 'yyyyMMdd'))
		GROUP BY
        CONVERT(INT, FORMAT(o.OrderDate, 'yyyyMMdd')),
        dbo.ufn_GenerateUniqueKey(l.category, l.subcategory),
        fs.SaleKey
		
    )
    MERGE Fact.factSaleTargets AS Tgt
    USING (
        SELECT DISTINCT
		    dbo.ufn_GenerateKey(datekey,ProductKey,SaleKey) as Targetkey,
            dbo.ufn_GenerateFactHashKey(dateKey, productKey,SaleKey) AS TargetHashKey,
            dateKey,
            productKey,
			Salekey,
            TotalTarget
        FROM TargetData
    ) AS Src
    ON  Tgt.TargetKey = Src.TargetKey

    WHEN MATCHED AND Tgt.TargetHashKey <> Src.TargetHashKey THEN 
        UPDATE SET 
            Tgt.TotalTarget = Src.TotalTarget

    WHEN NOT MATCHED BY TARGET THEN 
        INSERT (TargetKey, targetHashKey, dateKey, ProductKey,Salekey, TotalTarget)
        VALUES (Src.TargetKey, Src.TargetHashKey, Src.dateKey, Src.productKey,Src.Salekey,  Src.TotalTarget);
END;