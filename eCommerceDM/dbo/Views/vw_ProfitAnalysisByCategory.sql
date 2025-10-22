CREATE   VIEW dbo.vw_ProfitAnalysisByCategory
AS
SELECT 
    dd.DateKey,
    dp.ProductKey,
    dg.GeographyKey,
    dp.Category,
    dp.SubCategory,
    dd.SaleYear AS [Year],
    dd.SaleMonthName AS [Month],
    dg.State,
    dg.City,
    SUM(fs.Amount) AS TotalSales,
    SUM(fs.Profit) AS TotalProfit,
    SUM(fs.Quantity) AS TotalQuantity,
    ROUND(
        CASE WHEN SUM(fs.Amount) > 0 
             THEN (SUM(fs.Profit) * 100.0 / SUM(fs.Amount)) 
             ELSE 0 END, 2
    ) AS ProfitMarginPercent
FROM Fact.FactSales fs
INNER JOIN Dim.DimDate dd 
    ON fs.DateKey = dd.DateKey
INNER JOIN Dim.DimProduct dp 
    ON fs.ProductKey = dp.ProductKey
INNER JOIN Dim.DimGeography dg 
    ON fs.GeographyKey = dg.GeographyKey
GROUP BY 
    dd.DateKey, dd.SaleYear, dd.SaleMonthName,
    dp.ProductKey, dp.Category, dp.SubCategory,
    dg.GeographyKey,  dg.State, dg.City;