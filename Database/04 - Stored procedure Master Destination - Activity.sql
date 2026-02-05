USE NicaraguaTourismDB
GO

-- Registrar nuevo destino turístico (y sus detalles)
CREATE OR ALTER PROCEDURE uspRegisterDestination (
    @Json NVARCHAR(MAX),
    @CreatedBy INT, -- El ID del Admin
    @IsSuccess INT OUTPUT,
    @Message NVARCHAR(255) OUTPUT,
    @Result INT OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;
    SET @IsSuccess = 0; SET @Message = ''; SET @Result = 0;

    --
    DECLARE @Name NVARCHAR(100), @ShortDesc NVARCHAR(300), @LongDesc NVARCHAR(MAX),
            @Loc NVARCHAR(200), @Lat DECIMAL(9,6), @Lng DECIMAL(9,6),
            @Weather NVARCHAR(50), @Diff NVARCHAR(50);

    SELECT 
        @Name = [Name],
        @ShortDesc = ShortDescription,
        @LongDesc = LongDescription,
        @Loc = [Location],
        @Lat = Latitude,
        @Lng = Longitude,
        @Weather = AverageWeather,
        @Diff = AccessDifficulty
    FROM OPENJSON(@Json)
    WITH (
        [Name] NVARCHAR(100), ShortDescription NVARCHAR(300), LongDescription NVARCHAR(MAX),
        [Location] NVARCHAR(200), Latitude DECIMAL(9,6), Longitude DECIMAL(9,6),
        AverageWeather NVARCHAR(50), AccessDifficulty NVARCHAR(50)
    );

    --
    DECLARE @ImagesTVP Type_DestinationImageInput;
    INSERT INTO @ImagesTVP (ImageUrl, IsCover, AltText)
    SELECT ImageUrl, IsCover, AltText
    FROM OPENJSON(@Json) WITH (Images NVARCHAR(MAX) AS JSON)
    CROSS APPLY OPENJSON(Images) WITH (ImageUrl NVARCHAR(500), IsCover BIT, AltText NVARCHAR(100));

    DECLARE @ActivitiesTVP Type_ActivityInput;
    INSERT INTO @ActivitiesTVP (ActivityName, IconName)
    SELECT ActivityName, IconName
    FROM OPENJSON(@Json) WITH (Activities NVARCHAR(MAX) AS JSON)
    CROSS APPLY OPENJSON(Activities) WITH (ActivityName NVARCHAR(100), IconName NVARCHAR(50));

    --
    DECLARE @NewId INT = 0;

    IF @@TRANCOUNT = 0 
        BEGIN TRAN;

    BEGIN TRY
        -- Insertar Destino
        EXEC uspInsertDestinationInternal 
            @CreatedBy, @Name, @ShortDesc, @LongDesc, @Loc, @Lat, @Lng, @Weather, @Diff,
            @IsSuccess OUTPUT, @Message OUTPUT, @NewId OUTPUT;

        IF @IsSuccess <> 0
        BEGIN
            ROLLBACK TRAN; SET @Result = 0; RETURN;
        END

        -- Insertar Imágenes
        EXEC uspInsertDestinationImagesInternal @NewId, @CreatedBy, @ImagesTVP, @IsSuccess OUTPUT, @Message OUTPUT;
        IF @IsSuccess <> 0
        BEGIN
            ROLLBACK TRAN; SET @Result = 0; RETURN;
        END

        -- Insertar Actividades
        EXEC uspInsertActivitiesInternal @NewId, @CreatedBy, @ActivitiesTVP, @IsSuccess OUTPUT, @Message OUTPUT;
        IF @IsSuccess <> 0
        BEGIN
            ROLLBACK TRAN; SET @Result = 0; RETURN;
        END

        COMMIT TRAN;
        SET @IsSuccess = 0; SET @Message = 'Destino registrado correctamente.'; SET @Result = @NewId;
        
        --
        SELECT @IsSuccess AS IsSuccess, @Message AS [Message], @Result AS Result;

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 
            ROLLBACK TRAN;
        
        SET @IsSuccess = 3; SET @Message = ERROR_MESSAGE(); SET @Result = 0;
        
        SELECT @IsSuccess AS IsSuccess, @Message AS [Message], @Result AS Result;
    END CATCH
END
GO

-- Editar destino turístico (y sus detalles)
CREATE OR ALTER PROCEDURE uspEditDestination (
    @Json NVARCHAR(MAX),
    @ModifiedBy INT, -- Admin que edita
    @IsSuccess INT OUTPUT,
    @Message NVARCHAR(255) OUTPUT,
    @Result INT OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;
    SET @IsSuccess = 0; SET @Message = ''; SET @Result = 0;

    --
    DECLARE @DestId INT;
    DECLARE @Name NVARCHAR(100), @ShortDesc NVARCHAR(300), @LongDesc NVARCHAR(MAX),
            @Loc NVARCHAR(200), @Lat DECIMAL(9,6), @Lng DECIMAL(9,6),
            @Weather NVARCHAR(50), @Diff NVARCHAR(50);

    SELECT 
        @DestId = DestinationId,
        @Name = [Name],
        @ShortDesc = ShortDescription,
        @LongDesc = LongDescription,
        @Loc = [Location],
        @Lat = Latitude,
        @Lng = Longitude,
        @Weather = AverageWeather,
        @Diff = AccessDifficulty
    FROM OPENJSON(@Json)
    WITH (
        DestinationId INT,
        [Name] NVARCHAR(100), ShortDescription NVARCHAR(300), LongDescription NVARCHAR(MAX),
        [Location] NVARCHAR(200), Latitude DECIMAL(9,6), Longitude DECIMAL(9,6),
        AverageWeather NVARCHAR(50), AccessDifficulty NVARCHAR(50)
    );

    --
    DECLARE @ImagesTVP Type_DestinationImageInput;
    INSERT INTO @ImagesTVP (ImageUrl, IsCover, AltText)
    SELECT ImageUrl, IsCover, AltText
    FROM OPENJSON(@Json) WITH (Images NVARCHAR(MAX) AS JSON)
    CROSS APPLY OPENJSON(Images) WITH (ImageUrl NVARCHAR(500), IsCover BIT, AltText NVARCHAR(100));

    DECLARE @ActivitiesTVP Type_ActivityInput;
    INSERT INTO @ActivitiesTVP (ActivityName, IconName)
    SELECT ActivityName, IconName
    FROM OPENJSON(@Json) WITH (Activities NVARCHAR(MAX) AS JSON)
    CROSS APPLY OPENJSON(Activities) WITH (ActivityName NVARCHAR(100), IconName NVARCHAR(50));

    --
    IF @@TRANCOUNT = 0 
        BEGIN TRAN;

    BEGIN TRY
        -- Actualizar Datos Base
        EXEC uspUpdateDestinationInternal 
            @DestId, @ModifiedBy, @Name, @ShortDesc, @LongDesc, @Loc, @Lat, @Lng, @Weather, @Diff,
            @IsSuccess OUTPUT, @Message OUTPUT;
        
        IF @IsSuccess <> 0
        BEGIN
            ROLLBACK TRAN; SET @Result = 0; RETURN;
        END

        -- Limpiar Detalles Antiguos
        EXEC uspClearDestinationDetailsInternal @DestId, @IsSuccess OUTPUT, @Message OUTPUT;
        IF @IsSuccess <> 0
        BEGIN
            ROLLBACK TRAN; SET @Result = 0; RETURN;
        END

        -- Insertar Nuevos Detalles
        EXEC uspInsertDestinationImagesInternal @DestId, @ModifiedBy, @ImagesTVP, @IsSuccess OUTPUT, @Message OUTPUT;
        EXEC uspInsertActivitiesInternal @DestId, @ModifiedBy, @ActivitiesTVP, @IsSuccess OUTPUT, @Message OUTPUT;

        COMMIT TRAN;
        SET @IsSuccess = 0; SET @Message = 'Destino actualizado correctamente.'; SET @Result = @DestId;
        
        SELECT @IsSuccess AS IsSuccess, @Message AS [Message], @Result AS Result;

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 
            ROLLBACK TRAN;
        
        SET @IsSuccess = 3; SET @Message = ERROR_MESSAGE(); SET @Result = 0;

        SELECT @IsSuccess AS IsSuccess, @Message AS [Message], @Result AS Result;
    END CATCH
END
GO

-- Eliminar destino turístico (y sus detalles)
CREATE OR ALTER PROCEDURE uspDeleteDestination (
    @DestinationId INT,
    @IsSuccess INT OUTPUT,
    @Message NVARCHAR(255) OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;
    SET @IsSuccess = 0; SET @Message = '';

    BEGIN TRY
        DELETE FROM Destination WHERE DestinationId = @DestinationId;
        
        IF @@ROWCOUNT = 0
        BEGIN
             SET @IsSuccess = 2; SET @Message = 'El destino no existe.';
        END
        ELSE
        BEGIN
             SET @IsSuccess = 0; SET @Message = 'Destino eliminado (y sus dependencias).';
        END
        
        -- 
        SELECT @IsSuccess AS IsSuccess, @Message AS [Message];
    END TRY
    BEGIN CATCH
        SET @IsSuccess = 3; SET @Message = ERROR_MESSAGE();
        SELECT @IsSuccess AS IsSuccess, @Message AS [Message];
    END CATCH
END
GO

-- Obtener destinos turísticos
CREATE OR ALTER PROCEDURE uspGetDestinations (
    @DestinationId INT = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    -- 
    IF @DestinationId IS NOT NULL
    BEGIN
        SELECT 
            d.DestinationId,
            d.[Name],
            d.ShortDescription,
            d.LongDescription,
            d.[Location],
            d.Latitude,
            d.Longitude,
            d.AverageWeather,
            d.AccessDifficulty,
            
            JSON_QUERY((
                SELECT ImageUrl, IsCover, AltText
                FROM DestinationImage di
                WHERE di.DestinationId = d.DestinationId
                FOR JSON PATH
            )) AS Images,

            JSON_QUERY((
                SELECT ActivityName, IconName
                FROM Activity a
                WHERE a.DestinationId = d.DestinationId
                FOR JSON PATH
            )) AS Activities

        FROM Destination d
        WHERE d.DestinationId = @DestinationId
        FOR JSON PATH, INCLUDE_NULL_VALUES, WITHOUT_ARRAY_WRAPPER;
    END
    -- 
    ELSE
    BEGIN
        SELECT 
            d.DestinationId,
            d.[Name],
            d.ShortDescription,
            d.LongDescription,
            d.[Location],
            d.Latitude,
            d.Longitude,
            d.AverageWeather,
            d.AccessDifficulty,
            
            JSON_QUERY((
                SELECT ImageUrl, IsCover, AltText
                FROM DestinationImage di
                WHERE di.DestinationId = d.DestinationId
                FOR JSON PATH
            )) AS Images,

            JSON_QUERY((
                SELECT ActivityName, IconName
                FROM Activity a
                WHERE a.DestinationId = d.DestinationId
                FOR JSON PATH
            )) AS Activities

        FROM Destination d
        ORDER BY d.Name ASC
        FOR JSON PATH, INCLUDE_NULL_VALUES;
    END
END
GO