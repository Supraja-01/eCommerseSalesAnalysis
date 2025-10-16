CREATE TABLE [Fact].[factSales] (
    [saleKey]      INT          IDENTITY (1001, 1) NOT NULL,
    [orderId]      VARCHAR (10) NULL,
    [dateKey]      INT          NOT NULL,
    [customerKey]  INT          NOT NULL,
    [GeographyKey] INT          NOT NULL,
    [productKey]   INT          NOT NULL,
    [Amount]       INT          NULL,
    [Profit]       SMALLINT     NULL,
    [Quantity]     TINYINT      NULL,
    PRIMARY KEY CLUSTERED ([saleKey] ASC),
    CONSTRAINT [FK_factSales_dimCustomer_customerKey] FOREIGN KEY ([customerKey]) REFERENCES [Dim].[dimCustomer] ([customerKey]),
    CONSTRAINT [FK_factSales_dimDate_dateKey] FOREIGN KEY ([dateKey]) REFERENCES [Dim].[dimDate] ([dateKey]),
    CONSTRAINT [FK_factSales_dimGeography_GeographyKey] FOREIGN KEY ([GeographyKey]) REFERENCES [Dim].[dimGeography] ([GeographyKey]),
    CONSTRAINT [FK_factSales_dimProduct_ProductKey] FOREIGN KEY ([productKey]) REFERENCES [Dim].[dimProduct] ([ProductKey])
);

