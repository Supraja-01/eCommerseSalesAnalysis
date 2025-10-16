create   procedure dbo.usp_PopulateDimDate
As 
 begin
	set nocount on;

	INSERT INTO Dim.dimDate (
		dateKey,
		fullDate,
		saleYear,
		saleMonth,
		saleMonthName
		)
        SELECT distinct
            CONVERT(INT, FORMAT(OrderDate, 'yyyyMMdd')) AS dateKey,
            OrderDate as fullDate,
			YEAR(OrderDate) AS saleYear,
            MONTH(OrderDate) AS saleMonth,
            DATENAME(MONTH, OrderDate) AS saleMonthName
            
        FROM eCommerceSalesDMStaging.sales.listOfOrders
        WHERE  CONVERT(INT, FORMAT(OrderDate, 'yyyyMMdd')) 
            NOT IN (SELECT dateKey FROM Dim.dimDate);
  End