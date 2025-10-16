CREATE TABLE [Fact].[factSalesTarget] (
    [dateKey]    INT NOT NULL,
    [ProductKey] INT NOT NULL,
    [Target]     INT NOT NULL,
    CONSTRAINT [FK_factSalesTarget_dimDate_dateKey] FOREIGN KEY ([dateKey]) REFERENCES [Dim].[dimDate] ([dateKey]),
    CONSTRAINT [FK_factSalesTarget_dimProduct_ProductKey] FOREIGN KEY ([ProductKey]) REFERENCES [Dim].[dimProduct] ([ProductKey])
);

