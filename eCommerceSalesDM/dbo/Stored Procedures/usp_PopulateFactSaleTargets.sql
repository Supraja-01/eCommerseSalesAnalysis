CREATE   PROCEDURE dbo.[usp_PopulateFactSaleTargets]
AS
BEGIN
    SET NOCOUNT ON;

    WITH TargetData AS (
        SELECT DISTINCT
		    CONVERT(INT, FORMAT(o.OrderDate, 'yyyyMMdd')) AS dateKey,
            dbo.ufn_GenerateUniqueKey(l.category,l.subcategory) as ProductKey,
            SUM(st.Target) AS TotalTarget
		FROM eCommerceSalesDMStaging.sales.orderDetails AS l
        INNER JOIN eCommerceSalesDMStaging.sales.listOfOrders AS o
            ON l.orderId = o.orderId
		Inner join eCommerceSalesDMStaging.sales.salesTarget AS st
		 ON FORMAT(o.OrderDate, 'yy-MMM') = st.[MonthOfOrderDate]
	Group by CONVERT(INT, FORMAT(o.OrderDate, 'yyyyMMdd')),
            dbo.ufn_GenerateUniqueKey(l.category,l.subcategory)
		
    )
    MERGE Fact.factSaleTargets AS Tgt
    USING (
        SELECT DISTINCT
		    dbo.ufn_GenerateUniqueKey(datekey,ProductKey) as Targetkey,
            dbo.ufn_GenerateTargetHashKey(dateKey, productKey) AS TargetHashKey,
            dateKey,
            productKey,
            TotalTarget
        FROM TargetData
    ) AS Src
    ON  Tgt.TargetKey = Src.TargetKey

    WHEN MATCHED AND Tgt.TargetHashKey <> Src.TargetHashKey THEN 
        UPDATE SET 
            Tgt.TotalTarget = Src.TotalTarget

    WHEN NOT MATCHED BY TARGET THEN 
        INSERT (TargetKey, targetHashKey, dateKey, ProductKey, TotalTarget)
        VALUES (Src.TargetKey, Src.TargetHashKey, Src.dateKey, Src.productKey,  Src.TotalTarget);
END;