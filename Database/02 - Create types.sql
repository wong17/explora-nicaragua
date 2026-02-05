USE NicaraguaTourismDB;
GO

-- Tipo para pasar lista de Imágenes
IF TYPE_ID (N'Type_DestinationImageInput') IS NOT NULL 
	DROP TYPE Type_DestinationImageInput;
GO
CREATE TYPE Type_DestinationImageInput AS TABLE
(
	ImageUrl NVARCHAR(500),
    IsCover BIT,
    AltText NVARCHAR(100)
)
GO

-- Tipo para pasar lista de Actividades
IF TYPE_ID (N'Type_ActivityInput') IS NOT NULL 
	DROP TYPE Type_ActivityInput;
GO
CREATE TYPE Type_ActivityInput AS TABLE
(
	ActivityName NVARCHAR(100),
    IconName NVARCHAR(50)
)
GO