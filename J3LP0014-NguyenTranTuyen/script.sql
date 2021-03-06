USE [master]
GO
/****** Object:  Database [QuizOnline]    Script Date: 2/7/2021 10:12:23 PM ******/
CREATE DATABASE [QuizOnline]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuizOnline', FILENAME = N'E:\SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\QuizOnline.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QuizOnline_log', FILENAME = N'E:\SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\QuizOnline_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [QuizOnline] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuizOnline].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuizOnline] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuizOnline] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuizOnline] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuizOnline] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuizOnline] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuizOnline] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QuizOnline] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuizOnline] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuizOnline] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuizOnline] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuizOnline] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuizOnline] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuizOnline] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuizOnline] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuizOnline] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QuizOnline] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuizOnline] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuizOnline] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuizOnline] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuizOnline] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuizOnline] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuizOnline] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuizOnline] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QuizOnline] SET  MULTI_USER 
GO
ALTER DATABASE [QuizOnline] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuizOnline] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuizOnline] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuizOnline] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QuizOnline] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QuizOnline] SET QUERY_STORE = OFF
GO
USE [QuizOnline]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [QuizOnline]
GO
/****** Object:  Table [dbo].[Question]    Script Date: 2/7/2021 10:12:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[questionID] [nvarchar](100) NOT NULL,
	[questionContent] [nvarchar](100) NULL,
	[answer1] [nvarchar](100) NULL,
	[answer2] [nvarchar](100) NULL,
	[answer3] [nvarchar](100) NULL,
	[answer4] [nvarchar](100) NULL,
	[answerCorrect] [nvarchar](100) NULL,
	[createDate] [nvarchar](100) NULL,
	[statusID] [int] NULL,
	[subjectID] [nvarchar](100) NULL,
 CONSTRAINT [PK_Question] PRIMARY KEY CLUSTERED 
(
	[questionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Registration]    Script Date: 2/7/2021 10:12:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Registration](
	[email] [nvarchar](100) NULL,
	[password] [nvarchar](100) NULL,
	[fullname] [nvarchar](100) NULL,
	[roleID] [int] NULL,
	[statusID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 2/7/2021 10:12:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[roleID] [int] NOT NULL,
	[roleName] [nvarchar](100) NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[roleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subject]    Script Date: 2/7/2021 10:12:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subject](
	[subjectID] [nvarchar](100) NOT NULL,
	[subjectName] [nvarchar](100) NULL,
	[time] [nvarchar](100) NULL,
 CONSTRAINT [PK_Subject] PRIMARY KEY CLUSTERED 
(
	[subjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Question] ([questionID], [questionContent], [answer1], [answer2], [answer3], [answer4], [answerCorrect], [createDate], [statusID], [subjectID]) VALUES (N'2377A74C-8CAC-47E2-852F-E2C171520271', N'child of Mary', N'zet', N'yo', N'zi', N'gu', N'zi', N'2021-02-07', 0, N'')
INSERT [dbo].[Question] ([questionID], [questionContent], [answer1], [answer2], [answer3], [answer4], [answerCorrect], [createDate], [statusID], [subjectID]) VALUES (N'345946E3-941D-43BA-884C-6F13468AD8E9', N'one plus five equal', N'2', N'3', N'4', N'5', N'5', N'2021-02-07', 0, N'')
INSERT [dbo].[Question] ([questionID], [questionContent], [answer1], [answer2], [answer3], [answer4], [answerCorrect], [createDate], [statusID], [subjectID]) VALUES (N'378E0B77-EE99-474A-80D3-775E0D325639', N'one plus three equal', N'1', N'2', N'3', N'4', N'4', N'2021-02-07', 0, N'')
INSERT [dbo].[Question] ([questionID], [questionContent], [answer1], [answer2], [answer3], [answer4], [answerCorrect], [createDate], [statusID], [subjectID]) VALUES (N'3D397869-22D6-411A-A267-4AE8C59F88EC', N'one plus one equal', N'1', N'2', N'3', N'4', N'2', N'2021-02-07', 0, N'95A4E0FC-F1F4-4855-8C57-2058D932E089')
INSERT [dbo].[Question] ([questionID], [questionContent], [answer1], [answer2], [answer3], [answer4], [answerCorrect], [createDate], [statusID], [subjectID]) VALUES (N'3D971CB0-2765-4241-B0CA-9CDBB9058F18', N'one plus five equal', N'2', N'3', N'4', N'5', N'5', N'2021-02-07', 0, N'')
INSERT [dbo].[Question] ([questionID], [questionContent], [answer1], [answer2], [answer3], [answer4], [answerCorrect], [createDate], [statusID], [subjectID]) VALUES (N'5384556F-9DB4-42CE-92D9-D1AA42512BB9', N'one plus five equal', N'2', N'3', N'4', N'5', N'5', N'2021-02-07', 0, N'')
INSERT [dbo].[Question] ([questionID], [questionContent], [answer1], [answer2], [answer3], [answer4], [answerCorrect], [createDate], [statusID], [subjectID]) VALUES (N'5FCEADB9-B1E3-40E0-AFC4-4CC89E4C3DBC', N'one plus five equal', N'2', N'3', N'4', N'5', N'5', N'2021-02-07', 0, N'')
INSERT [dbo].[Question] ([questionID], [questionContent], [answer1], [answer2], [answer3], [answer4], [answerCorrect], [createDate], [statusID], [subjectID]) VALUES (N'61C45C7B-8D1E-413C-AF2E-65620687EF81', N'one plus three equal', N'1', N'2', N'3', N'4', N'4', N'2021-02-07', 0, N'')
INSERT [dbo].[Question] ([questionID], [questionContent], [answer1], [answer2], [answer3], [answer4], [answerCorrect], [createDate], [statusID], [subjectID]) VALUES (N'90982644-CEE2-4277-B307-68BCD76F49EB', N'one plus two equal', N'1', N'2', N'3', N'4', N'3', N'2021-02-07', 0, N'95A4E0FC-F1F4-4855-8C57-2058D932E089')
INSERT [dbo].[Question] ([questionID], [questionContent], [answer1], [answer2], [answer3], [answer4], [answerCorrect], [createDate], [statusID], [subjectID]) VALUES (N'A7D6F57F-CC22-4D58-976D-FF31F374EDFD', N'one plus five equal', N'2', N'3', N'4', N'5', N'5', N'2021-02-07', 0, N'')
INSERT [dbo].[Question] ([questionID], [questionContent], [answer1], [answer2], [answer3], [answer4], [answerCorrect], [createDate], [statusID], [subjectID]) VALUES (N'B62AD867-AE75-42D2-A3DA-86219BEC59F5', N'one plus three equal', N'1', N'2', N'3', N'4', N'4', N'2021-02-07', 0, N'')
INSERT [dbo].[Question] ([questionID], [questionContent], [answer1], [answer2], [answer3], [answer4], [answerCorrect], [createDate], [statusID], [subjectID]) VALUES (N'EE3EFA30-0AD8-4FC9-962F-ACE8CF9ACD20', N'one plus five equal', N'1', N'2', N'3', N'6', N'6', N'2021-02-07', 0, N'45021352-12F1-48D0-8575-1A2F89CCC533')
INSERT [dbo].[Registration] ([email], [password], [fullname], [roleID], [statusID]) VALUES (N'test@gmail.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'tuyen', 0, 1)
INSERT [dbo].[Registration] ([email], [password], [fullname], [roleID], [statusID]) VALUES (N'test1@gmail.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'tuyen', 1, 1)
INSERT [dbo].[Role] ([roleID], [roleName]) VALUES (0, N'Admin')
INSERT [dbo].[Role] ([roleID], [roleName]) VALUES (1, N'user')
INSERT [dbo].[Subject] ([subjectID], [subjectName], [time]) VALUES (N'45021352-12F1-48D0-8575-1A2F89CCC533', N'Literature', N'2:20')
INSERT [dbo].[Subject] ([subjectID], [subjectName], [time]) VALUES (N'95A4E0FC-F1F4-4855-8C57-2058D932E089', N'Math', N'10:60')
USE [master]
GO
ALTER DATABASE [QuizOnline] SET  READ_WRITE 
GO
