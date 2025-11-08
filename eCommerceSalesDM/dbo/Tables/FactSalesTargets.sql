CREATE TABLE [dbo].[FactSalesTargets] (
    [TargetKey]   INT       NOT NULL,
    [DateKey]     INT       NOT NULL,
    [ProductKey]  INT       NOT NULL,
    [SaleKey]     INT       NULL,
    [TotalTarget] INT       NOT NULL,
    [Hashkey]     CHAR (32) NULL,
    PRIMARY KEY CLUSTERED ([TargetKey] ASC),
    CONSTRAINT [FK_factSaleTargets_dimDate_dateKey_1] FOREIGN KEY ([DateKey]) REFERENCES [dbo].[DimDate] ([DateKey]),
    CONSTRAINT [FK_factSaleTargets_dimProduct_ProductKey_1] FOREIGN KEY ([ProductKey]) REFERENCES [dbo].[DimProduct] ([ProductKey]),
    CONSTRAINT [FK_factSaleTargets_FactSalesAnalysis_SaleKey_1] FOREIGN KEY ([SaleKey]) REFERENCES [dbo].[FactSalesAnalysis] ([Salekey])
);

