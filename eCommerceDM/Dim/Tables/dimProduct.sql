CREATE TABLE [Dim].[dimProduct] (
    [ProductKey]  INT           IDENTITY (801, 1) NOT NULL,
    [Category]    VARCHAR (50)  NULL,
    [subCategory] VARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([ProductKey] ASC)
);

