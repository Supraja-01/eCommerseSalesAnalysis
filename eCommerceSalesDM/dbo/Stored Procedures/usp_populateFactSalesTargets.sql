CREATE   PROCEDURE dbo.usp_populateFactSalesTargets
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
		INNER JOIN dbo.factSalesAnalysis AS fs
        ON fs.ProductKey = dbo.ufn_GenerateUniqueKey(l.category, l.subcategory)
       AND fs.DateKey = CONVERT(INT, FORMAT(o.OrderDate, 'yyyyMMdd'))
		GROUP BY
        CONVERT(INT, FORMAT(o.OrderDate, 'yyyyMMdd')),
        dbo.ufn_GenerateUniqueKey(l.category, l.subcategory),
        fs.SaleKey
		
    )
    MERGE dbo.factSalesTargets AS Tgt
    USING (
        SELECT DISTINCT
		    dbo.ufn_GenerateKey(datekey,ProductKey,SaleKey) as Targetkey,
            dbo.ufn_GenerateUniqueHashKey(dateKey, productKey,SaleKey) AS HashKey,
            dateKey,
            productKey,
			Salekey,
            TotalTarget
        FROM TargetData
    ) AS Src
    ON  Tgt.TargetKey = Src.TargetKey

    WHEN MATCHED AND Tgt.HashKey <> Src.HashKey THEN 
        UPDATE SET 
            Tgt.TotalTarget = Src.TotalTarget

    WHEN NOT MATCHED BY TARGET THEN 
        INSERT (TargetKey, dateKey, ProductKey,Salekey, TotalTarget, HashKey)
        VALUES (Src.TargetKey, Src.dateKey, Src.productKey,Src.Salekey,  Src.TotalTarget,Src.HashKey);
END;