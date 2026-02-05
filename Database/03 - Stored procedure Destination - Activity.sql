USE NicaraguaTourismDB;
GO

-- INSERTAR CABECERA (Destination)
CREATE OR ALTER PROCEDURE uspInsertDestinationInternal (
    @AdminId INT,
    @Name NVARCHAR(100),
    @ShortDescription NVARCHAR(300),
    @LongDescription NVARCHAR(MAX),
    @Location NVARCHAR(200),
    @Latitude DECIMAL(9, 6),
    @Longitude DECIMAL(9, 6),
    @AverageWeather NVARCHAR(50),
    @AccessDifficulty NVARCHAR(50),
    
    @IsSuccess INT OUTPUT,
    @Message NVARCHAR(255) OUTPUT,
    @NewId INT OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;
    SET @IsSuccess = 0; SET @Message = ''; SET @NewId = 0;

    BEGIN TRY
        INSERT INTO Destination (
            AdminId, [Name], ShortDescription, LongDescription, [Location], 
            Latitude, Longitude, AverageWeather, AccessDifficulty
        )
        VALUES (
            @AdminId, @Name, @ShortDescription, @LongDescription, @Location,
            @Latitude, @Longitude, @AverageWeather, @AccessDifficulty
        );

        SET @NewId = SCOPE_IDENTITY();
        SET @IsSuccess = 0; SET @Message = 'Destino creado exitosamente.';
    END TRY
    BEGIN CATCH
        SET @IsSuccess = 3; SET @Message = ERROR_MESSAGE(); SET @NewId = 0;
    END CATCH
END
GO

-- ACTUALIZAR CABECERA (Destination)
CREATE OR ALTER PROCEDURE uspUpdateDestinationInternal (
    @DestinationId INT,
    @AdminId INT, -- Quien edita
    @Name NVARCHAR(100),
    @ShortDescription NVARCHAR(300),
    @LongDescription NVARCHAR(MAX),
    @Location NVARCHAR(200),
    @Latitude DECIMAL(9, 6),
    @Longitude DECIMAL(9, 6),
    @AverageWeather NVARCHAR(50),
    @AccessDifficulty NVARCHAR(50),
    
    @IsSuccess INT OUTPUT,
    @Message NVARCHAR(255) OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;
    SET @IsSuccess = 0; SET @Message = '';

    IF NOT EXISTS (SELECT 1 FROM Destination WHERE DestinationId = @DestinationId)
    BEGIN
        SET @IsSuccess = 2; SET @Message = 'El destino no existe.'; RETURN;
    END

    BEGIN TRY
        UPDATE Destination
        SET 
            AdminId = @AdminId,
            [Name] = @Name,
            ShortDescription = @ShortDescription,
            LongDescription = @LongDescription,
            [Location] = @Location,
            Latitude = @Latitude,
            Longitude = @Longitude,
            AverageWeather = @AverageWeather,
            AccessDifficulty = @AccessDifficulty
        WHERE DestinationId = @DestinationId;

        SET @IsSuccess = 0; SET @Message = 'Destino actualizado.';
    END TRY
    BEGIN CATCH
        SET @IsSuccess = 3; SET @Message = ERROR_MESSAGE();
    END CATCH
END
GO

-- INSERTAR IMÁGENES
CREATE OR ALTER PROCEDURE uspInsertDestinationImagesInternal (
    @DestinationId INT,
    @AdminId INT,
    @ImageList Type_DestinationImageInput READONLY,
    
    @IsSuccess INT OUTPUT,
    @Message NVARCHAR(255) OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;
    SET @IsSuccess = 0; SET @Message = '';

    IF NOT EXISTS (SELECT 1 FROM @ImageList)
    BEGIN
        SET @IsSuccess = 1;
        SET @Message = 'Es obligatorio agregar al menos una imagen para el destino.';
        RETURN; 
    END

    BEGIN TRY
        INSERT INTO DestinationImage (DestinationId, AdminId, ImageUrl, IsCover, AltText)
        SELECT @DestinationId, @AdminId, ImageUrl, IsCover, AltText
        FROM @ImageList;

        SET @IsSuccess = 0; SET @Message = 'Imágenes insertadas.';
    END TRY
    BEGIN CATCH
        SET @IsSuccess = 3; SET @Message = ERROR_MESSAGE();
    END CATCH
END
GO

-- INSERTAR ACTIVIDADES (Recibe TVP)
CREATE OR ALTER PROCEDURE uspInsertActivitiesInternal (
    @DestinationId INT,
    @AdminId INT,
    @ActivityList Type_ActivityInput READONLY,
    
    @IsSuccess INT OUTPUT,
    @Message NVARCHAR(255) OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;
    SET @IsSuccess = 0; SET @Message = '';

    IF NOT EXISTS (SELECT 1 FROM @ActivityList) RETURN;

    BEGIN TRY
        INSERT INTO Activity (DestinationId, AdminId, ActivityName, IconName)
        SELECT @DestinationId, @AdminId, ActivityName, IconName
        FROM @ActivityList;

        SET @IsSuccess = 0; SET @Message = 'Actividades insertadas.';
    END TRY
    BEGIN CATCH
        SET @IsSuccess = 3; SET @Message = ERROR_MESSAGE();
    END CATCH
END
GO

-- LIMPIAR DETALLES (Para Updates)
CREATE OR ALTER PROCEDURE uspClearDestinationDetailsInternal (
    @DestinationId INT,
    @IsSuccess INT OUTPUT,
    @Message NVARCHAR(255) OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;
    SET @IsSuccess = 0; SET @Message = '';

    BEGIN TRY
        DELETE FROM DestinationImage WHERE DestinationId = @DestinationId;
        DELETE FROM Activity WHERE DestinationId = @DestinationId;
        SET @IsSuccess = 0; SET @Message = 'Detalles limpiados.';
    END TRY
    BEGIN CATCH
        SET @IsSuccess = 3; SET @Message = ERROR_MESSAGE();
    END CATCH
END
GO