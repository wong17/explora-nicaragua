USE NicaraguaTourismDB;
GO

-- AGREGAR A FAVORITOS (Add to Wishlist)
CREATE OR ALTER PROCEDURE uspAddFavorite (
    @UserId INT,
    @DestinationId INT,
    @IsSuccess INT OUTPUT,
    @Message NVARCHAR(255) OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;
    SET @IsSuccess = 0; SET @Message = '';

    -- Validar que el usuario exista
    IF NOT EXISTS (SELECT 1 FROM [User] WHERE UserId = @UserId)
    BEGIN
        SET @IsSuccess = 2; SET @Message = 'El usuario no existe.'; 
        RETURN;
    END

    -- Validar que el destino exista
    IF NOT EXISTS (SELECT 1 FROM Destination WHERE DestinationId = @DestinationId)
    BEGIN
        SET @IsSuccess = 2; SET @Message = 'El destino no existe.'; 
        RETURN;
    END

    -- Validar si YA es favorito (Evitar duplicados)
    IF EXISTS (SELECT 1 FROM Favorite WHERE UserId = @UserId AND DestinationId = @DestinationId)
    BEGIN
        SET @IsSuccess = 1; SET @Message = 'Este destino ya está en tus favoritos.'; 
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Favorite (UserId, DestinationId)
        VALUES (@UserId, @DestinationId);

        SET @IsSuccess = 0; SET @Message = 'Agregado a favoritos correctamente.';
    END TRY
    BEGIN CATCH
        SET @IsSuccess = 3; SET @Message = ERROR_MESSAGE();
    END CATCH
END
GO

-- ELIMINAR DE FAVORITOS (Remove from Wishlist)
CREATE OR ALTER PROCEDURE uspRemoveFavorite (
    @UserId INT,
    @DestinationId INT,
    @IsSuccess INT OUTPUT,
    @Message NVARCHAR(255) OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;
    SET @IsSuccess = 0; SET @Message = '';

    BEGIN TRY
        DELETE FROM Favorite 
        WHERE UserId = @UserId AND DestinationId = @DestinationId;

        IF @@ROWCOUNT = 0
        BEGIN
            SET @IsSuccess = 2; SET @Message = 'El destino no estaba en tus favoritos.';
        END
        ELSE
        BEGIN
            SET @IsSuccess = 0; SET @Message = 'Eliminado de favoritos.';
        END
    END TRY
    BEGIN CATCH
        SET @IsSuccess = 3; SET @Message = ERROR_MESSAGE();
    END CATCH
END
GO

-- OBTENER MIS FAVORITOS (Get My Wishlist)
CREATE OR ALTER PROCEDURE uspGetUserFavorites (
    @UserId INT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        f.FavoriteId,
        f.AddedAt,
        
        -- Objeto Destino Completo (Anidado)
        JSON_QUERY((
            SELECT 
                d.DestinationId,
                d.[Name],
                d.ShortDescription,
                d.[Location],
                d.AverageWeather,
                d.AccessDifficulty,
                
                -- Foto de Portada (Solo traemos la que es IsCover = 1)
                (
                    SELECT TOP 1 ImageUrl 
                    FROM DestinationImage di 
                    WHERE di.DestinationId = d.DestinationId AND di.IsCover = 1
                ) AS CoverImage

            FROM Destination d
            WHERE d.DestinationId = f.DestinationId
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        )) AS Destination

    FROM Favorite f
    WHERE f.UserId = @UserId
    ORDER BY f.AddedAt DESC -- Los más recientes primero
    FOR JSON PATH;
END
GO

-- VERIFICAR SI ES FAVORITO (Check Status)
-- Útil para saber si pintar el corazón de rojo o gris al entrar al detalle de un lugar.
CREATE OR ALTER PROCEDURE uspCheckIsFavorite (
    @UserId INT,
    @DestinationId INT,
    @IsFavorite BIT OUTPUT -- 1 = Sí, 0 = No
)
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT 1 FROM Favorite WHERE UserId = @UserId AND DestinationId = @DestinationId)
        SET @IsFavorite = 1;
    ELSE
        SET @IsFavorite = 0;
        
    -- 
    SELECT @IsFavorite AS IsFavorite;
END
GO