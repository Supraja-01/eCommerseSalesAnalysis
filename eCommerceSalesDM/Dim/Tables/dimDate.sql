CREATE TABLE [Dim].[dimDate] (
    [dateKey]       INT          NOT NULL,
    [fullDate]      DATE         NULL,
    [saleYear]      SMALLINT     NULL,
    [saleMonth]     SMALLINT     NULL,
    [saleMonthName] VARCHAR (20) NULL,
    PRIMARY KEY CLUSTERED ([dateKey] ASC)
);

