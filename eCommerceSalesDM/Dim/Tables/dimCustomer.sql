CREATE TABLE [Dim].[dimCustomer] (
    [customerKey]     INT           NOT NULL,
    [customerhashKey] CHAR (32)     NULL,
    [customerName]    VARCHAR (100) NULL,
    [State]           VARCHAR (50)  NULL,
    [City]            VARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([customerKey] ASC)
);

