USE NicaraguaTourismDB
GO

-- Registrar nuevo destino turístico (y sus detalles)
CREATE OR ALTER PROCEDURE uspRegisterDestination (
    @Json NVARCHAR(MAX),
    @CreatedBy INT
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @IsSuccess INT = 0;
    DECLARE @Message NVARCHAR(255) = '';
    DECLARE @Result INT = 0;

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
            ROLLBACK TRAN; 
            SELECT @IsSuccess AS IsSuccess, @Message AS [Message], 0 AS Result;
            RETURN;
        END

        -- Insertar Imágenes
        EXEC uspInsertDestinationImagesInternal @NewId, @CreatedBy, @ImagesTVP, @IsSuccess OUTPUT, @Message OUTPUT;
        IF @IsSuccess <> 0
        BEGIN
            ROLLBACK TRAN; 
            SELECT @IsSuccess AS IsSuccess, @Message AS [Message], 0 AS Result;
            RETURN;
        END

        -- Insertar Actividades
        EXEC uspInsertActivitiesInternal @NewId, @CreatedBy, @ActivitiesTVP, @IsSuccess OUTPUT, @Message OUTPUT;
        IF @IsSuccess <> 0
        BEGIN
            ROLLBACK TRAN; 
            SELECT @IsSuccess AS IsSuccess, @Message AS [Message], 0 AS Result;
            RETURN;
        END

        COMMIT TRAN;
        SELECT 0 AS IsSuccess, 'Destino registrado correctamente.' AS [Message], @NewId AS Result;

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 
            ROLLBACK TRAN;
        
        SELECT 3 AS IsSuccess, ERROR_MESSAGE() AS [Message], 0 AS Result;
    END CATCH
END
GO

-- Editar destino turístico (y sus detalles)
CREATE OR ALTER PROCEDURE uspEditDestination (
    @Json NVARCHAR(MAX),
    @ModifiedBy INT
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @IsSuccess INT = 0;
    DECLARE @Message NVARCHAR(255) = '';
    DECLARE @Result INT = 0;

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
            ROLLBACK TRAN; 
            SELECT @IsSuccess AS IsSuccess, @Message AS [Message], 0 AS Result;
            RETURN;
        END

        -- Limpiar Detalles Antiguos
        EXEC uspClearDestinationDetailsInternal @DestId, @IsSuccess OUTPUT, @Message OUTPUT;
        IF @IsSuccess <> 0
        BEGIN
            ROLLBACK TRAN; 
            SELECT @IsSuccess AS IsSuccess, @Message AS [Message], 0 AS Result;
            RETURN;
        END

        -- Insertar Nuevos Detalles
        EXEC uspInsertDestinationImagesInternal @DestId, @ModifiedBy, @ImagesTVP, @IsSuccess OUTPUT, @Message OUTPUT;
        EXEC uspInsertActivitiesInternal @DestId, @ModifiedBy, @ActivitiesTVP, @IsSuccess OUTPUT, @Message OUTPUT;

        COMMIT TRAN;
        SELECT 0 AS IsSuccess, 'Destino actualizado correctamente.' AS [Message], @DestId AS Result;

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 
            ROLLBACK TRAN;
        
        SELECT 3 AS IsSuccess, ERROR_MESSAGE() AS [Message], 0 AS Result;
    END CATCH
END
GO

-- Eliminar destino turístico (y sus detalles)
CREATE OR ALTER PROCEDURE uspDeleteDestination (
    @DestinationId INT
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @IsSuccess INT = 0;
    DECLARE @Message NVARCHAR(255) = '';

    BEGIN TRY
        DELETE FROM Destination WHERE DestinationId = @DestinationId;
        
        IF @@ROWCOUNT = 0
        BEGIN
             SELECT 2 AS IsSuccess, 'El destino no existe.' AS [Message], 0 AS Result;
        END
        ELSE
        BEGIN
             SELECT 0 AS IsSuccess, 'Destino eliminado exitosamente.' AS [Message], 0 AS Result;
        END
    END TRY
    BEGIN CATCH
        SELECT 3 AS IsSuccess, ERROR_MESSAGE() AS [Message], 0 AS Result;
    END CATCH
END
GO

-- Obtener destinos turísticos
CREATE OR ALTER PROCEDURE uspGetDestinations (
    @DestinationId INT = NULL,
    @PageNumber INT = NULL,
    @PageSize INT = NULL
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
            
            -- Imágenes
            JSON_QUERY((
                SELECT ImageUrl, IsCover, AltText
                FROM DestinationImage di
                WHERE di.DestinationId = d.DestinationId
                FOR JSON PATH
            )) AS Images,

            -- Actividades
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
        DECLARE @Offset INT, @TotalRecords INT;

        IF @PageNumber IS NULL OR @PageNumber <= 0 SET @PageNumber = 1;
        IF @PageSize IS NULL OR @PageSize <= 0 SET @PageSize = 10;

        SET @Offset = (@PageNumber - 1) * @PageSize;
        SELECT @TotalRecords = COUNT(*) FROM Destination;
        SELECT
            @TotalRecords AS TotalRecords,
            (
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
                    
                    -- Imágenes
                    JSON_QUERY((
                        SELECT ImageUrl, IsCover, AltText
                        FROM DestinationImage di
                        WHERE di.DestinationId = d.DestinationId
                        FOR JSON PATH
                    )) AS Images,

                    -- Actividades
                    JSON_QUERY((
                        SELECT ActivityName, IconName
                        FROM Activity a
                        WHERE a.DestinationId = d.DestinationId
                        FOR JSON PATH
                    )) AS Activities

                FROM Destination d
                ORDER BY d.Name ASC
                OFFSET @Offset ROWS
                FETCH NEXT @PageSize ROWS ONLY
                FOR JSON PATH, INCLUDE_NULL_VALUES
            ) AS Data
        FOR JSON PATH, WITHOUT_ARRAY_WRAPPER, INCLUDE_NULL_VALUES;
    END
END
GO