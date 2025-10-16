create   procedure dbo.usp_PopulateFactSales
As 
 begin
	set nocount on;

	INSERT INTO Fact.factSales (
            orderId,
            dateKey,
            customerKey,
            geographyKey,
            productKey,
            amount,
            profit,
            quantity
        )
        SELECT DISTINCT
            l.orderId AS orderId,
            dd.dateKey AS dateKey,
            dc.customerKey AS customerKey,
            dg.geographyKey AS geographyKey,
            dp.productKey AS productKey,
            od.Amount AS amount,
            od.Profit AS profit,
            od.Quantity AS quantity
        FROM eCommerceSalesDMStaging.sales.listOfOrders l
        INNER JOIN eCommerceSalesDMStaging.sales.orderDetails od
            ON l.orderId = od.orderId                   
        INNER JOIN Dim.dimDate dd
            ON CAST(dd.fullDate AS DATE) = CAST(l.OrderDate AS DATE)
        INNER JOIN Dim.dimCustomer dc
            ON l.customerName = dc.CustomerName
        INNER JOIN Dim.dimGeography dg
            ON l.State = dg.State                      
            AND l.City = dg.City                           
        INNER JOIN Dim.dimProduct dp
            ON od.Category = dp.Category                
            AND od.SubCategory = dp.SubCategory            
        WHERE NOT EXISTS (
            SELECT 1 
            FROM Fact.factSales f
            WHERE f.orderId = od.orderId
              AND f.productKey = dp.productKey
        );

  End
