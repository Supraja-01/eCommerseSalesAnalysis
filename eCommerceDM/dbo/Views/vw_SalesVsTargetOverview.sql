CREATE   VIEW dbo.vw_SalesVsTargetOverview
AS
SELECT 
    dd.fullDate AS [Order Date],
    dd.saleYear AS [Year],
    dd.saleMonthName AS [Month],
    dg.State,
    dg.City,
    dp.Category,
    dp.SubCategory,
    SUM(fs.Amount) AS ActualSales,
    SUM(fs.Profit) AS TotalProfit,
    SUM(fs.Quantity) AS TotalQuantity,
    SUM(fst.Target) AS TargetSales,
    CASE 
        WHEN SUM(fst.Target) > 0 THEN 
            (SUM(fs.Amount) * 100.0 / SUM(fst.Target))
        ELSE 0 
    END AS AchievementPercent
FROM Fact.factSales fs
INNER JOIN Dim.dimDate dd 
    ON fs.dateKey = dd.dateKey
INNER JOIN Dim.dimProduct dp 
    ON fs.productKey = dp.productKey
INNER JOIN Dim.dimGeography dg 
    ON fs.geographyKey = dg.geographyKey
LEFT JOIN Fact.factSalesTarget fst
    ON dd.dateKey = fst.dateKey 
    AND dp.productKey = fst.productKey
GROUP BY 
    dd.fullDate, dd.saleYear, dd.saleMonthName,
    dg.State, dg.City,
    dp.Category, dp.SubCategory
Having SUM(fst.Target) is not NULL