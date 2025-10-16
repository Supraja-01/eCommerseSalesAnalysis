CREATE TABLE [Dim].[dimGeography] (
    [GeographyKey] INT          IDENTITY (701, 1) NOT NULL,
    [State]        VARCHAR (50) NULL,
    [City]         VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([GeographyKey] ASC)
);

