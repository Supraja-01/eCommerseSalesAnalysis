CREATE TABLE [Fact].[factSalesAnalysis] (
    [salekey]       INT       NOT NULL,
    [salehashKey]   CHAR (32) NULL,
    [GeographyKey]  INT       NOT NULL,
    [productKey]    INT       NOT NULL,
    [datekey]       INT       NULL,
    [TotalAmount]   INT       NULL,
    [TotalProfit]   SMALLINT  NULL,
    [TotalQuantity] TINYINT   NULL,
    PRIMARY KEY CLUSTERED ([salekey] ASC),
    CONSTRAINT [FK_factSales_dimGeography_GeographyKey_1] FOREIGN KEY ([GeographyKey]) REFERENCES [Dim].[dimGeography] ([GeographyKey]),
    CONSTRAINT [FK_factSales_dimProduct_ProductKey_1] FOREIGN KEY ([productKey]) REFERENCES [Dim].[dimProduct] ([ProductKey])
);

