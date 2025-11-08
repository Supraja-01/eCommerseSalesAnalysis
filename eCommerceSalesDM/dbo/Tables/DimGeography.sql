CREATE TABLE [dbo].[DimGeography] (
    [GeographyKey] INT          NOT NULL,
    [State]        VARCHAR (20) NULL,
    [City]         VARCHAR (30) NULL,
    [HashKey]      CHAR (32)    NULL,
    PRIMARY KEY CLUSTERED ([GeographyKey] ASC)
);

