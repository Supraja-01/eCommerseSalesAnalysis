CREATE TABLE [Dim].[dimGeography] (
    [GeographyKey]     INT          NOT NULL,
    [GeographyHashKey] CHAR (32)    NULL,
    [State]            VARCHAR (50) NULL,
    [City]             VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([GeographyKey] ASC)
);

