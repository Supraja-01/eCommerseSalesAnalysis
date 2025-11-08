CREATE TABLE [dbo].[DimDate] (
    [DateKey]       INT          NOT NULL,
    [FullDate]      DATE         NULL,
    [SaleYear]      SMALLINT     NULL,
    [SaleMonth]     SMALLINT     NULL,
    [SaleMonthName] VARCHAR (20) NULL,
    PRIMARY KEY CLUSTERED ([DateKey] ASC)
);

