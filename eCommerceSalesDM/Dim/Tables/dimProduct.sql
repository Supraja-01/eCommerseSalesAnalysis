CREATE TABLE [Dim].[dimProduct] (
    [ProductKey]     INT           NOT NULL,
    [ProductHashKey] CHAR (32)     NULL,
    [Category]       VARCHAR (50)  NULL,
    [subCategory]    VARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([ProductKey] ASC)
);

