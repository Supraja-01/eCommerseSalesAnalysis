CREATE TABLE [dbo].[FactSalesAnalysis] (
    [Salekey]       INT       NOT NULL,
    [GeographyKey]  INT       NOT NULL,
    [productKey]    INT       NOT NULL,
    [datekey]       INT       NULL,
    [TotalAmount]   INT       NULL,
    [TotalProfit]   SMALLINT  NULL,
    [TotalQuantity] TINYINT   NULL,
    [HashKey]       CHAR (32) NULL,
    PRIMARY KEY CLUSTERED ([Salekey] ASC),
    CONSTRAINT [FK_factSales_dimGeography_GeographyKey_1] FOREIGN KEY ([GeographyKey]) REFERENCES [dbo].[DimGeography] ([GeographyKey]),
    CONSTRAINT [FK_factSales_dimProduct_ProductKey_1] FOREIGN KEY ([productKey]) REFERENCES [dbo].[DimProduct] ([ProductKey])
);

