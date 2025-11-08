CREATE TABLE [Sales].[ListOfOrders] (
    [OrderID]      VARCHAR (10) NOT NULL,
    [OrderDate]    DATE         NOT NULL,
    [CustomerName] VARCHAR (50) NOT NULL,
    [State]        VARCHAR (30) NULL,
    [City]         VARCHAR (30) NULL,
    PRIMARY KEY CLUSTERED ([OrderID] ASC)
);

