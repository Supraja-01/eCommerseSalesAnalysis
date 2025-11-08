CREATE TABLE [dbo].[DimCustomer] (
    [CustomerKey]  INT          NOT NULL,
    [CustomerName] VARCHAR (50) NULL,
    [State]        VARCHAR (20) NULL,
    [City]         VARCHAR (30) NULL,
    [HashKey]      CHAR (32)    NULL,
    PRIMARY KEY CLUSTERED ([CustomerKey] ASC)
);

