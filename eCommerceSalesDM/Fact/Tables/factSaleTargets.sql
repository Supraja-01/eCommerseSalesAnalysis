CREATE TABLE [Fact].[factSaleTargets] (
    [targetKey]     INT       NOT NULL,
    [targetHashkey] CHAR (32) NULL,
    [dateKey]       INT       NOT NULL,
    [ProductKey]    INT       NOT NULL,
    [TotalTarget]   INT       NOT NULL,
    PRIMARY KEY CLUSTERED ([targetKey] ASC),
    CONSTRAINT [FK_factSaleTargets_dimDate_dateKey_1] FOREIGN KEY ([dateKey]) REFERENCES [Dim].[dimDate] ([dateKey]),
    CONSTRAINT [FK_factSaleTargets_dimProduct_ProductKey_1] FOREIGN KEY ([ProductKey]) REFERENCES [Dim].[dimProduct] ([ProductKey])
);

