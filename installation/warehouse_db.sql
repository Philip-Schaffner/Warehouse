USE [master]
GO
/****** Object:  Database [M321]    Script Date: 18/02/2024 17:02:35 ******/
CREATE DATABASE [M321]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'M321', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\M321.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'M321_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\M321_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [M321] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [M321].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [M321] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [M321] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [M321] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [M321] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [M321] SET ARITHABORT OFF 
GO
ALTER DATABASE [M321] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [M321] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [M321] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [M321] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [M321] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [M321] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [M321] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [M321] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [M321] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [M321] SET  DISABLE_BROKER 
GO
ALTER DATABASE [M321] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [M321] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [M321] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [M321] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [M321] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [M321] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [M321] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [M321] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [M321] SET  MULTI_USER 
GO
ALTER DATABASE [M321] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [M321] SET DB_CHAINING OFF 
GO
ALTER DATABASE [M321] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [M321] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [M321] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [M321] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [M321] SET QUERY_STORE = ON
GO
ALTER DATABASE [M321] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [M321]
GO
/****** Object:  User [warehouse_admin]    Script Date: 18/02/2024 17:02:35 ******/
CREATE USER [warehouse_admin] FOR LOGIN [warehouse_admin] WITH DEFAULT_SCHEMA=[db_datawriter]
GO
/****** Object:  User [pw_checker]    Script Date: 18/02/2024 17:02:35 ******/
CREATE USER [pw_checker] FOR LOGIN [pw_checker] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [warehouse_admin]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [warehouse_admin]
GO
ALTER ROLE [db_datareader] ADD MEMBER [pw_checker]
GO
/****** Object:  Table [dbo].[Articles]    Script Date: 18/02/2024 17:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Articles](
	[ArticleID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[CategoryID] [int] NULL,
	[Price] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ArticleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 18/02/2024 17:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clients]    Script Date: 18/02/2024 17:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clients](
	[ClientID] [int] IDENTITY(1,1) NOT NULL,
	[Firstname] [nvarchar](255) NOT NULL,
	[Email] [nvarchar](255) NULL,
	[Phone] [nvarchar](20) NULL,
	[Lastname] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 18/02/2024 17:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderDetailID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NULL,
	[ArticleID] [int] NULL,
	[Quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 18/02/2024 17:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[OrderDate] [datetime] NOT NULL,
	[Status] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderStatuses]    Script Date: 18/02/2024 17:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderStatuses](
	[StatusID] [int] NOT NULL,
	[Status] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stock]    Script Date: 18/02/2024 17:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stock](
	[ArticleID] [int] NOT NULL,
	[WarehouseID] [int] NOT NULL,
	[Stock] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 18/02/2024 17:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Warehouses]    Script Date: 18/02/2024 17:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Warehouses](
	[WarehouseID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Location] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[WarehouseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Articles] ON 

INSERT [dbo].[Articles] ([ArticleID], [Name], [CategoryID], [Price]) VALUES (2, N'Branchli', 3, CAST(1.50 AS Decimal(10, 2)))
INSERT [dbo].[Articles] ([ArticleID], [Name], [CategoryID], [Price]) VALUES (3, N'Spanisch Brötli', 3, CAST(4.99 AS Decimal(10, 2)))
INSERT [dbo].[Articles] ([ArticleID], [Name], [CategoryID], [Price]) VALUES (4, N'Badener Steine', 2, CAST(5.49 AS Decimal(10, 2)))
INSERT [dbo].[Articles] ([ArticleID], [Name], [CategoryID], [Price]) VALUES (5, N'Luxemburgerli', 2, CAST(3.99 AS Decimal(10, 2)))
INSERT [dbo].[Articles] ([ArticleID], [Name], [CategoryID], [Price]) VALUES (6, N'Schoggi', 3, CAST(6.99 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Articles] OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryID], [Name], [Description]) VALUES (2, N'Clothing', N'Bling to wear')
INSERT [dbo].[Categories] ([CategoryID], [Name], [Description]) VALUES (3, N'Chocolates', N'Fine Swiss chocolates from Baden and Zurich.')
INSERT [dbo].[Categories] ([CategoryID], [Name], [Description]) VALUES (4, N'Cookies', N'Traditional Swiss cookies, crafted with care.')
INSERT [dbo].[Categories] ([CategoryID], [Name], [Description]) VALUES (5, N'Pastries', N'Delicious pastries from local Swiss bakeries.')
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Clients] ON 

INSERT [dbo].[Clients] ([ClientID], [Firstname], [Email], [Phone], [Lastname]) VALUES (2, N'Jon', N'j@f.com', N'12341245', N'Foo')
INSERT [dbo].[Clients] ([ClientID], [Firstname], [Email], [Phone], [Lastname]) VALUES (3, N'Alice', N'alice@example.com', N'123456789', N'Smith')
INSERT [dbo].[Clients] ([ClientID], [Firstname], [Email], [Phone], [Lastname]) VALUES (4, N'Bob', N'bob@example.ch', N'987654321', N'Brown')
INSERT [dbo].[Clients] ([ClientID], [Firstname], [Email], [Phone], [Lastname]) VALUES (5, N'Carol', N'carol@example.ch', N'555555555', N'Johnson')
SET IDENTITY_INSERT [dbo].[Clients] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 

INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ArticleID], [Quantity]) VALUES (4, 4, 6, 10)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ArticleID], [Quantity]) VALUES (5, 4, 2, 5)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ArticleID], [Quantity]) VALUES (6, 2, 3, 20)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ArticleID], [Quantity]) VALUES (7, 2, 4, 10)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [ArticleID], [Quantity]) VALUES (8, 3, 5, 15)
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderID], [ClientID], [OrderDate], [Status]) VALUES (2, 2, CAST(N'2024-02-01T10:00:00.000' AS DateTime), 1)
INSERT [dbo].[Orders] ([OrderID], [ClientID], [OrderDate], [Status]) VALUES (3, 3, CAST(N'2024-02-02T15:30:00.000' AS DateTime), 2)
INSERT [dbo].[Orders] ([OrderID], [ClientID], [OrderDate], [Status]) VALUES (4, 4, CAST(N'2024-02-03T12:45:00.000' AS DateTime), 3)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
INSERT [dbo].[OrderStatuses] ([StatusID], [Status]) VALUES (1, N'Open')
INSERT [dbo].[OrderStatuses] ([StatusID], [Status]) VALUES (3, N'Paid')
INSERT [dbo].[OrderStatuses] ([StatusID], [Status]) VALUES (2, N'Prepared')
INSERT [dbo].[OrderStatuses] ([StatusID], [Status]) VALUES (4, N'Processed')
GO
INSERT [dbo].[Stock] ([ArticleID], [WarehouseID], [Stock]) VALUES (6, 1, 100)
INSERT [dbo].[Stock] ([ArticleID], [WarehouseID], [Stock]) VALUES (2, 1, 150)
INSERT [dbo].[Stock] ([ArticleID], [WarehouseID], [Stock]) VALUES (3, 2, 200)
INSERT [dbo].[Stock] ([ArticleID], [WarehouseID], [Stock]) VALUES (4, 2, 80)
INSERT [dbo].[Stock] ([ArticleID], [WarehouseID], [Stock]) VALUES (5, 1, 60)
GO
INSERT [dbo].[Users] ([UserID], [Username], [Password]) VALUES (0, N'Test', N'test')
GO
SET IDENTITY_INSERT [dbo].[Warehouses] ON 

INSERT [dbo].[Warehouses] ([WarehouseID], [Name], [Location]) VALUES (1, N'Zurich1', N'Zurich')
INSERT [dbo].[Warehouses] ([WarehouseID], [Name], [Location]) VALUES (2, N'Zurich2', N'Zurich')
INSERT [dbo].[Warehouses] ([WarehouseID], [Name], [Location]) VALUES (3, N'Hauptlager', N'Baden')
INSERT [dbo].[Warehouses] ([WarehouseID], [Name], [Location]) VALUES (4, N'Zentrallager Asien', N'Singapur')
INSERT [dbo].[Warehouses] ([WarehouseID], [Name], [Location]) VALUES (5, N'Zentrallager Nordamerika', N'New Jersey')
SET IDENTITY_INSERT [dbo].[Warehouses] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__order_st__A858923CF8C9B30A]    Script Date: 18/02/2024 17:02:35 ******/
ALTER TABLE [dbo].[OrderStatuses] ADD UNIQUE NONCLUSTERED 
(
	[Status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Articles]  WITH CHECK ADD FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([ArticleID])
REFERENCES [dbo].[Articles] ([ArticleID])
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([ClientID])
REFERENCES [dbo].[Clients] ([ClientID])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[OrderStatuses] ([StatusID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Statuses]
GO
ALTER TABLE [dbo].[Stock]  WITH CHECK ADD  CONSTRAINT [FK_Stock_Articles] FOREIGN KEY([ArticleID])
REFERENCES [dbo].[Articles] ([ArticleID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Stock] CHECK CONSTRAINT [FK_Stock_Articles]
GO
ALTER TABLE [dbo].[Stock]  WITH CHECK ADD  CONSTRAINT [FK_Stock_Warehouses] FOREIGN KEY([WarehouseID])
REFERENCES [dbo].[Warehouses] ([WarehouseID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Stock] CHECK CONSTRAINT [FK_Stock_Warehouses]
GO
USE [master]
GO
ALTER DATABASE [M321] SET  READ_WRITE 
GO
