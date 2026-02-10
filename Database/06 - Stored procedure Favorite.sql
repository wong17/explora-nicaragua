USE NicaraguaTourismDB;
GO

-- AGREGAR A FAVORITOS (Add to Wishlist)
CREATE OR ALTER PROCEDURE uspAddFavorite (
    @UserId INT,
    @DestinationId INT
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @IsSuccess INT = 0;
    DECLARE @Message NVARCHAR(255) = '';

    -- Validar que el usuario exista
    IF NOT EXISTS (SELECT 1 FROM [User] WHERE UserId = @UserId)
    BEGIN
        SELECT 2 AS IsSuccess, 'El usuario no existe.' AS [Message], 0 AS Result;
        RETURN;
    END

    -- Validar que el destino exista
    IF NOT EXISTS (SELECT 1 FROM Destination WHERE DestinationId = @DestinationId)
    BEGIN
        SELECT 2 AS IsSuccess, 'El destino no existe.' AS [Message], 0 AS Result;
        RETURN;
    END

    -- Validar si YA es favorito (Evitar duplicados)
    IF EXISTS (SELECT 1 FROM Favorite WHERE UserId = @UserId AND DestinationId = @DestinationId)
    BEGIN
        SELECT 1 AS IsSuccess, 'Este destino ya está en tus favoritos.' AS [Message], 0 AS Result;
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Favorite (UserId, DestinationId)
        VALUES (@UserId, @DestinationId);

        SELECT 0 AS IsSuccess, 'Agregado a favoritos correctamente.' AS [Message], 0 AS Result;
    END TRY
    BEGIN CATCH
        SELECT 3 AS IsSuccess, ERROR_MESSAGE() AS [Message], 0 AS Result;
    END CATCH
END
GO

-- ELIMINAR DE FAVORITOS (Remove from Wishlist)
CREATE OR ALTER PROCEDURE uspRemoveFavorite (
    @UserId INT,
    @DestinationId INT
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @IsSuccess INT = 0;
    DECLARE @Message NVARCHAR(255) = '';

    BEGIN TRY
        DELETE FROM Favorite 
        WHERE UserId = @UserId AND DestinationId = @DestinationId;

        IF @@ROWCOUNT = 0
        BEGIN
            SELECT 2 AS IsSuccess, 'El destino no estaba en tus favoritos.' AS [Message], 0 AS Result;
        END
        ELSE
        BEGIN
            SELECT 0 AS IsSuccess, 'Eliminado de favoritos.' AS [Message], 0 AS Result;
        END
    END TRY
    BEGIN CATCH
        SELECT 3 AS IsSuccess, ERROR_MESSAGE() AS [Message], 0 AS Result;
    END CATCH
END
GO

-- OBTENER MIS FAVORITOS (Get My Wishlist)
CREATE OR ALTER PROCEDURE uspGetUserFavorites (
    @UserId INT,
    @PageNumber INT = NULL,
    @PageSize INT = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Offset INT, @TotalRecords INT;

    IF @PageNumber IS NULL OR @PageNumber <= 0 SET @PageNumber = 1;
    IF @PageSize IS NULL OR @PageSize <= 0 SET @PageSize = 10;

    SET @Offset = (@PageNumber - 1) * @PageSize;

    SELECT @TotalRecords = COUNT(*) 
    FROM Favorite 
    WHERE UserId = @UserId;

    SELECT 
        @TotalRecords AS TotalRecords,
        JSON_QUERY(
            ISNULL(
                (
                    SELECT 
                        f.FavoriteId,
                        f.AddedAt,
                        
                        JSON_QUERY((
                            SELECT 
                                d.DestinationId,
                                d.[Name],
                                d.ShortDescription,
                                d.[Location],
                                d.AverageWeather,
                                d.AccessDifficulty,
                                (
                                    SELECT TOP 1 di.ImageUrl 
                                    FROM DestinationImage di 
                                    WHERE di.DestinationId = d.DestinationId AND di.IsCover = 1
                                ) AS CoverImage

                            FROM Destination d
                            WHERE d.DestinationId = f.DestinationId
                            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
                        )) AS Destination

                    FROM Favorite f
                    WHERE f.UserId = @UserId
                    ORDER BY f.AddedAt DESC -- Ordenar por más recientes
                    OFFSET @Offset ROWS 
                    FETCH NEXT @PageSize ROWS ONLY
                    FOR JSON PATH, INCLUDE_NULL_VALUES
                ),
                '[]' -- Si devuelve NULL (sin favoritos), forzamos un array vacío
            )
        ) AS Data
    FOR JSON PATH, WITHOUT_ARRAY_WRAPPER, INCLUDE_NULL_VALUES;
END
GO

-- VERIFICAR SI ES FAVORITO (Check Status)
-- Útil para saber si pintar el corazón de rojo o gris al entrar al detalle de un lugar.
CREATE OR ALTER PROCEDURE uspCheckIsFavorite (
    @UserId INT,
    @DestinationId INT
)
AS
BEGIN
    SET NOCOUNT ON;
    
    --
    IF EXISTS (SELECT 1 FROM Favorite WHERE UserId = @UserId AND DestinationId = @DestinationId)
        SELECT CAST(1 AS BIT) AS IsFavorite;
    ELSE
        SELECT CAST(0 AS BIT) AS IsFavorite;
END
GO