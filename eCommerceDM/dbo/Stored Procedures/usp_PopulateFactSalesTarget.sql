CREATE   PROCEDURE dbo.usp_PopulateFactSalesTarget
AS
BEGIN
    SET NOCOUNT ON;

        INSERT INTO Fact.factSalesTarget (
            dateKey,
            productKey,
            Target
        )
        SELECT 
            dd.dateKey,
            dp.productKey,
            st.Target
        FROM eCommerceSalesDMStaging.sales.salesTarget st
        INNER JOIN Dim.dimDate dd
            ON FORMAT(dd.fullDate, 'yy-MMM') = st.[MonthOfOrderDate]
        INNER JOIN Dim.dimProduct dp
            ON dp.Category = st.Category
        WHERE NOT EXISTS (
            SELECT 1 FROM Fact.factSalesTarget f
            WHERE f.dateKey = dd.dateKey
              AND f.productKey = dp.productKey
        );
    END