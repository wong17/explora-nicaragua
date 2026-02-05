-- Crear la base de datos para la aplicación de turismo en Nicaragua
CREATE DATABASE NicaraguaTourismDB;
GO

-- Seleccionar la base de datos recién creada
USE NicaraguaTourismDB;
GO

-- Tabla de Roles (Admin, Visitante)
CREATE TABLE [Role] (
    RoleId INT IDENTITY(1,1),
    RoleName NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_Role PRIMARY KEY (RoleId),
    CONSTRAINT AK_Role_RoleName UNIQUE (RoleName)
);
GO

-- Tabla de Usuarios
CREATE TABLE [User] (
    UserId INT IDENTITY(1,1) NOT NULL,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    [Password] NVARCHAR(255) NOT NULL,
    RoleId INT NOT NULL,
    CreatedAt DATETIME CONSTRAINT DF_User_CreatedAt DEFAULT GETDATE(),
    CONSTRAINT PK_User_UserId PRIMARY KEY (UserId),
    CONSTRAINT AK_User_Email UNIQUE (Email),
    CONSTRAINT FK_User_Role_RoleId FOREIGN KEY (RoleId) REFERENCES [Role](RoleId)
);
GO

-- Tabla Principal de Destinos Turísticos
CREATE TABLE Destination (
    DestinationId INT IDENTITY(1,1) NOT NULL,
    AdminId INT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    ShortDescription NVARCHAR(300) NOT NULL,
    LongDescription NVARCHAR(MAX),
    [Location] NVARCHAR(200),
    Latitude DECIMAL(9, 6),
    Longitude DECIMAL(9, 6),
    AverageWeather NVARCHAR(50),
    AccessDifficulty NVARCHAR(50),
    CreatedAt DATETIME CONSTRAINT DF_Destination_CreatedAt DEFAULT GETDATE(),
    CONSTRAINT PK_Destination_DestinationId PRIMARY KEY (DestinationId),
    CONSTRAINT FK_Destination_User_AdminId FOREIGN KEY (AdminId) REFERENCES [User](UserId)
);
GO

-- Tabla de Imágenes
CREATE TABLE DestinationImage (
    ImageId INT IDENTITY(1,1) NOT NULL,
    DestinationId INT NOT NULL,
    AdminId INT NOT NULL,
    ImageUrl NVARCHAR(500) NOT NULL,
    IsCover BIT DEFAULT 0,
    AltText NVARCHAR(100),
    UploadedAt DATETIME CONSTRAINT DF_DestinationImage_UploadedAt DEFAULT GETDATE(),
    CONSTRAINT PK_DestinationImage_ImageId PRIMARY KEY (ImageId),
    CONSTRAINT FK_DestinationImage_Destination_DestinationId FOREIGN KEY (DestinationId) REFERENCES Destination(DestinationId) ON DELETE CASCADE,
    CONSTRAINT FK_DestinationImage_User_AdminId FOREIGN KEY (AdminId) REFERENCES [User](UserId)
);
GO

-- Tabla de Actividades (Senderismo, Surf, etc.)
CREATE TABLE Activity (
    ActivityId INT IDENTITY(1,1) NOT NULL,
    DestinationId INT NOT NULL,
    AdminId INT NOT NULL,
    ActivityName NVARCHAR(100) NOT NULL,
    IconName NVARCHAR(50),
    CONSTRAINT PK_Activity_ActivityId PRIMARY KEY (ActivityId),
    CONSTRAINT FK_Activity_Destination_DestinationId FOREIGN KEY (DestinationId) REFERENCES Destination(DestinationId) ON DELETE CASCADE,
    CONSTRAINT FK_Activity_User_AdminId FOREIGN KEY (AdminId) REFERENCES [User](UserId)
);
GO

-- Tabla de Favoritos (Wishlist)
CREATE TABLE Favorite (
    FavoriteId INT IDENTITY(1,1) NOT NULL,
    UserId INT NOT NULL,
    DestinationId INT NOT NULL,
    AddedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT PK_Favorite_FavoriteId PRIMARY KEY (FavoriteId),
    CONSTRAINT AK_Favorite_UserId_DestinationId UNIQUE (UserId, DestinationId),
    CONSTRAINT FK_Favorite_User_UserId FOREIGN KEY (UserId) REFERENCES [User](UserId),
    CONSTRAINT FK_Favorite_Destination_DestinationId FOREIGN KEY (DestinationId) REFERENCES Destination(DestinationId) ON DELETE CASCADE
);
GO