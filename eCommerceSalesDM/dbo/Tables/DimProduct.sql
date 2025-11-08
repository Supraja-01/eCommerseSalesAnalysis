CREATE TABLE [dbo].[DimProduct] (
    [ProductKey]  INT           NOT NULL,
    [Category]    VARCHAR (50)  NULL,
    [SubCategory] VARCHAR (100) NULL,
    [HashKey]     CHAR (32)     NULL,
    PRIMARY KEY CLUSTERED ([ProductKey] ASC)
);

