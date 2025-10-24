CREATE TABLE [sales].[orderDetails] (
    [OrderID]     VARCHAR (10) NOT NULL,
    [Amount]      INT          NOT NULL,
    [Profit]      SMALLINT     NULL,
    [Quantity]    TINYINT      NOT NULL,
    [Category]    VARCHAR (20) NULL,
    [SubCategory] VARCHAR (30) NULL
);

