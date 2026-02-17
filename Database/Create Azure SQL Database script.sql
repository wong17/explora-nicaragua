/****** Object:  UserDefinedTableType [dbo].[Type_ActivityInput]    Script Date: 2/16/2026 6:50:16 PM ******/
CREATE TYPE [dbo].[Type_ActivityInput] AS TABLE(
	[ActivityName] [nvarchar](100) NULL,
	[IconName] [nvarchar](50) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[Type_DestinationImageInput]    Script Date: 2/16/2026 6:50:16 PM ******/
CREATE TYPE [dbo].[Type_DestinationImageInput] AS TABLE(
	[ImageUrl] [nvarchar](500) NULL,
	[IsCover] [bit] NULL,
	[AltText] [nvarchar](100) NULL
)
GO
/****** Object:  Table [dbo].[Activity]    Script Date: 2/16/2026 6:50:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Activity](
	[ActivityId] [int] IDENTITY(1,1) NOT NULL,
	[DestinationId] [int] NOT NULL,
	[AdminId] [int] NOT NULL,
	[ActivityName] [nvarchar](100) NOT NULL,
	[IconName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Activity_ActivityId] PRIMARY KEY CLUSTERED 
(
	[ActivityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Destination]    Script Date: 2/16/2026 6:50:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Destination](
	[DestinationId] [int] IDENTITY(1,1) NOT NULL,
	[AdminId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[ShortDescription] [nvarchar](300) NOT NULL,
	[LongDescription] [nvarchar](max) NULL,
	[Location] [nvarchar](200) NULL,
	[Latitude] [decimal](9, 6) NULL,
	[Longitude] [decimal](9, 6) NULL,
	[AverageWeather] [nvarchar](50) NULL,
	[AccessDifficulty] [nvarchar](50) NULL,
	[CreatedAt] [datetime] NULL,
 CONSTRAINT [PK_Destination_DestinationId] PRIMARY KEY CLUSTERED 
(
	[DestinationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DestinationImage]    Script Date: 2/16/2026 6:50:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DestinationImage](
	[ImageId] [int] IDENTITY(1,1) NOT NULL,
	[DestinationId] [int] NOT NULL,
	[AdminId] [int] NOT NULL,
	[ImageUrl] [nvarchar](500) NOT NULL,
	[IsCover] [bit] NULL,
	[AltText] [nvarchar](100) NULL,
	[UploadedAt] [datetime] NULL,
 CONSTRAINT [PK_DestinationImage_ImageId] PRIMARY KEY CLUSTERED 
(
	[ImageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Favorite]    Script Date: 2/16/2026 6:50:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Favorite](
	[FavoriteId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[DestinationId] [int] NOT NULL,
	[AddedAt] [datetime] NULL,
 CONSTRAINT [PK_Favorite_FavoriteId] PRIMARY KEY CLUSTERED 
(
	[FavoriteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 2/16/2026 6:50:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 2/16/2026 6:50:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
	[RoleId] [int] NOT NULL,
	[CreatedAt] [datetime] NULL,
 CONSTRAINT [PK_User_UserId] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Activity] ON 
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (1, 1, 1, N'Volcano Boarding', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (2, 1, 1, N'Senderismo', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (3, 1, 1, N'Fotografía', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (4, 1, 1, N'Deportes Extremos', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (5, 2, 1, N'Surf', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (6, 2, 1, N'Vida Nocturna', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (7, 2, 1, N'Gastronomía', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (8, 2, 1, N'Miradores', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (9, 2, 1, N'Relajación', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (10, 3, 1, N'Natación', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (11, 3, 1, N'Avistamiento de Fauna', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (12, 3, 1, N'Ecoturismo', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (13, 3, 1, N'Relajación', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (14, 4, 1, N'Observación de lava', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (15, 4, 1, N'Senderismo', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (16, 4, 1, N'Fotografía nocturna', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (17, 5, 1, N'Nado y Kayak', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (18, 5, 1, N'Buceo', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (19, 5, 1, N'Relajación', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (20, 6, 1, N'Saltos de acantilado', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (21, 6, 1, N'Navegación', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (22, 6, 1, N'Caminata extrema', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (23, 7, 1, N'Paseo en lancha', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (24, 7, 1, N'Observación de aves', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (25, 7, 1, N'Tour histórico', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (26, 8, 1, N'Buceo con tanque', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (27, 8, 1, N'Esnórquel', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (28, 8, 1, N'Ciclismo y Caminata', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (29, 9, 1, N'Senderismo', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (30, 9, 1, N'Observación de flora', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (31, 9, 1, N'Tirolesa / Canopy', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (32, 10, 1, N'Compra de artesanías', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (33, 10, 1, N'Vistas panorámicas', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (34, 10, 1, N'Música tradicional', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (35, 11, 1, N'Arte y Cultura', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (36, 11, 1, N'Retiro de naturaleza', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (37, 11, 1, N'Paseo en bote', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (38, 12, 1, N'Exploración de selva', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (39, 12, 1, N'Observación de vida silvestre', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (40, 12, 1, N'Navegación en ríos', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (41, 13, 1, N'Tour histórico', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (42, 13, 1, N'Fotografía colonial', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (43, 13, 1, N'Vistas al río', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (44, 14, 1, N'Senderismo volcánico', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (45, 14, 1, N'Acampada', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (46, 14, 1, N'Observación nocturna', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (47, 15, 1, N'Arquitectura colonial', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (48, 15, 1, N'Vistas desde el techo', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (49, 15, 1, N'Historia cultural', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (50, 16, 1, N'Surf de clase mundial', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (51, 16, 1, N'Atardeceres', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (52, 16, 1, N'Yoga', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (53, 17, 1, N'Tour en bote', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (54, 17, 1, N'Esnórquel', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (55, 17, 1, N'Avistamiento de tortugas', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (56, 18, 1, N'Turismo arqueológico', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (57, 18, 1, N'Historia colonial', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (58, 18, 1, N'Vistas al Momotombo', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (59, 19, 1, N'Senderismo', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (60, 19, 1, N'Observación de cascadas', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (61, 19, 1, N'Ecoturismo', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (62, 20, 1, N'Surf y Clases', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (63, 20, 1, N'Gastronomía playera', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (64, 20, 1, N'Fotografía de atardecer', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (65, 21, 1, N'Arqueología', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (66, 21, 1, N'Observación de fósiles', N'fa-check')
GO
INSERT [dbo].[Activity] ([ActivityId], [DestinationId], [AdminId], [ActivityName], [IconName]) VALUES (67, 21, 1, N'Historia antigua', N'fa-check')
GO
SET IDENTITY_INSERT [dbo].[Activity] OFF
GO
SET IDENTITY_INSERT [dbo].[Destination] ON 
GO
INSERT [dbo].[Destination] ([DestinationId], [AdminId], [Name], [ShortDescription], [LongDescription], [Location], [Latitude], [Longitude], [AverageWeather], [AccessDifficulty], [CreatedAt]) VALUES (1, 1, N'Volcán Cerro Negro', N'El volcán más joven de Centroamérica, famoso mundialmente por ser el único lugar donde puedes practicar "volcano boarding" sobre sus laderas de arena negra.', N'Nacido en 1850, el Cerro Negro es un volcán activo y un imán para los buscadores de adrenalina. La experiencia comienza con una caminata de aproximadamente una hora por un paisaje lunar hasta llegar al cráter, donde disfrutarás de vistas espectaculares de la cordillera volcánica de los Maribios. El verdadero espectáculo es el descenso: te deslizarás en una tabla de madera especialmente diseñada por una pendiente de ceniza volcánica a altas velocidades. Se recomienda llevar mucha agua, protector solar, zapatos cerrados y ropa que no te importe ensuciar.', N'León, Nicaragua', CAST(12.506400 AS Decimal(9, 6)), CAST(-86.702700 AS Decimal(9, 6)), N'34', N'Moderado', CAST(N'2026-02-13T07:39:24.313' AS DateTime))
GO
INSERT [dbo].[Destination] ([DestinationId], [AdminId], [Name], [ShortDescription], [LongDescription], [Location], [Latitude], [Longitude], [AverageWeather], [AccessDifficulty], [CreatedAt]) VALUES (2, 1, N'Bahía de San Juan del Sur', N'El principal destino turístico de playa en el país, conocido por su vibrante vida nocturna, hermosos atardeceres y cercanía a playas de surf de clase mundial.', N'Originalmente un tranquilo pueblo de pescadores, San Juan del Sur se ha transformado en la meca del turismo costero en Nicaragua. Su hermosa bahía en forma de herradura está resguardada por montañas y coronada por la imponente estatua del Cristo de la Misericordia, a la cual puedes subir para obtener la mejor vista panorámica. Es el punto de partida ideal para tomar autobuses hacia playas aledañas como Maderas, Hermosa o Remanso, famosas por sus olas perfectas para el surf. Por la noche, el malecón cobra vida con restaurantes de mariscos y bares frente al mar.', N'San Juan del Sur, Rivas', CAST(11.251400 AS Decimal(9, 6)), CAST(-85.870500 AS Decimal(9, 6)), N'30', N'Fácil', CAST(N'2026-02-13T07:42:00.773' AS DateTime))
GO
INSERT [dbo].[Destination] ([DestinationId], [AdminId], [Name], [ShortDescription], [LongDescription], [Location], [Latitude], [Longitude], [AverageWeather], [AccessDifficulty], [CreatedAt]) VALUES (3, 1, N'Ojo de Agua', N'Un oasis natural de aguas cristalinas y curativas ubicado en el corazón de la selva de la Isla de Ometepe, alimentado por el Volcán Maderas.', N'Escondido bajo el espeso dosel de la selva tropical, el Ojo de Agua es una piscina natural originada por un río subterráneo que fluye desde el Volcán Maderas. Sus frescas aguas son ricas en minerales volcánicos, por lo que muchos locales y turistas afirman que tienen propiedades terapéuticas y rejuvenecedoras. El área está acondicionada de forma ecológica, rodeada de flora exuberante donde es común escuchar el aullido de los monos congos. Cuenta con áreas para tomar el sol, senderos rústicos, columpios de cuerda para saltar al agua y un pequeño restaurante de comida local.', N'Isla de Ometepe, Rivas', CAST(11.488300 AS Decimal(9, 6)), CAST(-85.550100 AS Decimal(9, 6)), N'28', N'Fácil', CAST(N'2026-02-13T07:48:35.127' AS DateTime))
GO
INSERT [dbo].[Destination] ([DestinationId], [AdminId], [Name], [ShortDescription], [LongDescription], [Location], [Latitude], [Longitude], [AverageWeather], [AccessDifficulty], [CreatedAt]) VALUES (4, 1, N'Parque Nacional Volcán Masaya', N'Un cráter activo donde puedes observar un lago de lava burbujeante desde el borde.', N'El Volcán Masaya es uno de los pocos volcanes en el mundo donde se puede llegar en vehículo hasta el mismísimo borde del cráter. De día, puedes ver una impresionante columna de gases, y de noche, el espectáculo del lago de lava incandescente es inolvidable. El parque cuenta con un museo y varios senderos ecológicos.', N'Masaya, Nicaragua', CAST(11.985433 AS Decimal(9, 6)), CAST(-86.160842 AS Decimal(9, 6)), N'28', N'Fácil', CAST(N'2026-02-16T15:50:44.250' AS DateTime))
GO
INSERT [dbo].[Destination] ([DestinationId], [AdminId], [Name], [ShortDescription], [LongDescription], [Location], [Latitude], [Longitude], [AverageWeather], [AccessDifficulty], [CreatedAt]) VALUES (5, 1, N'Reserva Natural Laguna de Apoyo', N'Una laguna cratérica de aguas cálidas y cristalinas rodeada de bosque tropical.', N'Formada hace más de 20,000 años tras la implosión de un volcán, la Laguna de Apoyo es el cuerpo de agua dulce más limpio y profundo de Nicaragua. Sus aguas son cálidas y tranquilas, ideales para nadar, hacer kayak o bucear. Está rodeada de una densa vegetación que alberga monos congos, tucanes y mariposas.', N'Catarina, Masaya, Nicaragua', CAST(11.923611 AS Decimal(9, 6)), CAST(-86.035833 AS Decimal(9, 6)), N'29', N'Fácil', CAST(N'2026-02-16T16:15:24.103' AS DateTime))
GO
INSERT [dbo].[Destination] ([DestinationId], [AdminId], [Name], [ShortDescription], [LongDescription], [Location], [Latitude], [Longitude], [AverageWeather], [AccessDifficulty], [CreatedAt]) VALUES (6, 1, N'Monumento Nacional Cañón de Somoto', N'Un espectacular desfiladero de roca con ríos cristalinos ideal para la aventura.', N'Descubierto turísticamente hace pocas décadas, el Cañón de Somoto es una de las formaciones rocosas más antiguas de Centroamérica. Aquí se origina el río Coco. Es el paraíso para los amantes de la aventura extrema, donde puedes nadar, saltar desde acantilados hacia pozas profundas y navegar en botes neumáticos entre paredes de hasta 100 metros de altura.', N'Somoto, Madriz, Nicaragua', CAST(13.456389 AS Decimal(9, 6)), CAST(-86.702778 AS Decimal(9, 6)), N'24', N'Difícil', CAST(N'2026-02-16T16:17:14.253' AS DateTime))
GO
INSERT [dbo].[Destination] ([DestinationId], [AdminId], [Name], [ShortDescription], [LongDescription], [Location], [Latitude], [Longitude], [AverageWeather], [AccessDifficulty], [CreatedAt]) VALUES (7, 1, N'Isletas de Granada', N'Un archipiélago de 365 pequeñas islas formadas por una erupción del Volcán Mombacho.', N'Situadas en el Gran Lago de Nicaragua (Cocibolca), estas isletas fueron creadas hace miles de años cuando el Volcán Mombacho expulsó gran parte de su cono. Hoy en día, puedes recorrerlas en lancha, observar una rica fauna aviar, visitar la ''Isla de los Monos'', y ver el fuerte colonial de San Pablo. Es un recorrido relajante lleno de historia y naturaleza.', N'Granada, Nicaragua', CAST(11.912456 AS Decimal(9, 6)), CAST(-85.933214 AS Decimal(9, 6)), N'30', N'Fácil', CAST(N'2026-02-16T16:20:38.540' AS DateTime))
GO
INSERT [dbo].[Destination] ([DestinationId], [AdminId], [Name], [ShortDescription], [LongDescription], [Location], [Latitude], [Longitude], [AverageWeather], [AccessDifficulty], [CreatedAt]) VALUES (8, 1, N'Little Corn Island', N'Un paraíso caribeño sin vehículos motorizados, playas de arena blanca y arrecifes de coral.', N'Ubicada en el Mar Caribe nicaragüense, Little Corn Island es el escape perfecto para desconectarse del mundo. No hay automóviles ni motocicletas en toda la isla. Ofrece algunas de las mejores oportunidades para bucear y hacer esnórquel en arrecifes vírgenes, rodeados de tiburones nodriza, rayas y peces coloridos.', N'Región Autónoma de la Costa Caribe Sur, Nicaragua', CAST(12.289167 AS Decimal(9, 6)), CAST(-82.981389 AS Decimal(9, 6)), N'27', N'Moderado', CAST(N'2026-02-16T16:21:56.730' AS DateTime))
GO
INSERT [dbo].[Destination] ([DestinationId], [AdminId], [Name], [ShortDescription], [LongDescription], [Location], [Latitude], [Longitude], [AverageWeather], [AccessDifficulty], [CreatedAt]) VALUES (9, 1, N'Reserva Natural Volcán Mombacho', N'Un volcán extinto cubierto por un denso bosque nuboso con senderos y vistas al lago.', N'El Volcán Mombacho es un oasis de clima fresco y bosque nuboso. Cuenta con senderos muy bien mantenidos como El Cráter y El Puma, que te llevan a través de fumarolas activas y una flora endémica impresionante. Las vistas hacia Granada, las isletas y la Laguna de Apoyo son espectaculares. También puedes hacer canopy (tirolesa) en sus faldas.', N'Granada, Nicaragua', CAST(11.826667 AS Decimal(9, 6)), CAST(-85.968889 AS Decimal(9, 6)), N'22', N'Moderado', CAST(N'2026-02-16T16:24:06.443' AS DateTime))
GO
INSERT [dbo].[Destination] ([DestinationId], [AdminId], [Name], [ShortDescription], [LongDescription], [Location], [Latitude], [Longitude], [AverageWeather], [AccessDifficulty], [CreatedAt]) VALUES (10, 1, N'Mirador de Catarina', N'El punto más alto de los Pueblos Blancos con la mejor vista panorámica de la Laguna de Apoyo.', N'Ubicado en el municipio de Catarina, famoso por sus viveros y artesanías, este mirador ofrece una de las vistas más icónicas de Nicaragua. Desde aquí puedes contemplar toda la inmensidad de la Laguna de Apoyo, el Volcán Mombacho y, en días despejados, el Lago Cocibolca. Es ideal para comprar artesanías locales y disfrutar de música de marimba en vivo.', N'Catarina, Masaya, Nicaragua', CAST(11.913056 AS Decimal(9, 6)), CAST(-86.072778 AS Decimal(9, 6)), N'26', N'Fácil', CAST(N'2026-02-16T16:26:10.833' AS DateTime))
GO
INSERT [dbo].[Destination] ([DestinationId], [AdminId], [Name], [ShortDescription], [LongDescription], [Location], [Latitude], [Longitude], [AverageWeather], [AccessDifficulty], [CreatedAt]) VALUES (11, 1, N'Archipiélago de Solentiname', N'Un grupo de 36 islas en el Gran Lago, cuna de artistas, artesanos y rica biodiversidad.', N'Solentiname es un paraíso de paz y arte primitivista. Fundado como una comunidad contemplativa por Ernesto Cardenal, hoy es famoso por sus artesanos que tallan y pintan madera balsa con colores vibrantes. Las islas, como Mancarrón y San Fernando, son ideales para el retiro espiritual, la observación de aves exóticas y la pesca artesanal.', N'Lago Cocibolca, Río San Juan, Nicaragua', CAST(11.183333 AS Decimal(9, 6)), CAST(-85.033333 AS Decimal(9, 6)), N'28', N'Moderado', CAST(N'2026-02-16T16:27:46.203' AS DateTime))
GO
INSERT [dbo].[Destination] ([DestinationId], [AdminId], [Name], [ShortDescription], [LongDescription], [Location], [Latitude], [Longitude], [AverageWeather], [AccessDifficulty], [CreatedAt]) VALUES (12, 1, N'Reserva Biológica Indio Maíz', N'Una de las reservas de bosque húmedo tropical mejor conservadas de Centroamérica.', N'Considerada la joya de las reservas naturales de Nicaragua, Indio Maíz alberga más especies de árboles, aves e insectos que toda Europa junta. Es el hogar de jaguares, pumas, manatíes y ranas venenosas. El acceso es estrictamente regulado y solo se permite con guías de las comunidades locales a través de los caudalosos ríos Indio y Bartola.', N'San Juan de Nicaragua, Río San Juan', CAST(11.000000 AS Decimal(9, 6)), CAST(-83.866667 AS Decimal(9, 6)), N'26', N'Extremo', CAST(N'2026-02-16T16:29:50.277' AS DateTime))
GO
INSERT [dbo].[Destination] ([DestinationId], [AdminId], [Name], [ShortDescription], [LongDescription], [Location], [Latitude], [Longitude], [AverageWeather], [AccessDifficulty], [CreatedAt]) VALUES (13, 1, N'Fortaleza de la Inmaculada Concepción', N'Un imponente castillo colonial del siglo XVII construido para frenar a los piratas.', N'Ubicado en el pintoresco pueblo de El Castillo, a orillas del Río San Juan. Esta fortaleza española fue construida en 1675 para defender la ciudad de Granada de los ataques piratas que subían por el río desde el Caribe. Hoy alberga un museo y ofrece unas vistas inmejorables de los raudales del río.', N'El Castillo, Río San Juan, Nicaragua', CAST(11.018056 AS Decimal(9, 6)), CAST(-84.398056 AS Decimal(9, 6)), N'27', N'Fácil', CAST(N'2026-02-16T16:31:07.760' AS DateTime))
GO
INSERT [dbo].[Destination] ([DestinationId], [AdminId], [Name], [ShortDescription], [LongDescription], [Location], [Latitude], [Longitude], [AverageWeather], [AccessDifficulty], [CreatedAt]) VALUES (14, 1, N'Volcán Telica', N'Uno de los volcanes más activos del país, ideal para acampar y ver lava al fondo del cráter.', N'El Telica es un volcán de aspecto rocoso y agreste. La excursión hasta su cima suele hacerse al atardecer para disfrutar de las espectaculares vistas de la cordillera de los Maribios y acampar cerca de la cima. Al asomarse al profundo cráter al caer la noche, es posible ver el resplandor de la lava y escuchar el rugido de la tierra.', N'Telica, León, Nicaragua', CAST(12.602500 AS Decimal(9, 6)), CAST(-86.845000 AS Decimal(9, 6)), N'25', N'Difícil', CAST(N'2026-02-16T16:32:26.410' AS DateTime))
GO
INSERT [dbo].[Destination] ([DestinationId], [AdminId], [Name], [ShortDescription], [LongDescription], [Location], [Latitude], [Longitude], [AverageWeather], [AccessDifficulty], [CreatedAt]) VALUES (15, 1, N'Catedral de la Asunción de León', N'La catedral más grande de Centroamérica y Patrimonio de la Humanidad por la UNESCO.', N'Una joya arquitectónica que combina estilos barroco y neoclásico. En su interior descansan los restos del poeta Rubén Darío. La experiencia más icónica es subir a su techo de un blanco inmaculado y recorrer sus cúpulas, desde donde se obtienen vistas espectaculares de toda la ciudad colonial de León y los volcanes.', N'León, Nicaragua', CAST(12.435000 AS Decimal(9, 6)), CAST(-86.878333 AS Decimal(9, 6)), N'32', N'Fácil', CAST(N'2026-02-16T16:33:54.157' AS DateTime))
GO
INSERT [dbo].[Destination] ([DestinationId], [AdminId], [Name], [ShortDescription], [LongDescription], [Location], [Latitude], [Longitude], [AverageWeather], [AccessDifficulty], [CreatedAt]) VALUES (16, 1, N'Playa Popoyo', N'Un destino de renombre mundial para surfistas con olas perfectas y constantes.', N'Popoyo es el epicentro del surf en Nicaragua. Este pequeño pueblo de pescadores se ha transformado en un paraíso para surfistas de todos los niveles. Cuenta con un rompeolas que genera olas consistentes casi todos los días del año, gracias a los vientos Papagayo. El ambiente es relajado, bohemio y centrado en la playa.', N'Tola, Rivas, Nicaragua', CAST(11.455278 AS Decimal(9, 6)), CAST(-86.121944 AS Decimal(9, 6)), N'30', N'Moderado', CAST(N'2026-02-16T16:35:16.230' AS DateTime))
GO
INSERT [dbo].[Destination] ([DestinationId], [AdminId], [Name], [ShortDescription], [LongDescription], [Location], [Latitude], [Longitude], [AverageWeather], [AccessDifficulty], [CreatedAt]) VALUES (17, 1, N'Cayos Perlas', N'Un grupo de 18 islas vírgenes de arena blanca en el mar Caribe.', N'Si buscas una experiencia al estilo náufrago, los Cayos Perlas son el lugar. Rodeados de aguas turquesas, palmeras y arrecifes de coral, estos cayos son un importante sitio de anidación para la tortuga carey. Se llega en lancha desde Pearl Lagoon y son perfectos para un día de total desconexión, esnórquel y pesca.', N'Laguna de Perlas, Costa Caribe Sur, Nicaragua', CAST(12.466667 AS Decimal(9, 6)), CAST(-83.383333 AS Decimal(9, 6)), N'28', N'Moderado', CAST(N'2026-02-16T16:36:33.387' AS DateTime))
GO
INSERT [dbo].[Destination] ([DestinationId], [AdminId], [Name], [ShortDescription], [LongDescription], [Location], [Latitude], [Longitude], [AverageWeather], [AccessDifficulty], [CreatedAt]) VALUES (18, 1, N'Ruinas de León Viejo', N'Los restos de la primera ciudad de León, destruida por el volcán Momotombo en 1610.', N'Este es uno de los asentamientos coloniales españoles más antiguos de América, fundado en 1524. Tras varios terremotos y erupciones del imponente Volcán Momotombo, la ciudad fue abandonada y sepultada bajo cenizas, preservando su trazado original. Hoy es un sitio arqueológico y Patrimonio de la Humanidad donde puedes caminar por la historia.', N'Puerto Momotombo, La Paz Centro, Nicaragua', CAST(12.399722 AS Decimal(9, 6)), CAST(-86.617222 AS Decimal(9, 6)), N'33', N'Fácil', CAST(N'2026-02-16T16:37:47.280' AS DateTime))
GO
INSERT [dbo].[Destination] ([DestinationId], [AdminId], [Name], [ShortDescription], [LongDescription], [Location], [Latitude], [Longitude], [AverageWeather], [AccessDifficulty], [CreatedAt]) VALUES (19, 1, N'Reserva Natural Cerro Apante', N'Un santuario de bosque de nebliselva, cascadas y frescor natural en la perla del septentrión.', N'Protegiendo las montañas que rodean la ciudad de Matagalpa, Cerro Apante es la principal fuente de agua de la región. Ofrece senderos sombreados rodeados de orquídeas, helechos gigantes y monos congos. La caminata culmina en miradores espectaculares y la cruz de la paz que domina la ciudad, atravesando pequeñas cascadas cristalinas.', N'Matagalpa, Nicaragua', CAST(12.913333 AS Decimal(9, 6)), CAST(-85.910278 AS Decimal(9, 6)), N'20', N'Moderado', CAST(N'2026-02-16T16:39:01.107' AS DateTime))
GO
INSERT [dbo].[Destination] ([DestinationId], [AdminId], [Name], [ShortDescription], [LongDescription], [Location], [Latitude], [Longitude], [AverageWeather], [AccessDifficulty], [CreatedAt]) VALUES (20, 1, N'Playa Maderas', N'Una de las playas más famosas de Rivas, famosa por sus formaciones rocosas y ambiente surfista.', N'A pocos kilómetros del centro de San Juan del Sur, Playa Maderas tiene su propia identidad. Sus icónicas formaciones rocosas en forma de aleta de tiburón la hacen inconfundible. Es una playa de arena clara, ideal tanto para quienes aprenden a surfear como para los que buscan disfrutar de excelentes tacos de pescado, cervezas frías y música al atardecer.', N'San Juan del Sur, Rivas, Nicaragua', CAST(11.293611 AS Decimal(9, 6)), CAST(-85.908056 AS Decimal(9, 6)), N'29', N'Fácil', CAST(N'2026-02-16T16:40:09.980' AS DateTime))
GO
INSERT [dbo].[Destination] ([DestinationId], [AdminId], [Name], [ShortDescription], [LongDescription], [Location], [Latitude], [Longitude], [AverageWeather], [AccessDifficulty], [CreatedAt]) VALUES (21, 1, N'Museo Sitio Huellas de Acahualinca', N'Antiguas huellas humanas y animales fosilizadas en lodo y ceniza volcánica hace miles de años.', N'Ubicado en la capital, este invaluable sitio arqueológico y museo protege las huellas dejadas por un grupo de cazadores-recolectores y diversos animales hace unos 6,000 años. Estas marcas quedaron perfectamente grabadas en lodo volcánico cerca de las orillas del Lago Xolotlán, ofreciendo una ventana fascinante a la prehistoria de Mesoamérica. Es un viaje en el tiempo directo a los primeros pobladores del continente.', N'Managua, Nicaragua', CAST(12.158333 AS Decimal(9, 6)), CAST(-86.284722 AS Decimal(9, 6)), N'33', N'Fácil', CAST(N'2026-02-16T16:41:31.433' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Destination] OFF
GO
SET IDENTITY_INSERT [dbo].[DestinationImage] ON 
GO
INSERT [dbo].[DestinationImage] ([ImageId], [DestinationId], [AdminId], [ImageUrl], [IsCover], [AltText], [UploadedAt]) VALUES (1, 1, 1, N'https://nicaraguatourism2026.blob.core.windows.net/nicaragua-photos/8254374c-e557-4926-86f0-182f1ee0664e.webp', 1, N'Imagen 1 de Volcán Cerro Negro', CAST(N'2026-02-13T07:39:24.317' AS DateTime))
GO
INSERT [dbo].[DestinationImage] ([ImageId], [DestinationId], [AdminId], [ImageUrl], [IsCover], [AltText], [UploadedAt]) VALUES (2, 2, 1, N'https://nicaraguatourism2026.blob.core.windows.net/nicaragua-photos/bd5772e9-7740-4287-94c6-daffb5d1c049.jpg', 1, N'Imagen 1 de Bahía de San Juan del Sur', CAST(N'2026-02-13T07:42:00.777' AS DateTime))
GO
INSERT [dbo].[DestinationImage] ([ImageId], [DestinationId], [AdminId], [ImageUrl], [IsCover], [AltText], [UploadedAt]) VALUES (3, 3, 1, N'https://nicaraguatourism2026.blob.core.windows.net/nicaragua-photos/907e052d-febd-4a9c-acb9-88d8b75bf1d6.jpg', 1, N'Imagen 1 de Ojo de Agua', CAST(N'2026-02-13T07:48:35.130' AS DateTime))
GO
INSERT [dbo].[DestinationImage] ([ImageId], [DestinationId], [AdminId], [ImageUrl], [IsCover], [AltText], [UploadedAt]) VALUES (4, 4, 1, N'https://nicaraguatourism2026.blob.core.windows.net/nicaragua-photos/265cc243-31be-40fa-8f50-f5730af1b501.webp', 1, N'Imagen 1 de Parque Nacional Volcán Masaya', CAST(N'2026-02-16T15:50:44.257' AS DateTime))
GO
INSERT [dbo].[DestinationImage] ([ImageId], [DestinationId], [AdminId], [ImageUrl], [IsCover], [AltText], [UploadedAt]) VALUES (5, 5, 1, N'https://nicaraguatourism2026.blob.core.windows.net/nicaragua-photos/73570805-0114-4824-890c-99aa7ed45a32.webp', 1, N'Imagen 1 de Reserva Natural Laguna de Apoyo', CAST(N'2026-02-16T16:15:24.107' AS DateTime))
GO
INSERT [dbo].[DestinationImage] ([ImageId], [DestinationId], [AdminId], [ImageUrl], [IsCover], [AltText], [UploadedAt]) VALUES (6, 6, 1, N'https://nicaraguatourism2026.blob.core.windows.net/nicaragua-photos/daf18d0f-cdec-4f10-a5fe-f5942d014f3c.webp', 1, N'Imagen 1 de Monumento Nacional Cañón de Somoto', CAST(N'2026-02-16T16:17:14.257' AS DateTime))
GO
INSERT [dbo].[DestinationImage] ([ImageId], [DestinationId], [AdminId], [ImageUrl], [IsCover], [AltText], [UploadedAt]) VALUES (7, 7, 1, N'https://nicaraguatourism2026.blob.core.windows.net/nicaragua-photos/3914eecc-754a-44d1-9afa-e70364b4a19e.webp', 1, N'Imagen 1 de Isletas de Granada', CAST(N'2026-02-16T16:20:38.540' AS DateTime))
GO
INSERT [dbo].[DestinationImage] ([ImageId], [DestinationId], [AdminId], [ImageUrl], [IsCover], [AltText], [UploadedAt]) VALUES (8, 8, 1, N'https://nicaraguatourism2026.blob.core.windows.net/nicaragua-photos/9b4aaa9a-142d-48ed-94da-d667c4693306.webp', 1, N'Imagen 1 de Little Corn Island', CAST(N'2026-02-16T16:21:56.730' AS DateTime))
GO
INSERT [dbo].[DestinationImage] ([ImageId], [DestinationId], [AdminId], [ImageUrl], [IsCover], [AltText], [UploadedAt]) VALUES (9, 9, 1, N'https://nicaraguatourism2026.blob.core.windows.net/nicaragua-photos/aa9525a8-775a-4222-9b72-4759ef0ed7dd.webp', 1, N'Imagen 1 de Reserva Natural Volcán Mombacho', CAST(N'2026-02-16T16:24:06.443' AS DateTime))
GO
INSERT [dbo].[DestinationImage] ([ImageId], [DestinationId], [AdminId], [ImageUrl], [IsCover], [AltText], [UploadedAt]) VALUES (10, 10, 1, N'https://nicaraguatourism2026.blob.core.windows.net/nicaragua-photos/c0b07a9a-d7ba-478b-a9c8-8f5673379731.webp', 1, N'Imagen 1 de Mirador de Catarina', CAST(N'2026-02-16T16:26:10.837' AS DateTime))
GO
INSERT [dbo].[DestinationImage] ([ImageId], [DestinationId], [AdminId], [ImageUrl], [IsCover], [AltText], [UploadedAt]) VALUES (11, 11, 1, N'https://nicaraguatourism2026.blob.core.windows.net/nicaragua-photos/9bb5f4aa-7c3f-4ed9-8f1b-714fd818b6e1.webp', 1, N'Imagen 1 de Archipiélago de Solentiname', CAST(N'2026-02-16T16:27:46.207' AS DateTime))
GO
INSERT [dbo].[DestinationImage] ([ImageId], [DestinationId], [AdminId], [ImageUrl], [IsCover], [AltText], [UploadedAt]) VALUES (12, 12, 1, N'https://nicaraguatourism2026.blob.core.windows.net/nicaragua-photos/b2db7dfb-80cd-4de3-a9f2-3b05860d0ece.webp', 1, N'Imagen 1 de Reserva Biológica Indio Maíz', CAST(N'2026-02-16T16:29:50.280' AS DateTime))
GO
INSERT [dbo].[DestinationImage] ([ImageId], [DestinationId], [AdminId], [ImageUrl], [IsCover], [AltText], [UploadedAt]) VALUES (13, 13, 1, N'https://nicaraguatourism2026.blob.core.windows.net/nicaragua-photos/b4b80369-e9b4-4482-89cd-15baef9d9f41.webp', 1, N'Imagen 1 de Fortaleza de la Inmaculada Concepción', CAST(N'2026-02-16T16:31:07.763' AS DateTime))
GO
INSERT [dbo].[DestinationImage] ([ImageId], [DestinationId], [AdminId], [ImageUrl], [IsCover], [AltText], [UploadedAt]) VALUES (14, 14, 1, N'https://nicaraguatourism2026.blob.core.windows.net/nicaragua-photos/7ae5ff3a-f310-4694-8244-5b15ecabfee4.webp', 1, N'Imagen 1 de Volcán Telica', CAST(N'2026-02-16T16:32:26.413' AS DateTime))
GO
INSERT [dbo].[DestinationImage] ([ImageId], [DestinationId], [AdminId], [ImageUrl], [IsCover], [AltText], [UploadedAt]) VALUES (15, 15, 1, N'https://nicaraguatourism2026.blob.core.windows.net/nicaragua-photos/f180dab3-b2f4-4f8f-ab6a-37a6e88be32b.webp', 1, N'Imagen 1 de Catedral de la Asunción de León', CAST(N'2026-02-16T16:33:54.160' AS DateTime))
GO
INSERT [dbo].[DestinationImage] ([ImageId], [DestinationId], [AdminId], [ImageUrl], [IsCover], [AltText], [UploadedAt]) VALUES (16, 16, 1, N'https://nicaraguatourism2026.blob.core.windows.net/nicaragua-photos/906d610b-2127-42f8-9cfc-c5432f107bb3.webp', 1, N'Imagen 1 de Playa Popoyo', CAST(N'2026-02-16T16:35:16.233' AS DateTime))
GO
INSERT [dbo].[DestinationImage] ([ImageId], [DestinationId], [AdminId], [ImageUrl], [IsCover], [AltText], [UploadedAt]) VALUES (17, 17, 1, N'https://nicaraguatourism2026.blob.core.windows.net/nicaragua-photos/5f02ab2c-10bb-4810-b220-deb4381f44e6.webp', 1, N'Imagen 1 de Cayos Perlas', CAST(N'2026-02-16T16:36:33.390' AS DateTime))
GO
INSERT [dbo].[DestinationImage] ([ImageId], [DestinationId], [AdminId], [ImageUrl], [IsCover], [AltText], [UploadedAt]) VALUES (18, 18, 1, N'https://nicaraguatourism2026.blob.core.windows.net/nicaragua-photos/dd8f2c06-773b-46f0-891e-4e7755c58dfa.webp', 1, N'Imagen 1 de Ruinas de León Viejo', CAST(N'2026-02-16T16:37:47.280' AS DateTime))
GO
INSERT [dbo].[DestinationImage] ([ImageId], [DestinationId], [AdminId], [ImageUrl], [IsCover], [AltText], [UploadedAt]) VALUES (19, 19, 1, N'https://nicaraguatourism2026.blob.core.windows.net/nicaragua-photos/3bee0279-5f44-45fa-9ce8-8c99a7e342f7.webp', 1, N'Imagen 1 de Reserva Natural Cerro Apante', CAST(N'2026-02-16T16:39:01.110' AS DateTime))
GO
INSERT [dbo].[DestinationImage] ([ImageId], [DestinationId], [AdminId], [ImageUrl], [IsCover], [AltText], [UploadedAt]) VALUES (20, 20, 1, N'https://nicaraguatourism2026.blob.core.windows.net/nicaragua-photos/d476525f-c280-4b7b-b460-1e02a1657550.webp', 1, N'Imagen 1 de Playa Maderas', CAST(N'2026-02-16T16:40:09.983' AS DateTime))
GO
INSERT [dbo].[DestinationImage] ([ImageId], [DestinationId], [AdminId], [ImageUrl], [IsCover], [AltText], [UploadedAt]) VALUES (21, 21, 1, N'https://nicaraguatourism2026.blob.core.windows.net/nicaragua-photos/679019eb-0f82-4520-8a5b-092dbcb4f3d0.webp', 1, N'Imagen 1 de Museo Sitio Huellas de Acahualinca', CAST(N'2026-02-16T16:41:31.433' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[DestinationImage] OFF
GO
SET IDENTITY_INSERT [dbo].[Favorite] ON 
GO
INSERT [dbo].[Favorite] ([FavoriteId], [UserId], [DestinationId], [AddedAt]) VALUES (2, 1, 2, CAST(N'2026-02-13T08:31:46.367' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Favorite] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 
GO
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (1, N'Admin')
GO
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (2, N'Visitor')
GO
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 
GO
INSERT [dbo].[User] ([UserId], [FullName], [Email], [Password], [RoleId], [CreatedAt]) VALUES (1, N'Francis Flores', N'francis.admin@gmail.com', N'$argon2id$v=19$m=19456,t=2,p=1$vkN6vLuDBQGBOiB4+HxjUA$/uo3RmosMDoK7PpEN9R/9gwSzRrVryqti17MIU+OY1U', 1, CAST(N'2026-02-05T17:20:12.960' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[User] OFF
GO
/****** Object:  Index [AK_Favorite_UserId_DestinationId]    Script Date: 2/16/2026 6:50:16 PM ******/
ALTER TABLE [dbo].[Favorite] ADD  CONSTRAINT [AK_Favorite_UserId_DestinationId] UNIQUE NONCLUSTERED 
(
	[UserId] ASC,
	[DestinationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [AK_Role_RoleName]    Script Date: 2/16/2026 6:50:16 PM ******/
ALTER TABLE [dbo].[Role] ADD  CONSTRAINT [AK_Role_RoleName] UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [AK_User_Email]    Script Date: 2/16/2026 6:50:16 PM ******/
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [AK_User_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Destination] ADD  CONSTRAINT [DF_Destination_CreatedAt]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[DestinationImage] ADD  DEFAULT ((0)) FOR [IsCover]
GO
ALTER TABLE [dbo].[DestinationImage] ADD  CONSTRAINT [DF_DestinationImage_UploadedAt]  DEFAULT (getdate()) FOR [UploadedAt]
GO
ALTER TABLE [dbo].[Favorite] ADD  DEFAULT (getdate()) FOR [AddedAt]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_CreatedAt]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Activity]  WITH CHECK ADD  CONSTRAINT [FK_Activity_Destination_DestinationId] FOREIGN KEY([DestinationId])
REFERENCES [dbo].[Destination] ([DestinationId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Activity] CHECK CONSTRAINT [FK_Activity_Destination_DestinationId]
GO
ALTER TABLE [dbo].[Activity]  WITH CHECK ADD  CONSTRAINT [FK_Activity_User_AdminId] FOREIGN KEY([AdminId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Activity] CHECK CONSTRAINT [FK_Activity_User_AdminId]
GO
ALTER TABLE [dbo].[Destination]  WITH CHECK ADD  CONSTRAINT [FK_Destination_User_AdminId] FOREIGN KEY([AdminId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Destination] CHECK CONSTRAINT [FK_Destination_User_AdminId]
GO
ALTER TABLE [dbo].[DestinationImage]  WITH CHECK ADD  CONSTRAINT [FK_DestinationImage_Destination_DestinationId] FOREIGN KEY([DestinationId])
REFERENCES [dbo].[Destination] ([DestinationId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DestinationImage] CHECK CONSTRAINT [FK_DestinationImage_Destination_DestinationId]
GO
ALTER TABLE [dbo].[DestinationImage]  WITH CHECK ADD  CONSTRAINT [FK_DestinationImage_User_AdminId] FOREIGN KEY([AdminId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[DestinationImage] CHECK CONSTRAINT [FK_DestinationImage_User_AdminId]
GO
ALTER TABLE [dbo].[Favorite]  WITH CHECK ADD  CONSTRAINT [FK_Favorite_Destination_DestinationId] FOREIGN KEY([DestinationId])
REFERENCES [dbo].[Destination] ([DestinationId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Favorite] CHECK CONSTRAINT [FK_Favorite_Destination_DestinationId]
GO
ALTER TABLE [dbo].[Favorite]  WITH CHECK ADD  CONSTRAINT [FK_Favorite_User_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Favorite] CHECK CONSTRAINT [FK_Favorite_User_UserId]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([RoleId])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role_RoleId]
GO
/****** Object:  StoredProcedure [dbo].[uspAddFavorite]    Script Date: 2/16/2026 6:50:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- AGREGAR A FAVORITOS (Add to Wishlist)
CREATE   PROCEDURE [dbo].[uspAddFavorite] (
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
/****** Object:  StoredProcedure [dbo].[uspCheckIsFavorite]    Script Date: 2/16/2026 6:50:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- VERIFICAR SI ES FAVORITO (Check Status)
-- Útil para saber si pintar el corazón de rojo o gris al entrar al detalle de un lugar.
CREATE   PROCEDURE [dbo].[uspCheckIsFavorite] (
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
/****** Object:  StoredProcedure [dbo].[uspClearDestinationDetailsInternal]    Script Date: 2/16/2026 6:50:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- LIMPIAR DETALLES (Para Updates)
CREATE   PROCEDURE [dbo].[uspClearDestinationDetailsInternal] (
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
/****** Object:  StoredProcedure [dbo].[uspDeleteDestination]    Script Date: 2/16/2026 6:50:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Eliminar destino turístico (y sus detalles)
CREATE   PROCEDURE [dbo].[uspDeleteDestination] (
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
/****** Object:  StoredProcedure [dbo].[uspDeleteUser]    Script Date: 2/16/2026 6:50:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ELIMINAR USUARIO (Delete)
CREATE   PROCEDURE [dbo].[uspDeleteUser] (
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
/****** Object:  StoredProcedure [dbo].[uspEditDestination]    Script Date: 2/16/2026 6:50:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Editar destino turístico (y sus detalles)
CREATE   PROCEDURE [dbo].[uspEditDestination] (
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
/****** Object:  StoredProcedure [dbo].[uspEditUser]    Script Date: 2/16/2026 6:50:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EDITAR USUARIO (Update)
CREATE   PROCEDURE [dbo].[uspEditUser] (
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
/****** Object:  StoredProcedure [dbo].[uspGetDestinations]    Script Date: 2/16/2026 6:50:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[uspGetDestinations] (
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
/****** Object:  StoredProcedure [dbo].[uspGetUserByEmail]    Script Date: 2/16/2026 6:50:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Obtener usuario por Email (Para Login interno)
CREATE   PROCEDURE [dbo].[uspGetUserByEmail] (
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
/****** Object:  StoredProcedure [dbo].[uspGetUserFavorites]    Script Date: 2/16/2026 6:50:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[uspGetUserFavorites] (
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
/****** Object:  StoredProcedure [dbo].[uspGetUsers]    Script Date: 2/16/2026 6:50:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[uspGetUsers] (
    @UserId INT = NULL,
    @PageNumber INT = NULL,
    @PageSize INT = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    -- 
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
        WHERE u.UserId = @UserId
        FOR JSON PATH, INCLUDE_NULL_VALUES, WITHOUT_ARRAY_WRAPPER;
    END

    -- 
    ELSE
    BEGIN
        DECLARE @Offset INT, @TotalRecords INT;

        IF @PageNumber IS NULL OR @PageNumber <= 0 SET @PageNumber = 1;
        IF @PageSize IS NULL OR @PageSize <= 0 SET @PageSize = 10;

        SET @Offset = (@PageNumber - 1) * @PageSize;

        SELECT @TotalRecords = COUNT(*) FROM [User];

        SELECT
            @TotalRecords AS TotalRecords,
            (
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
                OFFSET @Offset ROWS
                FETCH NEXT @PageSize ROWS ONLY
                FOR JSON PATH, INCLUDE_NULL_VALUES
            ) AS Data
        FOR JSON PATH, WITHOUT_ARRAY_WRAPPER, INCLUDE_NULL_VALUES;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[uspInsertActivitiesInternal]    Script Date: 2/16/2026 6:50:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- INSERTAR ACTIVIDADES (Recibe TVP)
CREATE   PROCEDURE [dbo].[uspInsertActivitiesInternal] (
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
/****** Object:  StoredProcedure [dbo].[uspInsertDestinationImagesInternal]    Script Date: 2/16/2026 6:50:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- INSERTAR IMÁGENES
CREATE   PROCEDURE [dbo].[uspInsertDestinationImagesInternal] (
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
/****** Object:  StoredProcedure [dbo].[uspInsertDestinationInternal]    Script Date: 2/16/2026 6:50:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- INSERTAR CABECERA (Destination)
CREATE   PROCEDURE [dbo].[uspInsertDestinationInternal] (
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
/****** Object:  StoredProcedure [dbo].[uspLoginUser]    Script Date: 2/16/2026 6:50:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- LOGIN DE USUARIO (Validar Credenciales)
CREATE   PROCEDURE [dbo].[uspLoginUser] (
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
/****** Object:  StoredProcedure [dbo].[uspRegisterDestination]    Script Date: 2/16/2026 6:50:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Registrar nuevo destino turístico (y sus detalles)
CREATE   PROCEDURE [dbo].[uspRegisterDestination] (
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
/****** Object:  StoredProcedure [dbo].[uspRegisterUser]    Script Date: 2/16/2026 6:50:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- REGISTRAR USUARIO (Create)
CREATE   PROCEDURE [dbo].[uspRegisterUser] (
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
/****** Object:  StoredProcedure [dbo].[uspRemoveFavorite]    Script Date: 2/16/2026 6:50:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ELIMINAR DE FAVORITOS (Remove from Wishlist)
CREATE   PROCEDURE [dbo].[uspRemoveFavorite] (
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
/****** Object:  StoredProcedure [dbo].[uspUpdateDestinationInternal]    Script Date: 2/16/2026 6:50:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ACTUALIZAR CABECERA (Destination)
CREATE   PROCEDURE [dbo].[uspUpdateDestinationInternal] (
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
USE [master]
GO
ALTER DATABASE [NicaraguaTourismDB] SET  READ_WRITE 
GO
