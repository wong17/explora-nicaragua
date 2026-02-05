USE NicaraguaTourismDB;
GO

-- REGISTRAR USUARIO (Create)
CREATE OR ALTER PROCEDURE uspRegisterUser (
    @FullName NVARCHAR(100),
    @Email NVARCHAR(100),
    @Password NVARCHAR(255), -- Ya viene encriptada desde la API
    @RoleId INT
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @IsSuccess INT = 0;
    DECLARE @Message NVARCHAR(255) = '';
    DECLARE @Result INT = 0;

    -- VALIDACIONES OBLIGATORIAS
    IF @FullName IS NULL OR RTRIM(@FullName) = ''
    BEGIN
        SELECT 1 AS IsSuccess, 'El nombre completo es obligatorio.' AS [Message], 0 AS Result;
        RETURN;
    END

    IF @Email IS NULL OR RTRIM(@Email) = ''
    BEGIN
        SELECT 1 AS IsSuccess, 'El correo electrónico es obligatorio.' AS [Message], 0 AS Result;
        RETURN;
    END

    IF @Password IS NULL OR RTRIM(@Password) = ''
    BEGIN
        SELECT 1 AS IsSuccess, 'La contraseña es obligatoria.' AS [Message], 0 AS Result;
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM [Role] WHERE RoleId = @RoleId)
    BEGIN
        SELECT 1 AS IsSuccess, 'El Rol seleccionado no es válido.' AS [Message], 0 AS Result;
        RETURN;
    END

    -- VALIDAR DUPLICADOS (Email único)
    IF EXISTS (SELECT 1 FROM [User] WHERE Email = @Email)
    BEGIN
        SELECT 2 AS IsSuccess, 'El correo electrónico ya está registrado.' AS [Message], 0 AS Result;
        RETURN;
    END

    -- INSERTAR
    BEGIN TRY
        INSERT INTO [User] (FullName, Email, [Password], RoleId)
        VALUES (@FullName, @Email, @Password, @RoleId);

        SET @Result = SCOPE_IDENTITY();
        SELECT 0 AS IsSuccess, 'Usuario registrado exitosamente.' AS [Message], @Result AS Result;
    END TRY
    BEGIN CATCH
        SELECT 3 AS IsSuccess, ERROR_MESSAGE() AS [Message], 0 AS Result;
    END CATCH
END
GO

-- EDITAR USUARIO (Update)
CREATE OR ALTER PROCEDURE uspEditUser (
    @UserId INT,
    @FullName NVARCHAR(100),
    @Email NVARCHAR(100),
    @RoleId INT
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @IsSuccess INT = 0;
    DECLARE @Message NVARCHAR(255) = '';

    -- Validar existencia
    IF NOT EXISTS (SELECT 1 FROM [User] WHERE UserId = @UserId)
    BEGIN
        SELECT 2 AS IsSuccess, 'El usuario no existe.' AS [Message], 0 AS Result;
        RETURN;
    END

    -- Validar que el nuevo email no pertenezca a OTRO usuario
    IF EXISTS (SELECT 1 FROM [User] WHERE Email = @Email AND UserId <> @UserId)
    BEGIN
        SELECT 2 AS IsSuccess, 'El correo ya está en uso por otro usuario.' AS [Message], 0 AS Result;
        RETURN;
    END

    BEGIN TRY
        UPDATE [User]
        SET 
            FullName = @FullName,
            Email = @Email,
            RoleId = @RoleId
        WHERE UserId = @UserId;

        SELECT 0 AS IsSuccess, 'Usuario actualizado correctamente.' AS [Message], @UserId AS Result;
    END TRY
    BEGIN CATCH
        SELECT 3 AS IsSuccess, ERROR_MESSAGE() AS [Message], 0 AS Result;
    END CATCH
END
GO

-- OBTENER USUARIOS (Get)
CREATE OR ALTER PROCEDURE uspGetUsers (
    @UserId INT = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    IF @UserId IS NOT NULL
    BEGIN
        SELECT 
            u.UserId,
            u.FullName,
            u.Email,
            u.RoleId,
            r.RoleName,
            u.CreatedAt
        FROM [User] u
        INNER JOIN [Role] r ON u.RoleId = r.RoleId
        WHERE u.UserId = @UserId;
    END
    ELSE
    BEGIN
        SELECT 
            u.UserId,
            u.FullName,
            u.Email,
            u.RoleId,
            r.RoleName,
            u.CreatedAt
        FROM [User] u
        INNER JOIN [Role] r ON u.RoleId = r.RoleId
        ORDER BY u.FullName ASC
        FOR JSON PATH, INCLUDE_NULL_VALUES;
    END
END
GO

-- ELIMINAR USUARIO (Delete)
CREATE OR ALTER PROCEDURE uspDeleteUser (
    @UserId INT,
    @IsSuccess INT OUTPUT,
    @Message NVARCHAR(255) OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        DELETE FROM [User] WHERE UserId = @UserId;

        IF @@ROWCOUNT = 0
        BEGIN
            SET @IsSuccess = 2; SET @Message = 'El usuario no existe.';
        END
        else
        BEGIN
            SET @IsSuccess = 0; SET @Message = 'Usuario eliminado correctamente.';
        END
        
        SELECT @IsSuccess AS IsSuccess, @Message AS [Message];
    END TRY
    BEGIN CATCH
        SET @IsSuccess = 3; SET @Message = ERROR_MESSAGE();
        SELECT @IsSuccess AS IsSuccess, @Message AS [Message];
    END CATCH
END
GO

-- LOGIN DE USUARIO (Validar Credenciales)
CREATE OR ALTER PROCEDURE uspLoginUser (
    @Email NVARCHAR(100),
    @Password NVARCHAR(255)
)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @IsSuccess INT = 0;
    DECLARE @Message NVARCHAR(255) = '';
    DECLARE @UserId INT = 0;
    DECLARE @FullName NVARCHAR(100) = '';

    -- Buscamos ID y Nombre si coinciden credenciales
    SELECT TOP 1 
        @UserId = UserId, 
        @FullName = FullName
    FROM [User] 
    WHERE Email = @Email AND [Password] = @Password;

    --
    IF @UserId > 0
    BEGIN
        SET @IsSuccess = 0;
        SET @Message = 'Bienvenido, ' + @FullName + '.';
        
        --
        SELECT @IsSuccess AS IsSuccess, @Message AS [Message], @UserId AS [Result];
    END
    ELSE
    BEGIN
        SET @IsSuccess = 1;
        SET @Message = 'El correo o la contraseña no son correctos.';
        
        SELECT @IsSuccess AS IsSuccess, @Message AS [Message], 0 AS [Result];
    END
END
GO

-- Obtener usuario por Email (Para Login interno)
CREATE OR ALTER PROCEDURE uspGetUserByEmail (
    @Email NVARCHAR(100)
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 1
        UserId,
        FullName,
        Email,
        [Password],
        RoleId,
        CreatedAt
    FROM [User]
    WHERE Email = @Email;
END
GO