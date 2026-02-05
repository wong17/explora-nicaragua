USE [NicaraguaTourismDB];
GO

-- Insertar roles predeterminados si no existen
IF NOT EXISTS (SELECT 1 FROM [Role] WHERE RoleName = 'Admin')
    INSERT INTO [Role] (RoleName) VALUES ('Admin');

IF NOT EXISTS (SELECT 1 FROM [Role] WHERE RoleName = 'Visitor')
    INSERT INTO [Role] (RoleName) VALUES ('Visitor');
GO
