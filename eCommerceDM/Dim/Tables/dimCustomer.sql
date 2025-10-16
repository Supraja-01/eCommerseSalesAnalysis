CREATE TABLE [Dim].[dimCustomer] (
    [customerKey]  INT           IDENTITY (601, 1) NOT NULL,
    [customerName] VARCHAR (100) NULL,
    [State]        VARCHAR (50)  NULL,
    [City]         VARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([customerKey] ASC)
);

