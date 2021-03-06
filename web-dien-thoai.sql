USE [master]
GO
/****** Object:  Database [Duongxxx]    Script Date: 7/7/2018 10:38:01 AM ******/
CREATE DATABASE [Duongxxx]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Duongxxx', FILENAME = N'E:\TẢI XUỐNG\database\Duongxxx.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Duongxxx_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\Duongxxx_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Duongxxx] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Duongxxx].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Duongxxx] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Duongxxx] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Duongxxx] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Duongxxx] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Duongxxx] SET ARITHABORT OFF 
GO
ALTER DATABASE [Duongxxx] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Duongxxx] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Duongxxx] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Duongxxx] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Duongxxx] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Duongxxx] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Duongxxx] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Duongxxx] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Duongxxx] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Duongxxx] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Duongxxx] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Duongxxx] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Duongxxx] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Duongxxx] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Duongxxx] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Duongxxx] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Duongxxx] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Duongxxx] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Duongxxx] SET  MULTI_USER 
GO
ALTER DATABASE [Duongxxx] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Duongxxx] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Duongxxx] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Duongxxx] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Duongxxx] SET DELAYED_DURABILITY = DISABLED 
GO
USE [Duongxxx]
GO
/****** Object:  UserDefinedFunction [dbo].[fChuyenCoDauThanhKhongDau]    Script Date: 7/7/2018 10:38:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fChuyenCoDauThanhKhongDau](@inputVar NVARCHAR(MAX) )
RETURNS NVARCHAR(MAX)
AS
BEGIN    
    IF (@inputVar IS NULL OR @inputVar = '')  RETURN ''
   
    DECLARE @RT NVARCHAR(MAX)
    DECLARE @SIGN_CHARS NCHAR(256)
    DECLARE @UNSIGN_CHARS NCHAR (256)
 
    SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệếìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵýĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' + NCHAR(272) + NCHAR(208)
    SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeeeiiiiiooooooooooooooouuuuuuuuuuyyyyyAADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD'
 
    DECLARE @COUNTER int
    DECLARE @COUNTER1 int
   
    SET @COUNTER = 1
    WHILE (@COUNTER <= LEN(@inputVar))
    BEGIN  
        SET @COUNTER1 = 1
        WHILE (@COUNTER1 <= LEN(@SIGN_CHARS) + 1)
        BEGIN
            IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@inputVar,@COUNTER ,1))
            BEGIN          
                IF @COUNTER = 1
                    SET @inputVar = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@inputVar, @COUNTER+1,LEN(@inputVar)-1)      
                ELSE
                    SET @inputVar = SUBSTRING(@inputVar, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@inputVar, @COUNTER+1,LEN(@inputVar)- @COUNTER)
                BREAK
            END
            SET @COUNTER1 = @COUNTER1 +1
        END
        SET @COUNTER = @COUNTER +1
    END
    -- SET @inputVar = replace(@inputVar,' ','-')
    RETURN @inputVar
END
GO
/****** Object:  Table [dbo].[BaiViet]    Script Date: 7/7/2018 10:38:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BaiViet](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenBaiViet] [nvarchar](500) NOT NULL,
	[DanhMucID] [int] NOT NULL,
	[NgayTao] [datetime] NULL,
	[NguoiTao] [varchar](50) NULL,
	[NgayUpdate] [datetime] NULL,
	[NguoiUpdate] [varchar](50) NULL,
	[TrangThai] [bit] NULL,
	[image] [nvarchar](500) NULL,
	[GhiChu] [nvarchar](max) NULL,
	[ViewCount] [int] NULL,
	[MoreImage] [xml] NULL,
	[NoiDung] [ntext] NULL,
	[TieuDeBaiViet] [nvarchar](500) NULL,
	[MoTa] [nvarchar](500) NULL,
 CONSTRAINT [PK_BaiViet] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BaiVietTag]    Script Date: 7/7/2018 10:38:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BaiVietTag](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TagID] [int] NOT NULL,
 CONSTRAINT [PK_BaiVietTag] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[TagID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ChiTietHoaDon]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietHoaDon](
	[ID] [int] NOT NULL,
	[IDSanPham] [int] NOT NULL,
	[SoLuong] [int] NULL,
	[Gia] [decimal](18, 0) NULL,
 CONSTRAINT [PK_ChiTietHoaDon_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[IDSanPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DanhMucBaiViet]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DanhMucBaiViet](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenDanhMuc] [nvarchar](250) NULL,
	[ThuTu] [int] NULL,
	[NgayTao] [datetime] NULL,
	[NguoiTao] [varchar](50) NULL,
	[NgayUpdate] [datetime] NULL,
	[NguoiUpdate] [varchar](50) NULL,
	[TrangThai] [bit] NULL,
	[image] [nvarchar](500) NULL,
 CONSTRAINT [PK_DanhMucBaiViet] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DanhMucSanPham]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DanhMucSanPham](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenDanhMuc] [nvarchar](250) NOT NULL,
	[ThuTu] [int] NULL,
	[NgayTao] [datetime] NULL,
	[NguoiTao] [varchar](50) NULL,
	[NgayUpdate] [datetime] NULL,
	[NguoiUpdate] [varchar](50) NULL,
	[TrangThai] [bit] NULL,
	[image] [nvarchar](500) NULL,
	[PhuKien] [bit] NULL,
 CONSTRAINT [PK_DanhMucSanPham] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Footer]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Footer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Conten] [nvarchar](max) NULL,
 CONSTRAINT [PK_Footer] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GioiThieu]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GioiThieu](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Conten] [nvarchar](max) NULL,
 CONSTRAINT [PK_GioiThieu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HoaDon]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HoaDon](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenKhachHang] [nvarchar](50) NOT NULL,
	[DiaChi] [nvarchar](500) NOT NULL,
	[SDT] [varchar](50) NOT NULL,
	[GhiChu] [nvarchar](max) NULL,
	[NgayTao] [datetime] NULL,
	[NguoiTao] [varchar](50) NULL,
	[PhuongThucThanhToan] [nvarchar](250) NULL,
	[TrangThai] [bit] NOT NULL,
	[Gmail] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_HoaDon] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menu](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[url] [nvarchar](500) NOT NULL,
	[STT] [int] NULL,
	[GroupID] [int] NULL,
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MenuGroup]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuGroup](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nane] [nvarchar](50) NULL,
 CONSTRAINT [PK_MenuGroup] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PhanHoiKH]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhanHoiKH](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Email] [nvarchar](250) NULL,
	[Message] [nvarchar](500) NULL,
	[NgayTao] [datetime] NOT NULL,
	[TrangThai] [bit] NOT NULL,
 CONSTRAINT [PK_PhanHoiKH] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SanPham](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenSanPham] [nvarchar](500) NULL,
	[DanhMucID] [int] NULL,
	[NgayTao] [datetime] NULL,
	[NguoiTao] [varchar](50) NULL,
	[NgayUpdate] [datetime] NULL,
	[NguoiUpdate] [varchar](50) NULL,
	[TrangThai] [bit] NULL,
	[image] [nvarchar](500) NULL,
	[GhiChu] [nvarchar](max) NULL,
	[SPHOT] [bit] NULL,
	[ViewCount] [int] NULL,
	[MoreImage] [xml] NULL,
	[MoTa] [nvarchar](max) NULL,
	[NoiDung] [nvarchar](max) NULL,
	[Gia] [decimal](18, 0) NULL,
	[GiaKhuyenMai] [decimal](18, 0) NULL,
	[BaoHanh] [int] NULL,
	[DoPhanGiai] [nvarchar](250) NULL,
	[ManHinh] [nchar](20) NULL,
	[CamTruoc] [nvarchar](50) NULL,
	[CamSau] [nvarchar](50) NULL,
	[CPU] [nvarchar](250) NULL,
	[SoNhan] [nvarchar](250) NULL,
	[Chip] [nvarchar](250) NULL,
	[Ram] [nvarchar](50) NULL,
	[ROM] [nvarchar](50) NULL,
	[HeDieuHanh] [nvarchar](250) NULL,
	[Pin] [nvarchar](50) NULL,
	[DungluongPin] [nvarchar](50) NULL,
	[Sim] [nvarchar](250) NULL,
	[wifi] [nvarchar](250) NULL,
	[Bluetooth] [nvarchar](50) NULL,
	[GPS] [nvarchar](50) NULL,
 CONSTRAINT [PK_SanPham] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Slide]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Slide](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Image] [nvarchar](500) NULL,
	[url] [nvarchar](500) NULL,
	[STT] [int] NULL,
	[Trangthai] [bit] NULL,
	[NoiDung] [nvarchar](max) NULL,
	[btn] [nvarchar](100) NULL,
 CONSTRAINT [PK_Slide] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SupportOnline]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SupportOnline](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FB] [nvarchar](250) NULL,
	[Zalo] [nvarchar](250) NULL,
	[MAIL] [nvarchar](250) NULL,
	[TrangThai] [bit] NULL,
 CONSTRAINT [PK_SupportOnline] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SystemConfigs]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SystemConfigs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](50) NOT NULL,
	[valueString] [nvarchar](250) NULL,
	[valueInt] [int] NULL,
	[trangThai] [bit] NULL,
 CONSTRAINT [PK_SystemConfigs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TAGS]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TAGS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
 CONSTRAINT [PK_TAGS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Pass] [varchar](32) NULL,
	[Name] [nvarchar](50) NULL,
	[Address] [nvarchar](500) NULL,
	[NgayTao] [datetime] NULL,
	[NguoiTao] [varchar](50) NULL,
	[NgayUpdate] [datetime] NULL,
	[NguoiUpdate] [varchar](50) NULL,
	[TrangThai] [bit] NULL,
	[GroupID] [int] NULL,
	[SDT] [varchar](50) NULL,
	[Email] [nvarchar](500) NULL,
	[HoTen] [nvarchar](250) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[BaiViet] ON 

INSERT [dbo].[BaiViet] ([ID], [TenBaiViet], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [ViewCount], [MoreImage], [NoiDung], [TieuDeBaiViet], [MoTa]) VALUES (1, N'Facebook chuyển 1,5 tỷ người dùng từ Ireland về Mỹ để né luật?', 5, CAST(N'2018-05-20 02:17:48.987' AS DateTime), N'Duong', CAST(N'2018-05-24 15:30:36.723' AS DateTime), N'Duong', 1, N'/ckfinder/userfiles/images/Facebook-mark-zuckerberg.jpg', NULL, 0, NULL, N'<p dir="ltr"><strong>Sau vụ b&ecirc; bối Cambridge Analytica l&agrave;m&nbsp;<a href="https://fptshop.com.vn/tin-tuc/danh-gia/ban-se-giat-minh-khi-biet-nhung-du-lieu-ma-facebook-dang-am-tham-thu-thap-68088" target="_blank">r&ograve; rỉ th&ocirc;ng tin người d&ugrave;ng Facebook&nbsp;</a>đang bị gi&aacute;m s&aacute;t chặt chẽ hơn. Đặc biệt đến ng&agrave;y 25/5 tới đ&acirc;y c&aacute;c luật mới về bảo vệ dữ liệu người d&ugrave;ng tại ch&acirc;u &Acirc;u (GDPR) sẽ c&oacute; hiệu lực l&agrave;m Mark Zuckerberg lo lắng.</strong></p>

<p dir="ltr">Cụ thể GDPR quy định r&otilde; nếu c&aacute;c c&ocirc;ng ty sử dụng dữ liệu người d&ugrave;ng m&agrave; kh&ocirc;ng c&oacute; sự đồng &yacute; r&otilde; r&agrave;ng c&oacute; thể sẽ bị phạt tới 4% doanh thu to&agrave;n cầu. Mark Zuckerberg cũng hứa sẽ theo đuổi tinh thần của GDPR tr&ecirc;n to&agrave;n cầu tuy nhi&ecirc;n c&aacute;ch h&agrave;nh động của vị gi&aacute;m đốc điều h&agrave;nh n&agrave;y lại ho&agrave;n to&agrave;n tr&aacute;i ngược.</p>

<p dir="ltr"><img alt="Facebook " id="Facebook " longdesc="https://fptshop.com.vn/tin-tuc/tin-moi/Facebook" src="https://fptshop.com.vn/uploads/images/tin-tuc/69118/Originals/Facebook-mark-zuckerberg.jpg" title="Facebook " /></p>

<p dir="ltr">Ngay sau khi luật n&agrave;y được c&ocirc;ng bố Facebook đ&atilde; c&oacute; động th&aacute;i muốn chuyển dữ liệu của khoảng 1,5 tỷ người d&ugrave;ng đang được lưu trữ tại Ireland v&agrave; Canada về trụ sở ch&iacute;nh của Facebook tại California - Hoa Kỳ. C&oacute; thể đ&acirc;y l&agrave; c&aacute;ch Facebook n&eacute; tr&aacute;nh GDPR v&igrave; luật ph&aacute;p Hoa Kỳ dường như dễ thở hơn khi đặt b&ecirc;n EU. Điều n&agrave;y c&oacute; thể sẽ ảnh hưởng đến một số quyền ri&ecirc;ng tư của những t&agrave;i khoản được chuyển.</p>
', N'Facebook đã có động thái muốn chuyển dữ liệu của khoảng 1,5 tỷ người dùng đang được lưu trữ tại Ireland và Canada về trụ sở chính của Facebook tại California - Hoa Kỳ', N'Facebook đã có động thái muốn chuyển dữ liệu của khoảng 1,5 tỷ người dùng đang được lưu trữ tại Ireland và Canada về trụ sở chính của Facebook tại California - Hoa Kỳ')
INSERT [dbo].[BaiViet] ([ID], [TenBaiViet], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [ViewCount], [MoreImage], [NoiDung], [TieuDeBaiViet], [MoTa]) VALUES (2, N'8 tính năng mới nhất sắp có trên Facebook', 1, CAST(N'2018-05-20 02:20:47.690' AS DateTime), N'Duong', CAST(N'2018-05-24 15:29:28.107' AS DateTime), N'Duong', 1, N'/ckfinder/userfiles/images/8-tinh-nang-moi-tren-facebook-fptshop-02.jpg', NULL, 0, NULL, N'<p><strong>Trong b&agrave;i viết,&nbsp;<a href="http://fptshop.com.vn/" target="_blank">FPT Shop</a>&nbsp;sẽ c&ugrave;ng c&aacute;c bạn t&igrave;m hiểu về 8 t&iacute;nh năng mới nhất vừa c&oacute; tr&ecirc;n Facebook đ&atilde; được c&ocirc;ng bố trong hội nghị ph&aacute;t triển F8.</strong></p>

<p><strong><img alt="8 tính năng mới nhất sắp có trên Facebook" id="8 tính năng mới nhất sắp có trên Facebook" longdesc="https://fptshop.com.vn/tin-tuc/danh-gia/8%20t%C3%ADnh%20n%C4%83ng%20m%E1%BB%9Bi%20nh%E1%BA%A5t%20s%E1%BA%AFp%20c%C3%B3%20tr%C3%AAn%20Facebook" src="https://fptshop.com.vn/uploads/images/tin-tuc/69481/Originals/8-tinh-nang-moi-tren-facebook-fptshop-01.jpg" title="8 tính năng mới nhất sắp có trên Facebook" /></strong></p>

<p>Facebook tổ chức hội nghị của nh&agrave; ph&aacute;t triển F8 trong tuần n&agrave;y. V&agrave; v&agrave;o thứ hai, c&ocirc;ng ty đ&atilde; c&ocirc;ng bố một loạt c&aacute;c thay đổi sẽ đến với nền tảng h&agrave;ng đầu của họ, cũng như c&aacute;c dịch vụ kh&aacute;c như Messenger, Instagram v&agrave; WhatsApp. Dưới đ&acirc;y l&agrave; 8 điều bạn c&oacute; thể mong đợi sẽ được trải nghiệm tr&ecirc;n Facebook trong những th&aacute;ng tới.</p>

<h3><br />
<strong>Clear History</strong></h3>

<p><img alt="8 tính năng mới nhất sắp có trên Facebook" id="8 tính năng mới nhất sắp có trên Facebook" longdesc="https://fptshop.com.vn/tin-tuc/danh-gia/8%20t%C3%ADnh%20n%C4%83ng%20m%E1%BB%9Bi%20nh%E1%BA%A5t%20s%E1%BA%AFp%20c%C3%B3%20tr%C3%AAn%20Facebook" src="https://fptshop.com.vn/uploads/images/tin-tuc/69481/Originals/8-tinh-nang-moi-tren-facebook-fptshop-02.jpg" title="8 tính năng mới nhất sắp có trên Facebook" /></p>

<p>Trong sự trỗi dậy của vụ b&ecirc; bối dữ liệu Cambridge Analytica, Facebook c&oacute; rất nhiều thứ cần xem x&eacute;t lại về ch&iacute;nh s&aacute;ch quyền ri&ecirc;ng tư v&agrave; việc sử dụng dữ liệu người d&ugrave;ng. V&agrave; với mục đ&iacute;ch lấy lại l&ograve;ng tin của người d&ugrave;ng, Facebook sẽ tung ra một t&iacute;nh năng bảo mật mới trong v&agrave;i th&aacute;ng tới.</p>

<p>N&oacute; được gọi l&agrave; Clear History. Giống như t&ecirc;n cho thấy, t&iacute;nh năng n&agrave;y sẽ cho ph&eacute;p người d&ugrave;ng Facebook xem tất cả dữ liệu m&agrave; c&ocirc;ng ty đ&atilde; thu thập v&agrave; sau đ&oacute; x&oacute;a tất cả dữ liệu trong một lần duy nhất. Tất nhi&ecirc;n, CEO Mark Zuckerberg n&oacute;i rằng Facebook sẽ kh&ocirc;ng &quot;tốt&quot; nếu kh&ocirc;ng c&oacute; dữ liệu đ&oacute;.</p>

<p>Tuy nhi&ecirc;n, c&oacute; một b&aacute;o trước: Facebook sẽ vẫn chia sẻ dữ liệu ph&acirc;n t&iacute;ch với c&aacute;c ứng dụng v&agrave; trang web kh&aacute;c, nhưng kh&ocirc;ng lưu trữ th&ocirc;ng tin theo c&aacute;ch c&oacute; thể nhận dạng ra c&aacute; nh&acirc;n bạn.</p>

<h3><br />
<strong>Facebook Dating</strong></h3>

<p><img alt="8 tính năng mới nhất sắp có trên Facebook" id="8 tính năng mới nhất sắp có trên Facebook" longdesc="https://fptshop.com.vn/tin-tuc/danh-gia/8%20t%C3%ADnh%20n%C4%83ng%20m%E1%BB%9Bi%20nh%E1%BA%A5t%20s%E1%BA%AFp%20c%C3%B3%20tr%C3%AAn%20Facebook" src="https://fptshop.com.vn/uploads/images/tin-tuc/69481/Originals/8-tinh-nang-moi-tren-facebook-fptshop-03.jpeg" title="8 tính năng mới nhất sắp có trên Facebook" /></p>

<p>Hẹn h&ograve; trực tuyến c&oacute; thể kh&ocirc;ng phải l&agrave; điều y&ecirc;u th&iacute;ch của tất cả mọi người trong kỷ nguy&ecirc;n số. Tuy nhi&ecirc;n, Facebook dường như đ&atilde; sẵn s&agrave;ng để đi s&acirc;u v&agrave;o mảng hẹn h&ograve; trực tuyến với một nền tảng mới được tiết lộ cho &ldquo;c&aacute;c mối quan hệ l&acirc;u d&agrave;i&rdquo;.</p>

<p>Về cơ bản, n&oacute; sẽ l&agrave; một trang hẹn h&ograve; ri&ecirc;ng biệt với hồ sơ Facebook ti&ecirc;u chuẩn của người d&ugrave;ng. Sau đ&oacute;, Facebook sẽ kết nối người d&ugrave;ng với nhau dựa tr&ecirc;n sở th&iacute;ch, bạn b&egrave; chung v&agrave; sở th&iacute;ch chung. T&iacute;nh năng nhắn tin của n&oacute; cũng sẽ t&aacute;ch biệt v&agrave; chỉ c&oacute; văn bản v&igrave; &ldquo;l&yacute; do an to&agrave;n&rdquo;.</p>

<h3><br />
<strong>Watch Party</strong></h3>

<p><img alt="8 tính năng mới nhất sắp có trên Facebook" id="8 tính năng mới nhất sắp có trên Facebook" longdesc="https://fptshop.com.vn/tin-tuc/danh-gia/8%20t%C3%ADnh%20n%C4%83ng%20m%E1%BB%9Bi%20nh%E1%BA%A5t%20s%E1%BA%AFp%20c%C3%B3%20tr%C3%AAn%20Facebook" src="https://fptshop.com.vn/uploads/images/tin-tuc/69481/Originals/8-tinh-nang-moi-tren-facebook-fptshop-04.jpg" title="8 tính năng mới nhất sắp có trên Facebook" /></p>

<p>Gi&aacute;m đốc điều h&agrave;nh Facebook Mark Zuckerberg đ&atilde; giới thiệu một t&iacute;nh năng mới kh&aacute;c, được gọi l&agrave; Watch Party. Facebook n&oacute;i Watch Party sẽ gi&uacute;p bạn xem video dễ d&agrave;ng hơn với bạn b&egrave;.</p>

<p>Về cơ bản, Watch Party l&agrave; một c&aacute;ch để thiết lập một luồng video với một ph&ograve;ng chat gắn liền với n&oacute;. V&iacute; dụ, c&aacute;c quản trị vi&ecirc;n nh&oacute;m Facebook sẽ c&oacute; thể dễ d&agrave;ng sắp xếp một video với một ph&ograve;ng tr&ograve; chuyện v&agrave; mời c&aacute;c th&agrave;nh vi&ecirc;n nh&oacute;m v&agrave;o đ&oacute;.</p>

<h3><br />
<strong>Group Calling &amp; Video Chatting</strong></h3>

<p><img alt="8 tính năng mới nhất sắp có trên Facebook" id="8 tính năng mới nhất sắp có trên Facebook" longdesc="https://fptshop.com.vn/tin-tuc/danh-gia/8%20t%C3%ADnh%20n%C4%83ng%20m%E1%BB%9Bi%20nh%E1%BA%A5t%20s%E1%BA%AFp%20c%C3%B3%20tr%C3%AAn%20Facebook" src="https://fptshop.com.vn/uploads/images/tin-tuc/69481/Originals/8-tinh-nang-moi-tren-facebook-fptshop-05.jpg" title="8 tính năng mới nhất sắp có trên Facebook" /></p>

<p>Ngo&agrave;i những thay đổi cho nền tảng h&agrave;ng đầu của m&igrave;nh, Facebook cũng c&ocirc;ng bố hai bổ sung cho c&aacute;c nền tảng truyền th&ocirc;ng x&atilde; hội kh&aacute;c m&agrave; họ sở hữu: Instagram v&agrave; WhatsApp.</p>

<p>Đối với Instagram, g&atilde; khổng lồ c&ocirc;ng nghệ sẽ thực hiện th&ecirc;m v&agrave;o t&iacute;nh năng tr&ograve; chuyện video giống như Facebook Messenger. C&ograve;n đối với WhatsApp, Facebook sẽ bổ sung th&ecirc;m khả năng gọi nh&oacute;m cho WhatsApp trong những th&aacute;ng tới.</p>

<h3><br />
<strong>Augmented Reality tốt hơn</strong></h3>

<p><img alt="8 tính năng mới nhất sắp có trên Facebook" id="8 tính năng mới nhất sắp có trên Facebook" longdesc="https://fptshop.com.vn/tin-tuc/danh-gia/8%20t%C3%ADnh%20n%C4%83ng%20m%E1%BB%9Bi%20nh%E1%BA%A5t%20s%E1%BA%AFp%20c%C3%B3%20tr%C3%AAn%20Facebook" src="https://fptshop.com.vn/uploads/images/tin-tuc/69481/Originals/8-tinh-nang-moi-tren-facebook-fptshop-06.jpg" title="8 tính năng mới nhất sắp có trên Facebook" /></p>

<p>Facebook c&oacute; lẽ kh&ocirc;ng muốn bị bỏ lại ph&iacute;a sau ở mảng tăng cường thực tế. V&agrave; tại hội nghị F8, c&ocirc;ng ty đ&atilde; c&ocirc;ng bố một số t&iacute;nh năng mới tập trung v&agrave;o AR đến c&aacute;c nền tảng kh&aacute;c nhau của họ.</p>

<p>Ở Messenger, t&iacute;nh năng sẽ cho ph&eacute;p c&aacute;c doanh nghiệp th&ecirc;m bộ lọc hoặc hiệu ứng c&oacute; thương hiệu của ri&ecirc;ng v&agrave;o nền tảng, cho ph&eacute;p người d&ugrave;ng &ldquo;thử&rdquo; c&aacute;c sản phẩm trước khi mua ch&uacute;ng. N&oacute; cũng đ&atilde; c&ocirc;ng bố bản cập nhật mới cho AR Studio của m&igrave;nh, bao gồm hỗ trợ cho người d&ugrave;ng Instagram v&agrave; người tạo bộ lọc AR.</p>

<h3><br />
<strong>Phản hồi khủng hoảng</strong></h3>

<p><img alt="8 tính năng mới nhất sắp có trên Facebook" id="8 tính năng mới nhất sắp có trên Facebook" longdesc="https://fptshop.com.vn/tin-tuc/danh-gia/8%20t%C3%ADnh%20n%C4%83ng%20m%E1%BB%9Bi%20nh%E1%BA%A5t%20s%E1%BA%AFp%20c%C3%B3%20tr%C3%AAn%20Facebook" src="https://fptshop.com.vn/uploads/images/tin-tuc/69481/Originals/8-tinh-nang-moi-tren-facebook-fptshop-07.jpg" title="8 tính năng mới nhất sắp có trên Facebook" /></p>

<p>Bộ c&ocirc;ng cụ phản hồi khủng hoảng của Facebook bao gồm c&aacute;c t&iacute;nh năng c&oacute; thể thực sự gi&uacute;p đỡ trong trường hợp khẩn cấp v&agrave; thi&ecirc;n tai. V&iacute; dụ như n&uacute;t Kiểm tra an to&agrave;n, cho ph&eacute;p người d&ugrave;ng đ&aacute;nh dấu m&igrave;nh l&agrave; &quot;an to&agrave;n&quot; v&agrave;o thời điểm khủng hoảng n&agrave;o đ&oacute;.</p>

<p>V&agrave; trong tuần n&agrave;y, Facebook đ&atilde; th&ocirc;ng b&aacute;o rằng phản hồi khủng hoảng sẽ được cập nhật với một t&iacute;nh năng cho ph&eacute;p người d&ugrave;ng dễ d&agrave;ng chia sẻ t&agrave;i khoản của người đầu ti&ecirc;n về thi&ecirc;n tai v&agrave; trường hợp khẩn cấp. Dữ liệu đ&oacute; c&oacute; thể bao gồm c&aacute;c b&aacute;o c&aacute;o, h&igrave;nh ảnh v&agrave; cảnh quay video đầu ti&ecirc;n. Điều n&agrave;y sẽ cho ph&eacute;p người d&ugrave;ng dễ d&agrave;ng theo d&otilde;i v&agrave; xem diễn biến c&aacute;c t&igrave;nh huống thảm họa.</p>

<h3><br />
<strong>T&iacute;ch hợp dịch thuật</strong></h3>

<p><img alt="8 tính năng mới nhất sắp có trên Facebook" id="8 tính năng mới nhất sắp có trên Facebook" longdesc="https://fptshop.com.vn/tin-tuc/danh-gia/8%20t%C3%ADnh%20n%C4%83ng%20m%E1%BB%9Bi%20nh%E1%BA%A5t%20s%E1%BA%AFp%20c%C3%B3%20tr%C3%AAn%20Facebook" src="https://fptshop.com.vn/uploads/images/tin-tuc/69481/Originals/8-tinh-nang-moi-tren-facebook-fptshop-08.jpg" title="8 tính năng mới nhất sắp có trên Facebook" /></p>

<p>Trong qu&aacute; khứ, Facebook dựa v&agrave;o dịch vụ của b&ecirc;n thứ ba như Microsoft Bing để dịch c&aacute;c ng&ocirc;n ngữ. Nhưng giờ đ&acirc;y, c&ocirc;ng ty sẽ triển khai c&ocirc;ng cụ dịch thuật của b&ecirc;n thứ nhất cho &iacute;t nhất một nền tảng: Marketplace - hệ thống thương mại điện tử của Facebook d&agrave;nh cho người d&ugrave;ng mua v&agrave; b&aacute;n.</p>

<p>N&oacute; được gọi l&agrave; M Translations, v&agrave; n&oacute; sẽ hoạt động kh&aacute; đơn giản. Nếu bạn nhận được th&ocirc;ng b&aacute;o tr&ecirc;n Marketplace bằng ng&ocirc;n ngữ bạn kh&ocirc;ng sử dụng, Facebook sẽ hỏi bạn xem bạn c&oacute; muốn dịch n&oacute; kh&ocirc;ng. Khi ra mắt, n&oacute; sẽ hỗ trợ tiếng T&acirc;y Ban Nha v&agrave; tiếng Anh. Facebook cho biết n&oacute; sẽ mở rộng cho tất cả người d&ugrave;ng Messenger v&agrave; c&aacute;c ng&ocirc;n ngữ kh&aacute;c tr&ecirc;n thế giới.</p>

<h3><br />
<strong>Ứng dụng Messenger đ&atilde; được sửa lại</strong></h3>

<p><img alt="8 tính năng mới nhất sắp có trên Facebook" id="8 tính năng mới nhất sắp có trên Facebook" longdesc="https://fptshop.com.vn/tin-tuc/danh-gia/8%20t%C3%ADnh%20n%C4%83ng%20m%E1%BB%9Bi%20nh%E1%BA%A5t%20s%E1%BA%AFp%20c%C3%B3%20tr%C3%AAn%20Facebook" src="https://fptshop.com.vn/uploads/images/tin-tuc/69481/Originals/8-tinh-nang-moi-tren-facebook-fptshop-09.jpg" title="8 tính năng mới nhất sắp có trên Facebook" /></p>

<p>Ứng dụng Messenger của Facebook cực kỳ phổ biến. Mặc d&ugrave; vậy, giao diện đ&atilde; kh&ocirc;ng được l&agrave;m mới trong một thời gian. May mắn thay, Facebook th&ocirc;ng b&aacute;o rằng họ sẽ ho&agrave;n to&agrave;n t&acirc;n trang lại ứng dụng. Ngo&agrave;i c&aacute;c bản cập nhật sẽ gi&uacute;p việc điều hướng dễ d&agrave;ng hơn, qu&aacute; tr&igrave;nh l&agrave;m mới sẽ mang lại chế độ tối cho ứng dụng.</p>
', N'Trong bài viết, FPT Shop sẽ cùng các bạn tìm hiểu về 8 tính năng mới nhất vừa có trên Facebook đã được công bố trong hội nghị phát triển F8.', N'Trong bài viết, FPT Shop sẽ cùng các bạn tìm hiểu về 8 tính năng mới nhất vừa có trên Facebook đã được công bố trong hội nghị phát triển F8.')
INSERT [dbo].[BaiViet] ([ID], [TenBaiViet], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [ViewCount], [MoreImage], [NoiDung], [TieuDeBaiViet], [MoTa]) VALUES (3, N'Facebook sắp được bổ sung tính năng “Avatars”', 6, CAST(N'2018-05-20 02:27:31.913' AS DateTime), N'Duong', CAST(N'2018-05-24 15:28:21.257' AS DateTime), N'Duong', 1, N'/ckfinder/userfiles/images/Facebook-Avatars-Feature-1.jpg', NULL, 0, NULL, N'<p dir="ltr"><strong>Facebook đang l&ecirc;n kế hoạch th&ecirc;m một t&iacute;nh năng mới v&agrave;o ứng dụng tr&ecirc;n di động được đặt t&ecirc;n l&agrave; Avatars, đ&acirc;y l&agrave; ứng dụng gi&uacute;p người d&ugrave;ng t&ugrave;y chỉnh h&igrave;nh biến ch&uacute;ng th&agrave;nh những h&igrave;nh hoạt h&igrave;nh cho nhiều mục đ&iacute;ch kh&aacute;c nhau.</strong></p>

<p dir="ltr">Ứng dụng n&agrave;y sẽ sử dụng những h&igrave;nh ảnh thật biến th&agrave;nh ảnh hoạt h&igrave;nh (phần n&agrave;o giống với emoji), người d&ugrave;ng c&oacute; thể sử dụng như sticker để comment, gửi cho bạn b&egrave; hay thậm ch&iacute; l&agrave; để ảnh đại diện trong Messenger hay group chat.</p>

<p dir="ltr"><img alt="Tính năng Avatar trên Facebook 01" id="Tính năng Avatar trên Facebook 01" longdesc="https://fptshop.com.vn/tin-tuc/tin-moi/T%C3%ADnh%20n%C4%83ng%20Avatar%20tr%C3%AAn%20Facebook%2001" src="https://fptshop.com.vn/uploads/images/tin-tuc/69701/Originals/Facebook-Avatars-Feature-1.jpg" title="Tính năng Avatar trên Facebook 01" /></p>

<p dir="ltr">Avatars được cho l&agrave; kh&aacute; giống với t&iacute;nh năng Bitmoji của Snapchat cho ph&eacute;p người d&ugrave;ng tạo những ảnh động của bản th&acirc;n. T&iacute;nh năng n&agrave;y cũng được m&ocirc; tả phần n&agrave;o giống với Emoji tr&ecirc;n bộ đ&ocirc;i&nbsp;<a href="https://fptshop.com.vn/dien-thoai/samsung-galaxy-s9" id="Samsung Galaxy S9" target="_blank" title="Samsung Galaxy S9" type="Samsung Galaxy S9"><strong>Galaxy S9</strong></a>/ S9+ của&nbsp;<a href="https://fptshop.com.vn/dien-thoai/samsung" id="Samsung" target="_blank" title="Samsung" type="Samsung"><strong>Samsung</strong></a>&nbsp;với khả năng t&ugrave;y chỉnh kiểu t&oacute;c, m&agrave;u da. Hiện chưa r&otilde; thời điểm Facebook sẽ cập nhật ch&iacute;nh thức t&iacute;nh năng n&agrave;y nhưng dường như ch&uacute;ng ta sẽ phải đợi th&ecirc;m thời gian kh&aacute; l&acirc;u.</p>

<p dir="ltr"><img alt="Tính năng Avatar trên Facebook 02" id="Tính năng Avatar trên Facebook 02" longdesc="https://fptshop.com.vn/tin-tuc/tin-moi/T%C3%ADnh%20n%C4%83ng%20Avatar%20tr%C3%AAn%20Facebook%2002" src="https://fptshop.com.vn/uploads/images/tin-tuc/69701/Originals/Facebook-Avatars-Feature-2.jpg" title="Tính năng Avatar trên Facebook 02" /></p>

<p>&nbsp;</p>
', N'Facebook sắp được bổ sung tính năng “Avatars”', N'Facebook được cho là sẽ bổ sung thêm một tính năng mới vào ứng dụng của mình được gọi là Avatar giúp người dùng tùy chỉnh những hình ảnh của chính mình thành hiệu ứng thú vị')
INSERT [dbo].[BaiViet] ([ID], [TenBaiViet], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [ViewCount], [MoreImage], [NoiDung], [TieuDeBaiViet], [MoTa]) VALUES (4, N'12312', 1, CAST(N'2018-05-20 20:32:48.857' AS DateTime), N'Duong', NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, N'12', N'312')
INSERT [dbo].[BaiViet] ([ID], [TenBaiViet], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [ViewCount], [MoreImage], [NoiDung], [TieuDeBaiViet], [MoTa]) VALUES (5, N'Facebook sắp phát hành tiền điện tử riêng của mình?', 1, CAST(N'2018-05-20 20:33:12.010' AS DateTime), N'Duong', CAST(N'2018-05-24 15:25:43.080' AS DateTime), N'Duong', 1, N'/ckfinder/userfiles/images/facebook-phat-hanh-tien-dien-tu.jpg', NULL, 0, NULL, N'<p dir="ltr"><strong>Th&ocirc;ng tin n&agrave;y đến từ Alex Health - một ph&oacute;ng vi&ecirc;n của tờ b&aacute;o Cheddar. &Ocirc;ng n&agrave;y cho biết, hiện c&oacute; nhiều nghi vấn xoay quanh việc Facebook sẽ tung ra tiền điện tử. Tuy nhi&ecirc;n, hiện tại chưa c&oacute; nhiều chi tiết hơn về quyết định n&agrave;y.</strong></p>

<p dir="ltr"><img alt="Facebook sắp phát hành tiền điện tử riêng của mình?" id="Facebook sắp phát hành tiền điện tử riêng của mình?" longdesc="https://fptshop.com.vn/tin-tuc/tin-moi/Facebook%20s%E1%BA%AFp%20ph%C3%A1t%20h%C3%A0nh%20ti%E1%BB%81n%20%C4%91i%E1%BB%87n%20t%E1%BB%AD%20ri%C3%AAng%20c%E1%BB%A7a%20m%C3%ACnh?" src="https://fptshop.com.vn/uploads/images/tin-tuc/69850/Originals/facebook-phat-hanh-tien-dien-tu.jpg" title="Facebook sắp phát hành tiền điện tử riêng của mình?" /></p>

<p dir="ltr">Nhiều người tin rằng nếu như việc n&agrave;y trở th&agrave;nh hiện thực, rất c&oacute; thể Facebook sẽ sử dụng đồng crypto đ&oacute; để phục vụ cho người d&ugrave;ng thanh to&aacute;n c&aacute;c dịch vụ v&agrave; sản phẩm tr&ecirc;n nền tảng, chẳng hạn như tr&ecirc;n c&aacute;c ứng dụng&nbsp;<a href="https://fptshop.com.vn/dien-thoai" target="_blank" title="điện thoại" type="điện thoại">điện thoại di động</a>&nbsp;hoặc trả tiền mua game. Điều n&agrave;y đặc biệt đ&uacute;ng khi Facebook c&oacute; động th&aacute;i đẩy mạnh nền tảng mua b&aacute;n Marketplace để gi&uacute;p c&aacute;c th&agrave;nh vi&ecirc;n trao đổi h&agrave;ng ho&aacute;.</p>

<p dir="ltr">Mặt kh&aacute;c, Facebook cũng sẽ &aacute;p dụng c&ocirc;ng nghệ blockchain để tăng cường bảo mật cho dữ liệu người d&ugrave;ng, cũng như cải thiện những t&iacute;nh năng kh&aacute;c c&oacute; mặt tr&ecirc;n nền tảng n&agrave;y. Thậm ch&iacute;, g&atilde; khổng lồ xanh cũng th&agrave;nh lập một ph&ograve;ng ban ri&ecirc;ng để nghi&ecirc;n cứu v&agrave; ph&aacute;t triển blockchain, được dẫn đầu bởi chuy&ecirc;n gia trong ng&agrave;nh David Marcus.</p>
', N'Facebook sắp phát hành tiền điện tử riêng của mình?', N'Theo một nguồn tin đáng tin cậy, có vẻ như Facebook đang tìm cách áp dụng công nghệ blockchain vào bộ máy khổng lồ của mình. Có lẽ nào mạng xã hội lớn nhất hành tinh này chuẩn bị tung ra đồng tiền điện tử?')
INSERT [dbo].[BaiViet] ([ID], [TenBaiViet], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [ViewCount], [MoreImage], [NoiDung], [TieuDeBaiViet], [MoTa]) VALUES (6, N'Instagram cập nhật tính năng share post lên Stories', 1, CAST(N'2018-05-20 20:34:10.827' AS DateTime), N'Duong', CAST(N'2018-05-24 15:24:29.657' AS DateTime), N'Duong', 1, N'/ckfinder/userfiles/images/tinh-nang-mute-instagram-1.jpg', NULL, 0, NULL, N'<p dir="ltr">Phi&ecirc;n bản mới nhất của ứng dụng&nbsp;<a href="https://fptshop.com.vn/dien-thoai" target="_blank" title="điện thoại" type="điện thoại">điện thoại</a>&nbsp;Instagram cho ph&eacute;p bạn chia sẻ bất kỳ b&agrave;i đăng n&agrave;o tr&ecirc;n feed l&ecirc;n Stories. Chỉ với một v&agrave;i thao t&aacute;c đơn giản, bạn đ&atilde; c&oacute; thể nhanh ch&oacute;ng share post, v&agrave; post n&agrave;y sẽ biến mất sau 24 giờ.</p>

<p dir="ltr">Để l&agrave;m được như vậy, bạn h&atilde;y nhấn v&agrave;o n&uacute;t chia sẻ b&ecirc;n dưới b&agrave;i đăng. N&uacute;t n&agrave;o c&oacute; h&igrave;nh chiếc m&aacute;y bay giấy, chọn &quot;Create a Story With This Post&rdquo;, th&ecirc;m ch&uacute; th&iacute;ch v&agrave; nhấn biểu tượng dấu cộng nhỏ gần ph&iacute;a dưới b&ecirc;n tr&aacute;i để đăng l&ecirc;n Stories. Bạn c&oacute; thể nh&igrave;n xem qua h&igrave;nh sau để biết c&aacute;ch l&agrave;m.</p>

<p><img alt="Instagram cập nhật tính năng share post lên Stories" id="Instagram cập nhật tính năng share post lên Stories" longdesc="https://fptshop.com.vn/tin-tuc/tin-moi/Instagram%20c%E1%BA%ADp%20nh%E1%BA%ADt%20t%C3%ADnh%20n%C4%83ng%20share%20post%20l%C3%AAn%20Stories" src="https://fptshop.com.vn/uploads/images/tin-tuc/69971/Originals/share-post-len-stories-instagram.png" title="Instagram cập nhật tính năng share post lên Stories" /></p>

<p dir="ltr">Cần lưu &yacute; rằng chỉ c&aacute;c b&agrave;i đăng từ t&agrave;i khoản c&ocirc;ng khai mới c&oacute; thể được chia sẻ theo c&aacute;ch n&agrave;y. Nếu bạn muốn share post từ một người bạn đang set t&agrave;i khoản l&agrave; Private l&ecirc;n Stories th&igrave; sẽ kh&ocirc;ng l&agrave;m được đ&acirc;u.</p>

<p dir="ltr">Mời c&aacute;c bạn thử qua t&iacute;nh năng th&uacute; vị n&agrave;y của Instagram.</p>
', N'Instagram liên tục bổ sung các tính năng và thay đổi nhỏ để đáp ứng nhu cầu của người dùng tốt hơn. Và mới đây mạng xã hội hình ảnh lớn nhất thế giới đã thêm tính năng share post lên Stories cực hay.', N'Instagram liên tục bổ sung các tính năng và thay đổi nhỏ để đáp ứng nhu cầu của người dùng tốt hơn. Và mới đây mạng xã hội hình ảnh lớn nhất thế giới đã thêm tính năng share post lên Stories cực hay.')
INSERT [dbo].[BaiViet] ([ID], [TenBaiViet], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [ViewCount], [MoreImage], [NoiDung], [TieuDeBaiViet], [MoTa]) VALUES (7, N'Tính năng mới sau của Instagram sẽ giúp bạn...bớt khó xử hơn', 1, CAST(N'2018-05-20 20:36:23.350' AS DateTime), N'Duong', CAST(N'2018-05-24 13:23:11.697' AS DateTime), N'Duong', 1, N'/ckfinder/userfiles/images/tinh-nang-mute-instagram-1.jpg', NULL, 0, NULL, N'<p><strong>Thay v&igrave; phải bỏ theo d&otilde;i một t&agrave;i khoản m&igrave;nh kh&ocirc;ng muốn xem, giờ đ&acirc;y c&aacute;c Instagramer c&oacute; thể đơn giản...bỏ qua t&agrave;i khoản đ&oacute; với t&iacute;nh năng mới sau đ&acirc;y.</strong></p>

<p><strong><img alt="Tính năng mới sau của Instagram sẽ giúp bạn...bớt khó xử hơn" id="Tính năng mới sau của Instagram sẽ giúp bạn...bớt khó xử hơn" longdesc="https://fptshop.com.vn/tin-tuc/tin-moi/T%C3%ADnh%20n%C4%83ng%20m%E1%BB%9Bi%20sau%20c%E1%BB%A7a%20Instagram%20s%E1%BA%BD%20gi%C3%BAp%20b%E1%BA%A1n...b%E1%BB%9Bt%20kh%C3%B3%20x%E1%BB%AD%20h%C6%A1n" src="https://fptshop.com.vn/uploads/images/tin-tuc/70127/Originals/tinh-nang-mute-instagram-1.jpg" title="Tính năng mới sau của Instagram sẽ giúp bạn...bớt khó xử hơn" /></strong></p>

<p>Tr&ecirc;n mạng x&atilde; hội thật kh&oacute; để gặp những người m&igrave;nh cảm thấy &ldquo;kh&oacute; ưa&quot;. Thậm ch&iacute; những người bạn l&acirc;u năm nhưng dạo n&agrave;y n&oacute; cứ post những thứ linh tinh kỳ cục l&ecirc;n mạng l&agrave;m m&igrave;nh thật kh&oacute; chịu.</p>

<p dir="ltr">Trước đ&acirc;y c&aacute;c bạn thường chọn c&aacute;ch unfollow - bỏ theo d&otilde;i những t&agrave;i khoản dạng n&agrave;y. Tuy nhi&ecirc;n, nhiều khi unfollow họ xong rồi lại gặp ngo&agrave;i đời th&igrave; lại v&ocirc; c&ugrave;ng kh&oacute; xử. Ch&iacute;nh v&igrave; vậy, ứng dụng&nbsp;<a href="https://fptshop.com.vn/dien-thoai" target="_blank" title="điện thoại" type="điện thoại">điện thoại</a>&nbsp;Instagram đ&atilde; tung ra t&iacute;nh năng &ldquo;mute&quot; mới, gi&uacute;p bạn khắc phục điều bất lợi n&agrave;y.</p>

<p dir="ltr">Đ&uacute;ng như c&aacute;i t&ecirc;n, t&iacute;nh năng Mute cho ph&eacute;p bạn bỏ qua những b&agrave;i post của người đ&oacute; tr&ecirc;n feed của m&igrave;nh m&agrave; kh&ocirc;ng cần phải bỏ theo d&otilde;i họ. Để thực hiện t&iacute;nh năng n&agrave;y, bạn chỉ cần nhấn v&agrave;o n&uacute;t menu ở g&oacute;c của b&agrave;i đăng từ t&agrave;i khoản bạn muốn ẩn v&agrave; sau đ&oacute; chọn t&ugrave;y chọn &ldquo;Ẩn&rdquo;.</p>

<p dir="ltr"><strong><img alt="Cách ẩn người khác trên Instagram" id="Cách ẩn người khác trên Instagram" longdesc="https://fptshop.com.vn/tin-tuc/tin-moi/C%C3%A1ch%20%E1%BA%A9n%20ng%C6%B0%E1%BB%9Di%20kh%C3%A1c%20tr%C3%AAn%20Instagram" src="https://fptshop.com.vn/uploads/images/tin-tuc/70127/Originals/tinh-nang-mute-instagram-2.jpg" title="Cách ẩn người khác trên Instagram" /></strong></p>

<p dir="ltr">Từ thời điểm đ&oacute; trở đi, bạn sẽ vẫn theo d&otilde;i họ, vẫn c&oacute; thể xem ảnh tr&ecirc;n trang hồ sơ của họ v&agrave; nhận th&ocirc;ng b&aacute;o về comment hoặc b&agrave;i đăng mới m&agrave; bạn được tag. Nhưng b&agrave;i đăng của họ sẽ kh&ocirc;ng hiển thị tr&ecirc;n Instagram feed của bạn. Nếu muốn bạn c&oacute; thể bỏ chọn mute n&agrave;y bằng c&aacute;ch l&agrave;m ngược lại như tr&ecirc;n l&agrave; xong.</p>
', N'Mới đây mạng xã hội hình ảnh lớn nhất thế giới lại tung thêm 1 tính năng mới nữa!', N'Dạo gần đây Instagram có nhiều bước chuyển mình thú vị, từ việc hỗ trợ các chủ tài khoản doanh nghiệp cho tới các người dùng phổ thông cũng được Instagram chăm sóc. Mới đây mạng xã hội hình ảnh lớn nhất thế giới lại tung thêm 1 tính năng mới nữa!')
INSERT [dbo].[BaiViet] ([ID], [TenBaiViet], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [ViewCount], [MoreImage], [NoiDung], [TieuDeBaiViet], [MoTa]) VALUES (8, N'12321', 1, CAST(N'2018-05-20 20:36:42.637' AS DateTime), N'Duong', NULL, NULL, 0, N'/ckfinder/userfiles/images/12512636_596175790543840_7992047986365504491_n.jpg', NULL, 0, NULL, NULL, N'432', N'32')
INSERT [dbo].[BaiViet] ([ID], [TenBaiViet], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [ViewCount], [MoreImage], [NoiDung], [TieuDeBaiViet], [MoTa]) VALUES (9, N'Tieu de', 5, CAST(N'2018-05-20 20:43:59.267' AS DateTime), N'Duong', CAST(N'2018-05-21 01:25:05.797' AS DateTime), N'Duong', 0, N'/ckfinder/userfiles/images/6570704-Coffee-love-vector-Stock-Vector-coffee-logo-cafe.jpg', NULL, 0, NULL, N'<p>DuongDuongDuongDuongDuongDuong</p>
', N'sadsad', N'213')
INSERT [dbo].[BaiViet] ([ID], [TenBaiViet], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [ViewCount], [MoreImage], [NoiDung], [TieuDeBaiViet], [MoTa]) VALUES (10, N'Hướng dẫn nhắn tin tự hủy, bảo mật hai chiều trên Messenger', 1, CAST(N'2018-05-24 15:32:09.107' AS DateTime), N'Duong', NULL, NULL, 1, N'/ckfinder/userfiles/images/Nhan-tin-ma-hoa-tren-Messenger-voi-secret-conversation-2.jpg', NULL, 0, NULL, N'<p><strong>Với t&iacute;nh năng Secret Conversation, bạn c&oacute; thể trao đổi những th&ocirc;ng tin quan trọng qua ứng dụng Messenger m&agrave; kh&ocirc;ng sợ bị lộ ra ngo&agrave;i.</strong></p>

<p><img alt="Cách sử dụng Messeger tránh bị Facebook quét tin nhắn (Ảnh 1)" id="Cách sử dụng Messeger tránh bị Facebook quét tin nhắn (Ảnh 1)" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/C%C3%A1ch%20s%E1%BB%AD%20d%E1%BB%A5ng%20Messeger%20tr%C3%A1nh%20b%E1%BB%8B%20Facebook%20qu%C3%A9t%20tin%20nh%E1%BA%AFn%20(%E1%BA%A2nh%201)" src="https://fptshop.com.vn/uploads/images/tin-tuc/68659/Originals/Nhan-tin-ma-hoa-tren-Messenger-voi-secret-conversation-1.jpg" title="Cách sử dụng Messeger tránh bị Facebook quét tin nhắn (Ảnh 1)" /></p>

<p>T&iacute;nh năng Secret Conversation đ&atilde; được Facebook bổ sung cho ứng dụng Messenger từ l&acirc;u, nhưng vẫn kh&aacute; &iacute;t người d&ugrave;ng biết v&agrave; sử dụng. Cụ thể t&iacute;nh năng n&agrave;y sẽ m&atilde; h&oacute;a tin nhắn từ người gửi v&agrave; người nhận, đồng thời c&ograve;n k&egrave;m khả năng nhắn tin tự hủy sẽ gi&uacute;p c&aacute;c th&ocirc;ng tin trao đổi được an to&agrave;n.</p>

<p>B&agrave;i viết n&agrave;y sẽ hướng dẫn c&aacute;c bạn sử dụng t&iacute;nh năng n&agrave;y để bảo mật hơn c&aacute;c th&ocirc;ng tin được trao đổi tr&ecirc;n Messenger.</p>

<p>Đầu ti&ecirc;n, c&aacute;c bạn v&agrave;o ứng dụng Messenger &gt; Chọn người nhận tin nhắn muốn sử dụng t&iacute;nh năng m&atilde; h&oacute;a</p>

<p><img alt="Cách sử dụng Messeger tránh bị Facebook quét tin nhắn (Ảnh 2)" id="Cách sử dụng Messeger tránh bị Facebook quét tin nhắn (Ảnh 2)" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/C%C3%A1ch%20s%E1%BB%AD%20d%E1%BB%A5ng%20Messeger%20tr%C3%A1nh%20b%E1%BB%8B%20Facebook%20qu%C3%A9t%20tin%20nh%E1%BA%AFn%20(%E1%BA%A2nh%202)" src="https://fptshop.com.vn/uploads/images/tin-tuc/68659/Originals/Nhan-tin-ma-hoa-tren-Messenger-voi-secret-conversation-2.jpg" title="Cách sử dụng Messeger tránh bị Facebook quét tin nhắn (Ảnh 2)" /></p>

<p>Sau đ&oacute; chọn v&agrave;o phần t&ecirc;n người nhắn tin &gt; Chọn v&agrave;o t&iacute;nh năng&nbsp;<em>&ldquo;Secret Conversation&rdquo;</em></p>

<p><img alt="Cách sử dụng Messeger tránh bị Facebook quét tin nhắn (Ảnh 3)" id="Cách sử dụng Messeger tránh bị Facebook quét tin nhắn (Ảnh 3)" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/C%C3%A1ch%20s%E1%BB%AD%20d%E1%BB%A5ng%20Messeger%20tr%C3%A1nh%20b%E1%BB%8B%20Facebook%20qu%C3%A9t%20tin%20nh%E1%BA%AFn%20(%E1%BA%A2nh%203)" src="https://fptshop.com.vn/uploads/images/tin-tuc/68659/Originals/Nhan-tin-ma-hoa-tren-Messenger-voi-secret-conversation-3.jpg" title="Cách sử dụng Messeger tránh bị Facebook quét tin nhắn (Ảnh 3)" /></p>

<p>Giờ bạn đ&atilde; k&iacute;ch hoạt được t&iacute;nh năng nhắn tin m&atilde; h&oacute;a. T&iacute;nh năng n&agrave;y thường được người d&ugrave;ng sử dụng để nhắn tin tự hủy, tuy nhi&ecirc;n n&oacute; c&ograve;n c&oacute; khả năng m&atilde; h&oacute;a để kh&ocirc;ng ai c&oacute; thể đọc được ngo&agrave;i người nhận v&agrave; người gửi.</p>

<p>Ở giao diện Secret Conversation ch&uacute;ng ta c&oacute; thể chọn thời gian tin nhắn tự hủy bằng c&aacute;ch chọn v&agrave;o biểu tượng đồng hồ b&ecirc;n cạnh khung chat. Hoặc chọn&nbsp;<em>&quot;Off&quot;</em>&nbsp;để tắt thời gian hủy tin nhắn.</p>

<p><img alt="Cách sử dụng Messeger tránh bị Facebook quét tin nhắn (Ảnh 4)" id="Cách sử dụng Messeger tránh bị Facebook quét tin nhắn (Ảnh 4)" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/C%C3%A1ch%20s%E1%BB%AD%20d%E1%BB%A5ng%20Messeger%20tr%C3%A1nh%20b%E1%BB%8B%20Facebook%20qu%C3%A9t%20tin%20nh%E1%BA%AFn%20(%E1%BA%A2nh%204)" src="https://fptshop.com.vn/uploads/images/tin-tuc/68659/Originals/Nhan-tin-ma-hoa-tren-Messenger-voi-secret-conversation-4.jpg" title="Cách sử dụng Messeger tránh bị Facebook quét tin nhắn (Ảnh 4)" /></p>

<p><strong>C&oacute; một v&agrave;i lưu &yacute; với t&iacute;nh năng n&agrave;y:</strong></p>

<p><em>- Chế độ n&agrave;y kh&ocirc;ng chỉ d&ugrave;ng để chat tin nhắn tự hủy, m&agrave; c&ograve;n d&ugrave;ng để m&atilde; h&oacute;a tin nhắn người d&ugrave;ng tr&aacute;nh bị Facebook đọc được.</em></p>

<p><em>- T&iacute;nh năng n&agrave;y chỉ hỗ trợ người d&ugrave;ng ứng dụng Messenger tr&ecirc;n điện thoại m&agrave; kh&ocirc;ng hỗ trợ người d&ugrave;ng m&aacute;y t&iacute;nh.</em></p>

<p><em>- Chỉ hỗ trợ chat c&aacute; nh&acirc;n, kh&ocirc;ng hỗ trợ chat nh&oacute;m</em></p>

<p><em>- Mỗi khi c&oacute; thiết bị mới n&agrave;o đọc được tin nhắn Secret th&igrave; bạn sẽ đều nhận được th&ocirc;ng b&aacute;o v&agrave; bạn cũng c&oacute; thể x&oacute;a bớt thiết bị đ&oacute; nếu muốn.</em></p>

<p>Mong rằng qua b&agrave;i viết n&agrave;y c&aacute;c bạn sẽ biết v&agrave; sử dụng t&iacute;nh năng n&agrave;y một c&aacute;ch hiệu quả. Nếu thấy c&oacute; &iacute;ch h&atilde;y chia sẻ cho bạn b&egrave; của m&igrave;nh c&ugrave;ng sử dụng nh&eacute;!</p>
', N'Hướng dẫn nhắn tin tự hủy, bảo mật hai chiều trên Messenger', N'Ứng dụng Messenger có tính năng nhắn tin bảo mật mà hầu hết người dùng đều không để ý đến. Bạn hoàn toàn có thể nhắn tin mã hóa, tự hủy trên Messenger.')
INSERT [dbo].[BaiViet] ([ID], [TenBaiViet], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [ViewCount], [MoreImage], [NoiDung], [TieuDeBaiViet], [MoTa]) VALUES (11, N'Hướng dẫn nhắn tin tự hủy, bảo mật hai chiều trên Messenger', 1, CAST(N'2018-05-24 15:32:50.667' AS DateTime), N'Duong', NULL, NULL, 1, N'/ckfinder/userfiles/images/tinh-nang-mute-instagram-1(1).jpg', NULL, 0, NULL, N'<p><strong>Với t&iacute;nh năng Secret Conversation, bạn c&oacute; thể trao đổi những th&ocirc;ng tin quan trọng qua ứng dụng Messenger m&agrave; kh&ocirc;ng sợ bị lộ ra ngo&agrave;i.</strong></p>

<p><img alt="Cách sử dụng Messeger tránh bị Facebook quét tin nhắn (Ảnh 1)" id="Cách sử dụng Messeger tránh bị Facebook quét tin nhắn (Ảnh 1)" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/C%C3%A1ch%20s%E1%BB%AD%20d%E1%BB%A5ng%20Messeger%20tr%C3%A1nh%20b%E1%BB%8B%20Facebook%20qu%C3%A9t%20tin%20nh%E1%BA%AFn%20(%E1%BA%A2nh%201)" src="https://fptshop.com.vn/uploads/images/tin-tuc/68659/Originals/Nhan-tin-ma-hoa-tren-Messenger-voi-secret-conversation-1.jpg" title="Cách sử dụng Messeger tránh bị Facebook quét tin nhắn (Ảnh 1)" /></p>

<p>T&iacute;nh năng Secret Conversation đ&atilde; được Facebook bổ sung cho ứng dụng Messenger từ l&acirc;u, nhưng vẫn kh&aacute; &iacute;t người d&ugrave;ng biết v&agrave; sử dụng. Cụ thể t&iacute;nh năng n&agrave;y sẽ m&atilde; h&oacute;a tin nhắn từ người gửi v&agrave; người nhận, đồng thời c&ograve;n k&egrave;m khả năng nhắn tin tự hủy sẽ gi&uacute;p c&aacute;c th&ocirc;ng tin trao đổi được an to&agrave;n.</p>

<p>B&agrave;i viết n&agrave;y sẽ hướng dẫn c&aacute;c bạn sử dụng t&iacute;nh năng n&agrave;y để bảo mật hơn c&aacute;c th&ocirc;ng tin được trao đổi tr&ecirc;n Messenger.</p>

<p>Đầu ti&ecirc;n, c&aacute;c bạn v&agrave;o ứng dụng Messenger &gt; Chọn người nhận tin nhắn muốn sử dụng t&iacute;nh năng m&atilde; h&oacute;a</p>

<p><img alt="Cách sử dụng Messeger tránh bị Facebook quét tin nhắn (Ảnh 2)" id="Cách sử dụng Messeger tránh bị Facebook quét tin nhắn (Ảnh 2)" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/C%C3%A1ch%20s%E1%BB%AD%20d%E1%BB%A5ng%20Messeger%20tr%C3%A1nh%20b%E1%BB%8B%20Facebook%20qu%C3%A9t%20tin%20nh%E1%BA%AFn%20(%E1%BA%A2nh%202)" src="https://fptshop.com.vn/uploads/images/tin-tuc/68659/Originals/Nhan-tin-ma-hoa-tren-Messenger-voi-secret-conversation-2.jpg" title="Cách sử dụng Messeger tránh bị Facebook quét tin nhắn (Ảnh 2)" /></p>

<p>Sau đ&oacute; chọn v&agrave;o phần t&ecirc;n người nhắn tin &gt; Chọn v&agrave;o t&iacute;nh năng&nbsp;<em>&ldquo;Secret Conversation&rdquo;</em></p>

<p><img alt="Cách sử dụng Messeger tránh bị Facebook quét tin nhắn (Ảnh 3)" id="Cách sử dụng Messeger tránh bị Facebook quét tin nhắn (Ảnh 3)" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/C%C3%A1ch%20s%E1%BB%AD%20d%E1%BB%A5ng%20Messeger%20tr%C3%A1nh%20b%E1%BB%8B%20Facebook%20qu%C3%A9t%20tin%20nh%E1%BA%AFn%20(%E1%BA%A2nh%203)" src="https://fptshop.com.vn/uploads/images/tin-tuc/68659/Originals/Nhan-tin-ma-hoa-tren-Messenger-voi-secret-conversation-3.jpg" title="Cách sử dụng Messeger tránh bị Facebook quét tin nhắn (Ảnh 3)" /></p>

<p>Giờ bạn đ&atilde; k&iacute;ch hoạt được t&iacute;nh năng nhắn tin m&atilde; h&oacute;a. T&iacute;nh năng n&agrave;y thường được người d&ugrave;ng sử dụng để nhắn tin tự hủy, tuy nhi&ecirc;n n&oacute; c&ograve;n c&oacute; khả năng m&atilde; h&oacute;a để kh&ocirc;ng ai c&oacute; thể đọc được ngo&agrave;i người nhận v&agrave; người gửi.</p>

<p>Ở giao diện Secret Conversation ch&uacute;ng ta c&oacute; thể chọn thời gian tin nhắn tự hủy bằng c&aacute;ch chọn v&agrave;o biểu tượng đồng hồ b&ecirc;n cạnh khung chat. Hoặc chọn&nbsp;<em>&quot;Off&quot;</em>&nbsp;để tắt thời gian hủy tin nhắn.</p>
', N'Hướng dẫn nhắn tin tự hủy, bảo mật hai chiều trên Messenger', N'Hướng dẫn nhắn tin tự hủy, bảo mật hai chiều trên Messenger')
INSERT [dbo].[BaiViet] ([ID], [TenBaiViet], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [ViewCount], [MoreImage], [NoiDung], [TieuDeBaiViet], [MoTa]) VALUES (12, N'YẾN MÃITHỦ THUẬTVIDEO HOTĐÁNH GIÁ - TƯ VẤNGÓC KHÁCH HÀNGSỰ KIỆN 12 thủ thuật đơn giản giúp bạn làm chủ Facebook Messenger', 1, CAST(N'2018-05-24 15:33:43.187' AS DateTime), N'Duong', NULL, NULL, 1, N'/ckfinder/userfiles/images/8-tinh-nang-moi-tren-facebook-fptshop-02.jpg', NULL, 0, NULL, N'<h2 dir="ltr"><strong>Facebook Messenger chắc hẳn đ&atilde; qu&aacute; quen thuộc với hầu hết người d&ugrave;ng nhưng kh&ocirc;ng phải ai cũng c&oacute; thể biết hết&nbsp;những t&iacute;nh năng ẩn v&ocirc; c&ugrave;ng hữu &iacute;ch dưới đ&acirc;y.</strong></h2>

<h3 dir="ltr"><strong>1. Chặn tin nhắn</strong></h3>

<p dir="ltr"><img alt="thủ thuật Messenger1" id="thủ thuật Messenger1" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/th%E1%BB%A7%20thu%E1%BA%ADt%20Messenger1" src="https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/Dung/0418/thuthuatmessenger/Messenger-1_1.jpg" title="thủ thuật Messenger1" /></p>

<p dir="ltr">Khi bạn muốn chấm dứt li&ecirc;n lạc với một người n&agrave;o đ&oacute; th&igrave; c&aacute;ch tốt nhất l&agrave; chặn tin nhắn. Đ&acirc;y l&agrave; một&nbsp;<a href="https://fptshop.com.vn/tin-tuc/danh-gia/facebook-api-la-gi-tai-sao-gioi-kinh-doanh-online-tai-viet-nam-lai-dang-nao-loan-vi-platform-nay-68290" target="_blank">t&iacute;nh năng hữu &iacute;ch tr&ecirc;n Messenger</a>&nbsp;m&agrave; bạn c&oacute; thể &aacute;p dụng trong trường hợp cần thiết.</p>

<p dir="ltr">C&aacute;ch thực hiện rất đơn giản, bạn chỉ cần nhấn giữ v&agrave;o cuộc tr&ograve; chuyện cần chặn, chọn chặn. Sau đ&oacute; gạt n&uacute;t chặn tất cả tin nhắn. Vậy l&agrave; bạn đ&atilde; thực hiện xong c&ocirc;ng việc chặn tin nhắn từ người kh&ocirc;ng mong muốn.</p>

<h3 dir="ltr"><strong>2. Tắt th&ocirc;ng b&aacute;o cho cuộc tr&ograve; chuyện</strong></h3>

<p dir="ltr"><img alt="thủ thuật Messenger2 " id="thủ thuật Messenger2 " longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/th%E1%BB%A7%20thu%E1%BA%ADt%20Messenger2" src="https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/Dung/0418/thuthuatmessenger/messenger-2_1.jpg" title="thủ thuật Messenger2 " /></p>

<p dir="ltr"><img alt="thủ thuật Messenger2.2" id="thủ thuật Messenger2.2" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/th%E1%BB%A7%20thu%E1%BA%ADt%20Messenger2.2" src="https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/Dung/0418/thuthuatmessenger/messenger-2_2.jpg" title="thủ thuật Messenger2.2" /></p>

<p dir="ltr">Nếu một ng&agrave;y đẹp trời bạn &ldquo;đổi &yacute;&quot; kh&ocirc;ng c&ograve;n muốn quan t&acirc;m đến một cuộc hội thoại n&agrave;o đ&oacute; trong Messenger của m&igrave;nh th&igrave; đ&acirc;y l&agrave; c&aacute;ch bạn tr&aacute;nh bị l&agrave;m phiền trong một khoảng thời gian tạm thời:&nbsp;<em>Nhấn v&agrave; giữ chọn cuộc hội thoại&nbsp; &gt;&gt;&nbsp;&nbsp;</em>&nbsp;<em>chọn ẩn th&ocirc;ng b&aacute;o</em>, sau đ&oacute; sẽ c&oacute; một hộp thoại hiển thị thời gian bạn muốn ẩn cuộc hội thoại đ&oacute;, v&agrave;&nbsp;<em>nhấn ok</em>.</p>

<h3 dir="ltr"><strong>3. Tắt bớt c&aacute;c th&ocirc;ng tin ri&ecirc;ng tư</strong></h3>

<p dir="ltr"><img alt="thủ thuật Messenger3" id="thủ thuật Messenger3" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/th%E1%BB%A7%20thu%E1%BA%ADt%20Messenger3" src="https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/Dung/0418/thuthuatmessenger/Messenger-3.jpg" title="thủ thuật Messenger3" /></p>

<p dir="ltr">Mặc định, Facebook Messenger sẽ hiển thị th&ocirc;ng b&aacute;o k&egrave;m nội dung ngay tr&ecirc;n m&agrave;n h&igrave;nh kh&oacute;a, nếu kh&ocirc;ng muốn người kh&aacute;c đọc được, bạn h&atilde;y truy cập v&agrave;o&nbsp;<em>Settings (c&agrave;i đặt)</em>&nbsp; &gt;&gt;&nbsp;&nbsp;<em>Notifications (th&ocirc;ng b&aacute;o)</em>, t&igrave;m đến ứng dụng Messenger v&agrave; v&ocirc; hiệu h&oacute;a t&ugrave;y chọn<em>&nbsp;Show Preview</em>&nbsp;(hiển thị tr&ecirc;n trang b&igrave;a).</p>

<h3 dir="ltr"><strong>4. Hiển thị người đ&atilde; xem tin nhắn trong nh&oacute;m</strong></h3>

<p dir="ltr"><img alt="thủ thuật Messenger4" id="thủ thuật Messenger4" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/th%E1%BB%A7%20thu%E1%BA%ADt%20Messenger4" src="https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/Dung/0418/thuthuatmessenger/Messenger-4.png" title="thủ thuật Messenger4" /></p>

<p dir="ltr">Thật kh&oacute; chịu khi bạn kh&ocirc;ng thể biết ai đ&atilde; đọc tin nhắn trong Group chat của m&igrave;nh hay chưa phải kh&ocirc;ng? Đ&acirc;y l&agrave; c&aacute;ch để bạn biết được điều đ&oacute;: Đầu ti&ecirc;n bạn nhấn v&agrave; giữ d&ograve;ng tin nhắn cần xem &nbsp;&gt;&gt; &ldquo;Chi tiết&quot; trong hộp thoại đ&oacute; v&agrave; n&oacute; sẽ hiện l&ecirc;n danh s&aacute;ch t&ecirc;n đ&atilde; xem tin nhắn của bạn cho bạn biết.</p>

<h3 dir="ltr"><strong>5. Gửi ảnh Gift, video qua Mesenger</strong></h3>

<p dir="ltr"><img alt="thủ thuật Messenger5" id="thủ thuật Messenger5" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/th%E1%BB%A7%20thu%E1%BA%ADt%20Messenger5" src="https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/Dung/0418/thuthuatmessenger/Messenger-5.jpg" title="thủ thuật Messenger5" /></p>

<p dir="ltr">Khi bấm v&agrave;o biểu tượng dấu cộng trong cửa sổ tr&ograve; chuyện, bạn sẽ thấy xuất hiện th&ecirc;m một loạt c&aacute;c ứng dụng đặc biệt cho ph&eacute;p gửi ảnh động (GIF), vị tr&iacute;, kế hoạch, video, chụp ảnh nhanh&hellip; với bạn b&egrave; b&ecirc;n cạnh c&aacute;c biểu tượng cảm x&uacute;c v&agrave; sticker.</p>

<h3 dir="ltr"><strong>6. Tắt bong b&oacute;ng chat</strong></h3>

<p dir="ltr"><img alt="thủ thuật Messenger6.1" id="thủ thuật Messenger6.1" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/th%E1%BB%A7%20thu%E1%BA%ADt%20Messenger6.1" src="https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/Dung/0418/thuthuatmessenger/Messenger-6_1.png" title="thủ thuật Messenger6.1" /></p>

<p dir="ltr"><img alt="thủ thuật Messenger6.2" id="thủ thuật Messenger6.2" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/th%E1%BB%A7%20thu%E1%BA%ADt%20Messenger6.2" src="https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/Dung/0418/thuthuatmessenger/Messenger-6_2.png" title="thủ thuật Messenger6.2" /></p>

<p dir="ltr">Một t&iacute;nh năng kh&aacute; hữu &iacute;ch cho người d&ugrave;ng khi m&agrave; bạn muốn kết th&uacute;c cuộc tr&ograve; chuyện chỉ cần bạn k&eacute;o v&agrave; thả xuống dưới c&ugrave;ng để tắt cuộc hội thoại đi l&agrave; xong. Chat Head l&agrave; một t&iacute;nh năng rất được ưa th&iacute;ch từ người d&ugrave;ng. Tuy nhi&ecirc;n, nếu bạn cảm thấy kh&ocirc;ng th&iacute;ch th&uacute; cho lắm th&igrave; bạn l&agrave;m theo c&aacute;ch sau để tắt n&oacute; nh&eacute;:&nbsp;<em>Nhấn v&agrave;o biểu tượng h&igrave;nh b&aacute;nh răng</em>&nbsp; &gt;&gt;&nbsp;&nbsp;<em>K&eacute;o tắt thanh trượt &ldquo;H&igrave;nh đại diện khi tr&ograve; chuyện&quot; về b&ecirc;n tr&aacute;i</em>&nbsp;l&agrave; bạn đ&atilde; tắt t&iacute;nh năng bong b&oacute;ng chat th&agrave;nh c&ocirc;ng.</p>

<h3 dir="ltr"><strong>7. Đ&aacute;nh dấu l&agrave; chưa đọc</strong></h3>

<p dir="ltr"><img alt="thủ thuật Messenger7" id="thủ thuật Messenger7" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/th%E1%BB%A7%20thu%E1%BA%ADt%20Messenger7" src="https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/Dung/0418/thuthuatmessenger/Messenger-7.png" title="thủ thuật Messenger7" /></p>

<p dir="ltr">Nếu bạn đang bận c&ocirc;ng việc m&agrave; chưa kịp thời trả lời tin nhắn của người kh&aacute;c th&igrave; bạn c&oacute; thể đ&aacute;nh dấu lại cuộc tr&ograve; chuyện đ&oacute; ph&ograve;ng khi bạn qu&ecirc;n kh&ocirc;ng trả lời họ th&igrave; chỉ cần Nhấn v&agrave; giữ v&agrave;o tin nhắn &gt;&gt; Xuất hiện hộp thoại v&agrave; chọn &ldquo;Đ&aacute;nh dấu l&agrave; chưa đọc&quot;.</p>

<h3 dir="ltr"><strong>8. Gửi tin nhắn &acirc;m thanh</strong></h3>

<p dir="ltr"><img alt="thủ thuật Messenger8" id="thủ thuật Messenger8" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/th%E1%BB%A7%20thu%E1%BA%ADt%20Messenger8" src="https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/Dung/0418/thuthuatmessenger/Messenger-8.jpg" title="thủ thuật Messenger8" /></p>

<p dir="ltr">Bạn đ&atilde; nh&agrave;m ch&aacute;n với kiểu nhắn tin truyền thống phải kh&ocirc;ng? Sẽ tuyệt hơn nếu bạn &ldquo;chat&rdquo; với bạn b&egrave; m&agrave; lại k&egrave;m theo lời n&oacute;i th&igrave; cuộc tr&ograve; chuyện đ&oacute; sẽ th&ecirc;m th&uacute; vị hơn nhiều. Để thực hiện n&oacute;, bạn&nbsp;<em>nhấn v&agrave;o biểu tượng micro</em>&nbsp; &gt;&gt; &nbsp;<em>Sau đ&oacute; nhấn v&agrave;o biểu tượng ghi &acirc;m m&agrave;u đỏ</em>&nbsp;v&agrave; bắt đầu ghi &acirc;m. Sau đ&oacute; tự động n&oacute; sẽ gửi đi ngay khi kết th&uacute;c đoạn ghi &acirc;m của bạn.</p>

<h3 dir="ltr"><strong>9. Sử dụng Messenger kh&ocirc;ng cần t&agrave;i khoản Facebook</strong></h3>

<p dir="ltr"><img alt="thủ thuật Messenger9" id="thủ thuật Messenger9" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/th%E1%BB%A7%20thu%E1%BA%ADt%20Messenger9" src="https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/Dung/0418/thuthuatmessenger/Messenger-9.jpg" title="thủ thuật Messenger9" /></p>

<p dir="ltr">Điểm th&iacute;ch khi sử dụng Messenger l&agrave; bạn kh&ocirc;ng cần t&agrave;i khoản Facebook. Bạn c&oacute; thể d&ugrave;ng số điện thoại của m&igrave;nh để đăng nhập v&agrave; sử dụng. T&ugrave;y chọn n&agrave;y bạn c&oacute; thể thấy (Tiếp tục với số điện thoại) khi lần đầu sử dụng v&agrave; đăng nhập.</p>

<h3 dir="ltr"><strong>10. T&igrave;m kiếm cuộc tr&ograve; chuyện</strong></h3>

<p dir="ltr"><img alt="thủ thuật Messenger10" id="thủ thuật Messenger10" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/th%E1%BB%A7%20thu%E1%BA%ADt%20Messenger10" src="https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/Dung/0418/thuthuatmessenger/Messenger10.png" title="thủ thuật Messenger10" /></p>

<p dir="ltr">C&oacute; thể bạn muốn t&igrave;m cuộc tr&ograve; chuyện n&agrave;o đ&oacute; đ&atilde; rất l&acirc;u rồi. B&igrave;nh thường nếu bạn lướt t&igrave;m th&igrave; mất rất nhiều thời gian. Tuy nhi&ecirc;n bạn chỉ cần&nbsp;<em>Bấm v&agrave;o dấu cộng tr&ecirc;n ứng dụng Messenger&nbsp;&nbsp;</em>&gt;&gt;&nbsp;<em>&nbsp;Thanh t&igrave;m kiếm xuất hiện</em>&nbsp;v&agrave; bạn g&otilde; t&ecirc;n m&agrave; m&igrave;nh muốn t&igrave;m. To&agrave;n bộ cuộc tr&ograve; chuyện trước đ&oacute; sẽ tự hiện ra ngay lập tức.</p>

<h3 dir="ltr"><strong>11. Tắt t&iacute;nh năng tự động lưu ảnh</strong></h3>

<p dir="ltr"><img alt="thủ thuật Messenger11" id="thủ thuật Messenger11" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/th%E1%BB%A7%20thu%E1%BA%ADt%20Messenger11" src="https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/Dung/0418/thuthuatmessenger/Messenger-11.png" title="thủ thuật Messenger11" /></p>

<p dir="ltr">T&iacute;nh năng n&agrave;y đ&ocirc;i khi lại g&acirc;y nặng cho bộ nhớ điện thoại khi m&agrave; ch&uacute;ng sẽ tự động lưu bất kể h&igrave;nh n&agrave;o m&agrave; bạn xem qua. Để t&aacute;t n&oacute;, bạn chỉ cần&nbsp;<em>Nhấn v&agrave;o biểu tượng b&aacute;nh răng&nbsp;&nbsp;</em>&gt;&gt;&nbsp;&nbsp;<em>Chọn ảnh v&agrave; phương tiện</em>&nbsp; &gt;&gt;&nbsp;&nbsp;<em>K&eacute;o cần trượt về ph&iacute;a tay tr&aacute;i</em>. T&iacute;nh năng tự động lưu ảnh sẽ được tắt.</p>

<h3 dir="ltr"><strong>12. Đ&aacute;nh dấu Spam</strong></h3>

<p dir="ltr"><img alt="thủ thuật Messenger12" id="thủ thuật Messenger12" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/th%E1%BB%A7%20thu%E1%BA%ADt%20Messenger12" src="https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/Dung/0418/thuthuatmessenger/Messenger-12.png" title="thủ thuật Messenger12" /></p>

<p dir="ltr">Ai đ&oacute; đang cố l&agrave;m phiền bạn bằng những tin nhắn thường xuy&ecirc;n g&acirc;y kh&oacute; chịu cho bạn. C&aacute;ch nhanh nhất để loại bỏ phiền to&aacute;i đ&oacute; l&agrave;&nbsp;<em>Nhấn v&agrave; giữ v&agrave;o tin nhắn</em>&nbsp; &gt;&gt;&nbsp;&nbsp;<em>Hộp thoại sau sẽ xuất hiện</em>&nbsp; &gt;&gt;&nbsp;&nbsp;<em>Đ&aacute;nh dấu l&agrave; spam</em>. V&agrave; giờ bạn kh&ocirc;ng phải bận t&acirc;m đến n&oacute; nữa.</p>
', N'YẾN MÃITHỦ THUẬTVIDEO HOTĐÁNH GIÁ - TƯ VẤNGÓC KHÁCH HÀNGSỰ KIỆN 12 thủ thuật đơn giản giúp bạn làm chủ Facebook Messenger', N'YẾN MÃITHỦ THUẬTVIDEO HOTĐÁNH GIÁ - TƯ VẤNGÓC KHÁCH HÀNGSỰ KIỆN
12 thủ thuật đơn giản giúp bạn làm chủ Facebook Messenger')
INSERT [dbo].[BaiViet] ([ID], [TenBaiViet], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [ViewCount], [MoreImage], [NoiDung], [TieuDeBaiViet], [MoTa]) VALUES (13, N'[Thủ thuật Android] Cách để chặn người khác biết mình "đã xem" trên Facbeook Messenger', 6, CAST(N'2018-05-24 15:34:35.780' AS DateTime), N'Duong', CAST(N'2018-06-02 23:54:11.020' AS DateTime), N'Duong', 1, N'/ckfinder/userfiles/images/8-tinh-nang-moi-tren-facebook-fptshop-02.jpg', NULL, 0, NULL, N'<p dir="ltr"><strong>Đối với laptop c&aacute;ch l&agrave;m n&agrave;y sẽ dễ hơn rất nhiều, nhưng với&nbsp;<a href="https://fptshop.com.vn/dien-thoai" target="_blank">điện thoại Android</a>&nbsp;th&igrave; lại l&agrave; chuyện kh&aacute;c. Tuy vậy, n&oacute; cũng sẽ kh&ocirc;ng qu&aacute; kh&oacute; khăn để thực hiện v&agrave; đ&acirc;y sẽ l&agrave; một thủ thuật nhỏ để gi&uacute;p cho bạn &ldquo;trẻ tr&acirc;u&rdquo; hơn. :))</strong></p>

<p dir="ltr">&nbsp;</p>

<p dir="ltr"><strong><img alt="Unseen" id="Unseen" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/Unseen" src="https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/PhuocSang/ThuThuat/unseen/Unseen(1).png" title="Unseen" /></strong></p>

<p dir="ltr">Về cơ bản phương ph&aacute;p n&agrave;y sẽ sử dụng một phần mềm chuy&ecirc;n biệt để đọc nội dung tin nhắn đến v&agrave; cho bạn xem r&otilde; nội dung của to&agrave;n bộ tin nhắn thay v&igrave; chỉ lướt xem được một phần từ thanh th&ocirc;ng b&aacute;o. C&aacute;c bước thực hiện cũng tương đối đơn giản như sau:</p>

<p dir="ltr"><em><strong>Bước 1:&nbsp;</strong></em>Tải v&agrave; c&agrave;i đặt ứng dụng&nbsp;<strong>Unseen&nbsp;</strong><a href="https://play.google.com/store/apps/details?id=com.tda.unseen" rel="nofollow" target="_blank" title="unseen" type="unseen">tại đ&acirc;y</a>.</p>

<p dir="ltr">&nbsp;</p>

<p dir="ltr"><iframe frameborder="0" height="480" src="https://www.youtube.com/embed/K4dJdLgA53c" width="853"></iframe></p>

<p dir="ltr">&nbsp;</p>

<p dir="ltr"><strong><em>Bước 2:</em>&nbsp;</strong><em>Open Unseen</em>&nbsp;v&agrave; lướt qua m&agrave;n giới thiệu cơ bản của phần mềm. Tại đ&acirc;y ứng dụng sẽ giới thiệu đến bạn những thứ n&oacute; c&oacute; thể l&agrave;m v&agrave; l&agrave;m như thế n&agrave;o.</p>

<p dir="ltr"><img alt="unseen" id="unseen" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/unseen" src="https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/PhuocSang/ThuThuat/unseen/Unseen(2).jpg" title="unseen" /></p>

<p dir="ltr"><em><strong>Bước 3:</strong></em>&nbsp;T&ugrave;y chọn những phần mềm bạn muốn bật chức năng Unseen. Ngo&agrave;i&nbsp;<strong>Facebook</strong>, phần mềm n&agrave;y c&ograve;n cho ph&eacute;p bạn c&oacute; thể tắt &ldquo;<em>seen</em>&rdquo; cho<strong>&nbsp;Whatapp, Viber,&nbsp;</strong>&hellip;</p>

<p dir="ltr"><img alt="unseen" id="unseen" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/unseen" src="https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/PhuocSang/ThuThuat/unseen/Unseen(4).jpg" title="unseen" /></p>

<p dir="ltr"><strong><em>Bước 4:</em></strong>&nbsp;Bật&nbsp;<em>Quyền truy cập th&ocirc;ng b&aacute;o</em>&nbsp;ứng dụng.</p>

<p dir="ltr"><img alt="unseen" id="unseen" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/unseen" src="https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/PhuocSang/ThuThuat/unseen/Unseen(6).jpg" title="unseen" /></p>

<p dir="ltr">&rarr; Đ&acirc;y l&agrave; một điều kiện ti&ecirc;n quyết để&nbsp;<em>Unseen&nbsp;</em>c&oacute; thể đọc được nội dung&nbsp;<strong>Messenger&nbsp;</strong>v&agrave; cho bạn biết r&otilde; nội dung của cuộc tr&ograve; chuyện m&agrave; kh&ocirc;ng cần mở&nbsp;<strong>FB Messenger</strong>&nbsp;l&ecirc;n.</p>

<p dir="ltr">Như vậy l&agrave; bạn đ&atilde; c&oacute; thể ho&agrave;n tất qu&aacute; tr&igrave;nh thiết đặt cho&nbsp;<em>Unseen&nbsp;</em>&rarr; Kể từ b&acirc;y giờ bất cứ tin nhắn n&agrave;o được gửi đến Messenger của bạn sẽ được phần mềm n&agrave;y tổng hợp đầy đủ v&agrave; cho ph&eacute;p bạn đọc một kh&aacute;c thoải m&aacute;i nội dung của cuộc tr&ograve; chuyện m&agrave; kh&ocirc;ng cần lo lắng đến việc đối phương c&oacute; thấy bạn &ldquo;<em>Đ&atilde; xem</em>&rdquo; hay kh&ocirc;ng.</p>

<p dir="ltr">B&ecirc;n cạnh đ&oacute;, Unseen c&oacute; được những t&iacute;nh năng vui vẻ gi&uacute;p cho qu&aacute; tr&igrave;nh sử dụng v&agrave; nhắn tin của bạn trở n&ecirc;n đơn giản v&agrave; dễ d&agrave;ng hơn. Cụ thể;</p>

<p dir="ltr">&nbsp; &nbsp; &nbsp; &nbsp; - Hiện&nbsp;<em>chat-head</em>&nbsp;tin nhắn đến tương tự như&nbsp;<em>chat-head</em>&nbsp;của&nbsp;<em>Messenger.</em></p>

<p dir="ltr"><em><img alt="unseen" id="unseen" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/unseen" src="https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/PhuocSang/ThuThuat/unseen/Unseen(10).png" title="unseen" /></em></p>

<p dir="ltr">&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;- Liệt k&ecirc; những cuộc hội thoại của từng ứng dụng nhắn tin kh&aacute;c nhau &rarr; Gi&uacute;p người d&ugrave;ng dễ quản l&yacute; nội dung hơn.</p>

<p dir="ltr"><img alt="unseen" id="unseen" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/unseen" src="https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/PhuocSang/ThuThuat/unseen/Unseen(11).png" title="unseen" /></p>

<p dir="ltr">&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;- Hỗ trợ truyền tải nội dung<em>&nbsp;media (h&igrave;nh ảnh, video, &acirc;m thanh, &hellip;)</em>&nbsp;trực tiếp tr&ecirc;n ứng dụng.</p>

<p dir="ltr">&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;- &hellip;.</p>

<p dir="ltr"><img alt="unseen" id="unseen" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/unseen" src="https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/PhuocSang/ThuThuat/unseen/Unseen(12).jpg" title="unseen" /></p>

<p dir="ltr">Đặc biệt nếu bạn bấm v&agrave;o d&ograve;ng chữ&nbsp;<em>Reply in Messenger/Whatapps/&hellip;</em>&nbsp;trong m&agrave;n h&igrave;nh&nbsp;<a href="https://fptshop.com.vn/tin-tuc/thu-thuat/[thu-thuat-android]-cach-de-chan-nguoi-khac-biet-minh-da-xem-tren-facbeook-messenger-67873" target="_blank">cuộc hội thoại Unseen</a>&nbsp;sẽ hiển thị cảnh b&aacute;o rằng người nhắn tin với bạn sẽ thấy được bạn đ&atilde; &ldquo;seen&rdquo; tin nhắn của họ. Đ&acirc;y r&otilde; r&agrave;ng l&agrave; một t&iacute;nh năng cần thiết, để ph&ograve;ng trường hợp bạn lỡ tay bấm v&agrave;o n&oacute; v&agrave; lộ hết kế hoạch.</p>
', N'Là người dùng Facebook, chắc hẳn bạn đã không ít lần nghĩ cách làm sao để đọc được toàn bộ tin nhắn của bạn bè gửi tới mà họ không hề hay biết bạn đã “seen” hay chưa. Và bài viết dưới đây sẽ giúp bạn làm điều này một cách rất đơn giản.', N'Là người dùng Facebook, chắc hẳn bạn đã không ít lần nghĩ cách làm sao để đọc được toàn bộ tin nhắn của bạn bè gửi tới mà họ không hề hay biết bạn đã “seen” hay chưa. Và bài viết dưới đây sẽ giúp bạn làm điều này một cách rất đơn giản.')
INSERT [dbo].[BaiViet] ([ID], [TenBaiViet], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [ViewCount], [MoreImage], [NoiDung], [TieuDeBaiViet], [MoTa]) VALUES (14, N'[Thủ thuật] Tăng tốc khởi động máy tính hiệu quả trên Windows 10', 1, CAST(N'2018-05-24 15:35:19.367' AS DateTime), N'Duong', CAST(N'2018-06-08 23:06:34.557' AS DateTime), N'Duong', 1, N'/ckfinder/userfiles/images/Nhan-tin-ma-hoa-tren-Messenger-voi-secret-conversation-2.jpg', NULL, 0, NULL, N'<h2><strong><a href="https://fptshop.com.vn/phan-mem/windows-10-pro-32bit64bit-fpp" target="_blank">Windows 10</a>&nbsp;d&atilde; du?c t?i uu v? t?c d? kh?i d?ng, nhung b?n ho&agrave;n to&agrave;n c&oacute; th? tang t?c d? kh?i d?ng hon n?a v?i c&aacute;c th? thu?t du?i d&acirc;y.</strong></h2>

<p>&nbsp;</p>

<p><img alt="Th? thu?t tang t?c d? kh?i d?ng hi?u qu? Windows 10! (?nh 1)" id="Th? thu?t tang t?c d? kh?i d?ng hi?u qu? Windows 10! (?nh 1)" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/Th%E1%BB%A7%20thu%E1%BA%ADt%20t%C4%83ng%20t%E1%BB%91c%20%C4%91%E1%BB%99%20kh%E1%BB%9Fi%20%C4%91%E1%BB%99ng%20hi%E1%BB%87u%20qu%E1%BA%A3%20Windows%2010!%20(%E1%BA%A2nh%201)" src="https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/PSPVu/Th%C3%A1ng%202/Tang-toc-khoi-dong-Windows-10-1.jpg" title="Th? thu?t tang t?c d? kh?i d?ng hi?u qu? Windows 10! (?nh 1)" /></p>

<p>&nbsp;</p>

<p>Windows 10 d&atilde; du?c t?i uu v? nhi?u phuong di?n, c? v? t?c d? x? l&yacute; v&agrave; t?c d? kh?i d?ng m&aacute;y. Tuy nhi&ecirc;n, t?c d? kh?i d?ng m?c d?nh tr&ecirc;n Windows 10 v?n chua l&agrave; nhanh nh?t. N?u b?n mu?n t?c d? kh?i d?ng m&aacute;y t&iacute;nh tr&ecirc;n Windows 10 du?c nhanh hon th&igrave; h&atilde;y l&agrave;m theo c&aacute;c bu?c du?i d&acirc;y d? tang t?c d? kh?i d?ng nh&eacute;.</p>

<p>&nbsp;</p>

<h3><strong>1. B?t t&iacute;nh nang tang t?c kh?i d?ng tr&ecirc;n Windows 10 (Turn On Fast Startup)</strong></h3>

<p>&nbsp;</p>

<p>Ch?c h?n nhi?u ngu?i d&ugrave;ng Windows 10 kh&ocirc;ng bi?t r?ng tr&ecirc;n&nbsp;<a href="https://fptshop.com.vn/tin-tuc/thu-thuat/mot-so-thu-thuat-tang-toc-win-10-pc-51965" target="_blank">Windows 10 c&oacute; m?t t&iacute;nh nang tang t?c kh?i d?ng</a>&nbsp;d?a tr&ecirc;n ch? d? ng? d&ocirc;ng (Hibernate) v&agrave; qu&aacute; tr&igrave;nh t?t m&aacute;y (Shutdown) gi&uacute;p cho qu&aacute; tr&igrave;nh kh?i d?ng tr? n&ecirc;n nhanh hon so v?i m?c d?nh.</p>

<p>T&iacute;nh nang d&oacute; c&oacute; t&ecirc;n Fast Startup, l&agrave; m?t trong nh?ng t&iacute;nh nang du?c t&iacute;ch h?p t? Windows 8 t?i nay. Ð? k&iacute;ch ho?t t&iacute;nh nang n&agrave;y b?n h&atilde;y&nbsp;<em>Ch?n ph?i chu?t v&agrave;o bi?u tu?ng pin ? g&oacute;c ph&iacute;a du?i b&ecirc;n ph?i m&agrave;n h&igrave;nh v&agrave; ch?n &ldquo;Power Options&rdquo; &gt; Ch?n &ldquo;Choose what the power buttons do&rdquo; &gt; Ch?n &ldquo;Change settings that are currently unavailable&rdquo; &gt; Ch?n &ldquo;Turn on fast startup (recommend)&rdquo; &gt; Sau d&oacute; ch?n &ldquo;Save changes&rdquo; d? luu l?i thay d?i</em>.</p>

<p><strong>Luu &yacute;:</strong></p>

<p><em>- N?u kh&ocirc;ng th? t&iacute;ch ch?n t&iacute;nh nang n&agrave;y, b?n h&atilde;y m? CMD v?i quy?n Administrator r?i nh?p powercfg /hibernate on, sau d&oacute; nh?n Enter.</em></p>

<p><em>- C&oacute; m?t s? thi?t b? s? g?p l?i m&agrave;n h&igrave;nh den khi kh?i d?ng. N?u b?n dang d&ugrave;ng ? c?ng HDD th&igrave; h&atilde;y s? d?ng, n?u g?p l?i nhu tr&ecirc;n th&igrave; t?t ch?c nang n&agrave;y.</em></p>

<p>&nbsp;</p>

<p><img alt="Th? thu?t tang t?c d? kh?i d?ng hi?u qu? Windows 10! (?nh 2)" id="Th? thu?t tang t?c d? kh?i d?ng hi?u qu? Windows 10! (?nh 2)" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/Th%E1%BB%A7%20thu%E1%BA%ADt%20t%C4%83ng%20t%E1%BB%91c%20%C4%91%E1%BB%99%20kh%E1%BB%9Fi%20%C4%91%E1%BB%99ng%20hi%E1%BB%87u%20qu%E1%BA%A3%20Windows%2010!%20(%E1%BA%A2nh%202)" src="https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/PSPVu/Th%C3%A1ng%202/Tang-toc-khoi-dong-Windows-10-2.jpg" title="Th? thu?t tang t?c d? kh?i d?ng hi?u qu? Windows 10! (?nh 2)" /></p>

<p>&nbsp;</p>

<h3><strong>2. T?t b?t c&aacute;c ?ng d?ng kh?i d?ng c&ugrave;ng Windows 10</strong></h3>

<p>&nbsp;</p>

<p>C&aacute;c ?ng d?ng kh?i d?ng c&ugrave;ng Windows cung ch&iacute;nh l&agrave; nguy&ecirc;n nh&acirc;n khi?n Windows 10 tr? n&ecirc;n ch?m ch?m hon khi kh?i d?ng. Ch&uacute;ng ta c&oacute; th? t?t c&aacute;c ph?n m?m kh&ocirc;ng c?n thi?t di d? qu&aacute; tr&igrave;nh kh?i d?ng tr&ecirc;n Windows 10 du?c nhanh hon.</p>

<p>Ð? t?t c&aacute;c ?ng d?ng n&agrave;y c&aacute;c b?n v&agrave;o &ldquo;Task Manager&rdquo; b?ng c&aacute;ch&nbsp;<em>?n ph?i chu?t v&agrave;o thanh taskbar v&agrave; ch?n &ldquo;Task Manager&rdquo; ho?c ?n t? h?p ph&iacute;m &ldquo;Ctrl + Alt + Delete&rdquo; d? v&agrave;o Task Manager.</em></p>

<p><em>Sau d&oacute; chuy?n sang tab &ldquo;Startup&rdquo; &gt; Ch?n ph?i chu?t v&agrave;o c&aacute;c ?ng d?ng kh&ocirc;ng c?n thi?t v&agrave; ch?n &ldquo;Disable&rdquo;. Kh?i d?ng l?i d? thay d?i c&oacute; hi?u l?c.</em></p>

<p>&nbsp;</p>

<p><img alt="Th? thu?t tang t?c d? kh?i d?ng hi?u qu? Windows 10! (?nh 3)" id="Th? thu?t tang t?c d? kh?i d?ng hi?u qu? Windows 10! (?nh 3)" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/Th%E1%BB%A7%20thu%E1%BA%ADt%20t%C4%83ng%20t%E1%BB%91c%20%C4%91%E1%BB%99%20kh%E1%BB%9Fi%20%C4%91%E1%BB%99ng%20hi%E1%BB%87u%20qu%E1%BA%A3%20Windows%2010!%20(%E1%BA%A2nh%203)" src="https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/PSPVu/Th%C3%A1ng%202/Tang-toc-khoi-dong-Windows-10-3.jpg" title="Th? thu?t tang t?c d? kh?i d?ng hi?u qu? Windows 10! (?nh 3)" /></p>

<p>&nbsp;</p>

<h3><strong>3. N&acirc;ng thi?t b? ph?n c?ng: N&acirc;ng c?p RAM ho?c ? c?ng SSD</strong></h3>

<p>&nbsp;</p>

<p>V?i Windows 10 th&igrave; vi?c s? h?u 4GB RAM tr? l&ecirc;n l&agrave; t?t nh?t. C&ograve;n ? SSD s? gi&uacute;p cho m&aacute;y t&iacute;nh c?a b?n kh?i d?ng r?t nhanh, nhanh hon nhi?u so v?i ? HHD m&agrave; h?u h?t c&aacute;c thi?t b? m&aacute;y t&iacute;nh dang s? h?u.</p>

<p>&nbsp;</p>

<p><img alt="Th? thu?t tang t?c d? kh?i d?ng hi?u qu? Windows 10! (?nh 4)" id="Th? thu?t tang t?c d? kh?i d?ng hi?u qu? Windows 10! (?nh 4)" longdesc="https://fptshop.com.vn/tin-tuc/thu-thuat/Th%E1%BB%A7%20thu%E1%BA%ADt%20t%C4%83ng%20t%E1%BB%91c%20%C4%91%E1%BB%99%20kh%E1%BB%9Fi%20%C4%91%E1%BB%99ng%20hi%E1%BB%87u%20qu%E1%BA%A3%20Windows%2010!%20(%E1%BA%A2nh%204)" src="https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/PSPVu/Th%C3%A1ng%202/Tang-toc-khoi-dong-Windows-10-4.jpg" title="Th? thu?t tang t?c d? kh?i d?ng hi?u qu? Windows 10! (?nh 4)" /></p>

<p>&nbsp;</p>

<p>Tr&ecirc;n d&acirc;y l&agrave; nh?ng c&aacute;ch tang t?c kh?i d?ng m&aacute;y t&iacute;nh hi?u qu? nh?t tr&ecirc;n Windows 10. Mong r?ng th? thu?t tr&ecirc;n s? c&oacute; &iacute;ch cho b?n, ch&uacute;c b?n thao t&aacute;c th&agrave;nh c&ocirc;ng v&agrave; d?ng qu&ecirc;n chia s? v?i b?n b&egrave; c?a m&igrave;nh nh&eacute;!</p>
', N'[Thủ thuật] Tăng tốc khởi động máy tính hiệu quả trên Windows 10!', N'[Thủ thuật] Tăng tốc khởi động máy tính hiệu quả trên Windows 10!')
INSERT [dbo].[BaiViet] ([ID], [TenBaiViet], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [ViewCount], [MoreImage], [NoiDung], [TieuDeBaiViet], [MoTa]) VALUES (15, N'dsadsadsa', 1, CAST(N'2018-06-09 23:44:01.217' AS DateTime), N'Duong', NULL, NULL, 0, N'/ckfinder/userfiles/images/15095100_685454841622811_4163543674920329747_n.jpg', NULL, 0, NULL, N'<h3>Đ&aacute;nh gi&aacute; chi tiết Samsung Galaxy S8 Plus</h3>

<p><a href="https://fptshop.com.vn/dien-thoai/samsung-galaxy-s8-plus" target="_blank">Samsung S8 Plus</a>&nbsp;ra mắt đ&atilde; l&agrave;m h&agrave;i l&ograve;ng giới c&ocirc;ng nghệ lẫn người ti&ecirc;u d&ugrave;ng h&acirc;m mộ h&atilde;ng điện thoại danh tiếng đến từ H&agrave;n Quốc &ndash; Samsung. Thiết kế c&oacute; thể chưa được xem l&agrave; đột ph&aacute; ho&agrave;n to&agrave;n nhưng ngay từ c&aacute;i nh&igrave;n đầu ti&ecirc;n đ&atilde; mang lại cảm x&uacute;c th&aacute;n phục bởi sự sắc sảo, tinh tế đến từ chi tiết v&agrave; một m&agrave;n h&igrave;nh cong tr&agrave;n cạnh &ldquo;kh&ocirc;ng viền&rdquo; đ&aacute;ng ngạc nhi&ecirc;n. K&egrave;m theo l&agrave; nhiều t&iacute;nh năng đặc biệt th&uacute; vị nhằm n&acirc;ng cao trải nghiệm cho người d&ugrave;ng. S8 Plus hứa hẹn sẽ mang lại sự th&agrave;nh c&ocirc;ng mới cho Samsung trong năm nay.</p>

<h3>&nbsp;</h3>

<h3><strong>Thiết kế nổi bật v&agrave; sang trọng</strong></h3>

<p>&nbsp;</p>

<p><img alt="samsung-galaxy-s8-plus" longdesc="https://fptshop.com.vn/dien-thoai/samsung-galaxy-s8-plus" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/samsung-galaxy-s8-plus/samsung-galaxy-s8-plus-1.JPG" title="samsung-galaxy-s8-plus" /></p>

<p>&nbsp;</p>

<p>Trong khi thiết kế c&aacute;c d&ograve;ng smartphone hiện nay đa số đi theo lối m&ograve;n quen thuộc th&igrave; Galaxy S8 Plus vẫn tự tin kho&aacute;c l&ecirc;n m&igrave;nh một vẻ đẹp kh&oacute; cưỡng lại. Đ&oacute; l&agrave; sự tổng hợp của k&iacute;nh, kim loại v&agrave; một m&agrave;n h&igrave;nh lớn với viền &ldquo;v&ocirc; cực&rdquo;.</p>

<p>&nbsp;</p>

<p><img alt="samsung-galaxy-s8-plus" longdesc="https://fptshop.com.vn/dien-thoai/samsung-galaxy-s8-plus" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/samsung-galaxy-s8-plus/samsung-galaxy-s8-plus-3.JPG" title="samsung-galaxy-s8-plus" /></p>

<p>&nbsp;</p>

<p>Sự ho&agrave;n thiện cũng như tỉ mỉ đ&atilde; được Samsung thực hiện kh&aacute; ho&agrave;n hảo. Ở mặt trước, n&uacute;t Home vật l&yacute; đ&atilde; thay thế bằng n&uacute;t Home cảm ứng lực tr&ecirc;n m&agrave;n h&igrave;nh, c&ograve;n cảm biến v&acirc;n tay th&igrave; được chuyển sang mặt lưng m&aacute;y. Thiết kế n&agrave;y gi&uacute;p cho mặt trước sản phẩm phẳng v&agrave; gần như kh&ocirc;ng c&oacute; g&igrave; ngo&agrave;i m&agrave;n h&igrave;nh.</p>

<p>&nbsp;</p>

<h3><strong>M&agrave;n h&igrave;nh lớn với viền &ldquo;v&ocirc; cực&rdquo;</strong></h3>

<p>&nbsp;</p>

<p><img alt="samsung-galaxy-s8-plus" longdesc="https://fptshop.com.vn/dien-thoai/samsung-galaxy-s8-plus" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/samsung-galaxy-s8-plus/samsung-galaxy-s8-plus-2.JPG" title="samsung-galaxy-s8-plus" /></p>

<p>&nbsp;</p>

<p>M&agrave;n h&igrave;nh với k&iacute;ch thước 6.2 inch Super AMOLED độ ph&acirc;n giải QHD+ (1440 x 2960 pixel) th&igrave; c&oacute; thể kh&ocirc;ng cần b&agrave;n c&atilde;i về chất lượng hiển thị tr&ecirc;n Samsung S8 Plus nữa. Chắc chắn người d&ugrave;ng sẽ c&oacute; những h&igrave;nh ảnh, thước phim r&otilde; n&eacute;t v&agrave; lung linh nhất c&oacute; thể trong mọi điều kiện &aacute;nh s&aacute;ng. Điểm độc đ&aacute;o ch&iacute;nh l&agrave; thiết kế cong tr&agrave;n cạnh hai b&ecirc;n v&agrave; tối đa cho cả cạnh tr&ecirc;n, dưới khiến bạn sẽ nghĩ tr&ecirc;n tay đang cầm một tấm gương. Mặc d&ugrave; vậy th&igrave; tỷ lệ m&agrave;n h&igrave;nh được cho l&agrave; kh&aacute; thu&ocirc;n d&agrave;i, c&oacute; thể sẽ c&oacute; thao t&aacute;c bằng một tay.</p>
', N'sa', N'sda')
INSERT [dbo].[BaiViet] ([ID], [TenBaiViet], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [ViewCount], [MoreImage], [NoiDung], [TieuDeBaiViet], [MoTa]) VALUES (16, N'name', 1, CAST(N'2018-06-23 16:15:16.750' AS DateTime), N'', CAST(N'2018-06-23 16:15:16.750' AS DateTime), N'', 0, N'/ckfinder/userfiles/images/2017-10-12_190257.png', N'', 0, NULL, N'<p>conten</p>
', N'tieu de', N'mo ta')
SET IDENTITY_INSERT [dbo].[BaiViet] OFF
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (10, 3, 2, CAST(4124 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (11, 3, 2, CAST(2312 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (12, 3, 2, CAST(2312 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (13, 3, 2, CAST(2312 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (14, 3, 2, CAST(2312 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (15, 3, 2, CAST(2312 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (16, 12, 1, CAST(14200000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (16, 14, 2, CAST(29000000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (17, 13, 1, CAST(26900000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (17, 14, 5, CAST(29000000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (18, 14, 1, CAST(29000000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (19, 14, 1, CAST(29000000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (20, 14, 1, CAST(29000000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (21, 13, 1, CAST(26900000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (21, 14, 1, CAST(29000000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (22, 14, 1, CAST(29000000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (23, 14, 1, CAST(29000000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (24, 14, 1, CAST(29000000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (25, 14, 1, CAST(29000000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (1025, 13, 1, CAST(26900000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (1026, 12, 1, CAST(14200000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (1026, 13, 1, CAST(26900000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (1027, 12, 1, CAST(14200000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (1028, 12, 2, CAST(14200000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (1029, 16, 1, CAST(180000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (1030, 16, 2, CAST(180000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (1032, 16, 1, CAST(180000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (1033, 13, 1, CAST(26900000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (1033, 16, 1, CAST(180000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (1034, 12, 1, CAST(14200000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (1035, 13, 1, CAST(26900000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietHoaDon] ([ID], [IDSanPham], [SoLuong], [Gia]) VALUES (1036, 13, 1, CAST(26900000 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[DanhMucBaiViet] ON 

INSERT [dbo].[DanhMucBaiViet] ([ID], [TenDanhMuc], [ThuTu], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image]) VALUES (1, N'Công nghệ', 1, NULL, NULL, CAST(N'2018-06-08 23:05:49.303' AS DateTime), NULL, 1, NULL)
INSERT [dbo].[DanhMucBaiViet] ([ID], [TenDanhMuc], [ThuTu], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image]) VALUES (4, N'Chính trị', 5, NULL, NULL, CAST(N'2018-05-20 22:09:16.930' AS DateTime), NULL, 0, NULL)
INSERT [dbo].[DanhMucBaiViet] ([ID], [TenDanhMuc], [ThuTu], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image]) VALUES (5, N'Xã Hội', 3, NULL, NULL, NULL, NULL, 0, NULL)
INSERT [dbo].[DanhMucBaiViet] ([ID], [TenDanhMuc], [ThuTu], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image]) VALUES (6, N'Mẹo hay', 2, NULL, NULL, CAST(N'2018-05-24 15:26:23.233' AS DateTime), NULL, 1, NULL)
INSERT [dbo].[DanhMucBaiViet] ([ID], [TenDanhMuc], [ThuTu], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image]) VALUES (7, N'213', 312, NULL, NULL, NULL, NULL, 0, NULL)
INSERT [dbo].[DanhMucBaiViet] ([ID], [TenDanhMuc], [ThuTu], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image]) VALUES (8, N'Công nghệ', 1, NULL, NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[DanhMucBaiViet] ([ID], [TenDanhMuc], [ThuTu], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image]) VALUES (9, N'Xã hội', 2, CAST(N'2018-06-22 16:07:38.933' AS DateTime), N'', CAST(N'2018-06-22 16:07:38.933' AS DateTime), N'', 1, N'')
INSERT [dbo].[DanhMucBaiViet] ([ID], [TenDanhMuc], [ThuTu], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image]) VALUES (10, N'Xã hội', 2, CAST(N'2018-06-22 16:07:53.420' AS DateTime), N'', CAST(N'2018-06-22 16:07:53.420' AS DateTime), N'', 0, N'')
SET IDENTITY_INSERT [dbo].[DanhMucBaiViet] OFF
SET IDENTITY_INSERT [dbo].[DanhMucSanPham] ON 

INSERT [dbo].[DanhMucSanPham] ([ID], [TenDanhMuc], [ThuTu], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [PhuKien]) VALUES (1, N'Iphone face', 2, NULL, NULL, CAST(N'2018-05-24 15:57:18.607' AS DateTime), NULL, 1, NULL, 0)
INSERT [dbo].[DanhMucSanPham] ([ID], [TenDanhMuc], [ThuTu], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [PhuKien]) VALUES (2, N'SamSung', 6, NULL, NULL, CAST(N'2018-05-21 01:54:17.930' AS DateTime), NULL, 0, NULL, 0)
INSERT [dbo].[DanhMucSanPham] ([ID], [TenDanhMuc], [ThuTu], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [PhuKien]) VALUES (3, N'Xiaomi', 2, NULL, NULL, NULL, NULL, 0, NULL, 1)
INSERT [dbo].[DanhMucSanPham] ([ID], [TenDanhMuc], [ThuTu], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [PhuKien]) VALUES (4, N'SamSung', 2, NULL, NULL, NULL, NULL, 1, NULL, 1)
INSERT [dbo].[DanhMucSanPham] ([ID], [TenDanhMuc], [ThuTu], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [PhuKien]) VALUES (5, N'Nokia', 3, NULL, NULL, NULL, NULL, 0, NULL, 0)
INSERT [dbo].[DanhMucSanPham] ([ID], [TenDanhMuc], [ThuTu], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [PhuKien]) VALUES (6, N'Oppo', 5, NULL, NULL, NULL, NULL, 0, NULL, NULL)
INSERT [dbo].[DanhMucSanPham] ([ID], [TenDanhMuc], [ThuTu], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [PhuKien]) VALUES (7, N'Oppo', 6, NULL, NULL, NULL, NULL, 1, NULL, 0)
INSERT [dbo].[DanhMucSanPham] ([ID], [TenDanhMuc], [ThuTu], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [PhuKien]) VALUES (8, N'Bphone', 9, NULL, NULL, NULL, NULL, 1, NULL, 0)
INSERT [dbo].[DanhMucSanPham] ([ID], [TenDanhMuc], [ThuTu], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [PhuKien]) VALUES (9, N'HTC', 3, NULL, NULL, NULL, NULL, 0, NULL, 0)
INSERT [dbo].[DanhMucSanPham] ([ID], [TenDanhMuc], [ThuTu], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [PhuKien]) VALUES (10, N'HTC', 3, NULL, NULL, NULL, NULL, 1, NULL, 0)
INSERT [dbo].[DanhMucSanPham] ([ID], [TenDanhMuc], [ThuTu], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [PhuKien]) VALUES (11, N'Xiaomi', 10, NULL, NULL, NULL, NULL, 1, NULL, 0)
INSERT [dbo].[DanhMucSanPham] ([ID], [TenDanhMuc], [ThuTu], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [PhuKien]) VALUES (12, N'Asus', 1, NULL, NULL, NULL, NULL, 1, NULL, 1)
INSERT [dbo].[DanhMucSanPham] ([ID], [TenDanhMuc], [ThuTu], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [PhuKien]) VALUES (13, N'Vivo', 2, NULL, NULL, NULL, NULL, 1, NULL, 0)
INSERT [dbo].[DanhMucSanPham] ([ID], [TenDanhMuc], [ThuTu], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [PhuKien]) VALUES (14, N'Sony', 3, NULL, NULL, NULL, NULL, 1, NULL, 0)
INSERT [dbo].[DanhMucSanPham] ([ID], [TenDanhMuc], [ThuTu], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [PhuKien]) VALUES (15, N'Tai nghe', 6, NULL, NULL, NULL, NULL, 1, NULL, 1)
INSERT [dbo].[DanhMucSanPham] ([ID], [TenDanhMuc], [ThuTu], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [PhuKien]) VALUES (16, N'xxxxxx', 1, CAST(N'2018-06-21 19:37:36.333' AS DateTime), N'', CAST(N'2018-06-21 19:37:36.333' AS DateTime), N'', 0, N'', 0)
INSERT [dbo].[DanhMucSanPham] ([ID], [TenDanhMuc], [ThuTu], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [PhuKien]) VALUES (17, N'xxxxxx', 1, CAST(N'2018-06-21 19:38:08.850' AS DateTime), N'', CAST(N'2018-06-21 19:38:08.850' AS DateTime), N'', 0, N'', 1)
INSERT [dbo].[DanhMucSanPham] ([ID], [TenDanhMuc], [ThuTu], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [PhuKien]) VALUES (18, N'xxxxxx', 3, CAST(N'2018-06-21 19:38:30.813' AS DateTime), N'', CAST(N'2018-06-21 19:38:30.813' AS DateTime), N'', 0, N'', 1)
INSERT [dbo].[DanhMucSanPham] ([ID], [TenDanhMuc], [ThuTu], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [PhuKien]) VALUES (19, N'dien thoai', 3, CAST(N'2018-06-22 13:11:47.227' AS DateTime), N'', CAST(N'2018-06-22 13:11:47.227' AS DateTime), N'', 0, N'', 1)
SET IDENTITY_INSERT [dbo].[DanhMucSanPham] OFF
SET IDENTITY_INSERT [dbo].[GioiThieu] ON 

INSERT [dbo].[GioiThieu] ([ID], [Name], [Conten]) VALUES (1, N'dia chi', N'<p>H&agrave; Nội</p>

<address>120 Th&aacute;i H&agrave;, Q. Đống Đa</address>

<p>Điện thoại:&nbsp;<a href="tel:0971206688">097.120.6688</a>&nbsp;-&nbsp;<a href="tel:0969120120 &lt;p&gt;Trung h%E1%BB%97 tr%E1%BB%A3: 0964120120">0969.120.120</a></p>

<p><a href="tel:0969120120 &lt;p&gt;Trung h%E1%BB%97 tr%E1%BB%A3: 0964120120">Trung hỗ trợ: 0964.120.120</a></p>

<p>398 Cầu Giấy, Q. Cầu Giấy |&nbsp;<a href="https://mobilecity.vn/lien-he/?cs=2">Xem bản đồ</a></p>

<p>Điện thoại:&nbsp;<a href="tel:0961111398">096.1111.398</a>&nbsp;-&nbsp;<a href="tel:0962222398">096.2222.398</a></p>
')
SET IDENTITY_INSERT [dbo].[GioiThieu] OFF
SET IDENTITY_INSERT [dbo].[HoaDon] ON 

INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (1, N'fsdf', N'sz', N'3232523', N'fds', CAST(N'2018-05-25 00:20:34.363' AS DateTime), NULL, NULL, 0, N'fs')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (2, N'324234', N'4234', N'423', N'423', CAST(N'2018-05-25 00:23:16.453' AS DateTime), NULL, NULL, 0, N'432')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (3, N'3242', N'42', N'423', N'423', CAST(N'2018-05-25 00:27:16.187' AS DateTime), NULL, NULL, 0, N'42')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (4, N'423', N'4324', N'423', N'42', CAST(N'2018-05-25 00:30:14.977' AS DateTime), NULL, NULL, 1, N'42')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (5, N'312', N'321', N'312', N'312', CAST(N'2018-05-25 00:39:19.320' AS DateTime), NULL, NULL, 1, N'312')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (6, N'312', N'321', N'312', N'312', CAST(N'2018-05-25 00:41:12.890' AS DateTime), NULL, NULL, 1, N'312')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (7, N'xzc', N'sda', N'da', N'as', CAST(N'2018-05-25 00:47:00.310' AS DateTime), NULL, NULL, 1, N'sd')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (8, N'sa', N'sad', N'31232', N'213', CAST(N'2018-05-25 01:23:14.120' AS DateTime), NULL, NULL, 1, N'321')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (9, N'eqw', N'eqw', N'eqw', N'ew', CAST(N'2018-05-25 01:37:53.360' AS DateTime), NULL, NULL, 1, N'eq')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (10, N'ewq', N'eqw', N'eq', N'ewq', CAST(N'2018-05-25 01:39:23.430' AS DateTime), NULL, NULL, 1, N'ewq')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (11, N'Duong', N'423', N'423', N'423', CAST(N'2018-05-25 01:45:14.693' AS DateTime), NULL, NULL, 1, N'423')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (12, N'ưe', N'rư', N'rue', N'rưe', CAST(N'2018-05-25 01:47:15.607' AS DateTime), NULL, NULL, 1, N'rưe')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (13, N'23', N'432', N'432', N'432', CAST(N'2018-05-25 01:49:06.803' AS DateTime), NULL, NULL, 1, N'423')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (14, N'2312', N'312', N'31232321', N'321', CAST(N'2018-05-25 01:53:39.220' AS DateTime), NULL, NULL, 1, N'321')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (15, N'2312', N'312', N'31232321', N'321', CAST(N'2018-05-25 01:55:04.087' AS DateTime), NULL, NULL, 1, N'321')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (16, N'ưeqw', N'ewq', N'eqw', N'', CAST(N'2018-05-25 01:57:15.373' AS DateTime), NULL, NULL, 1, N'eqwe')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (17, N'dsa', N'2342', N'dsa', N'dsa', CAST(N'2018-05-25 02:48:35.097' AS DateTime), NULL, NULL, 1, N'dovanduong09@gmail.com')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (18, N'weq', N'eqw', N'ew', N'31', CAST(N'2018-05-25 02:53:49.670' AS DateTime), NULL, NULL, 1, N'dovanduong09@gmail.com')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (19, N'31', N'312', N'321', N'fds', CAST(N'2018-05-25 02:57:40.960' AS DateTime), NULL, NULL, 1, N'dovanduong09@gmail.com')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (20, N'sf', N'ds', N'da', N'd', CAST(N'2018-05-25 03:03:01.803' AS DateTime), NULL, NULL, 1, N'dovanduong09@gmail.com')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (21, N'dsf', N'fs', N'das', N'dsa', CAST(N'2018-05-25 03:08:41.690' AS DateTime), NULL, NULL, 1, N'dovanduong09@gmail.com')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (22, N'df', N'fsd', N'fsd', N'sd', CAST(N'2018-05-25 03:16:34.860' AS DateTime), NULL, NULL, 1, N'dovanduong09@gmail.com')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (23, N'sdfds', N'fsd', N'sad', N'sda', CAST(N'2018-05-25 03:18:58.893' AS DateTime), NULL, NULL, 1, N'dovanduong02@gmail.com')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (24, N'Duong', N'Ha noi', N'43423', N'dsa', CAST(N'2018-05-25 03:23:33.887' AS DateTime), NULL, NULL, 1, N'dovanduong02@gmail.com')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (25, N'dasd', N'dasd', N'sad', N'sd', CAST(N'2018-06-02 23:52:16.200' AS DateTime), NULL, NULL, 1, N'DOVANDUONG02@GMAIL.COM')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (1025, N'ád', N'dsa', N'sadd', N'ưqd', CAST(N'2018-06-07 01:45:10.517' AS DateTime), NULL, NULL, 1, N'dovanduong09@gmail.com')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (1026, N'ád', N'dsa', N'sadd', N'', CAST(N'2018-06-07 01:46:03.393' AS DateTime), NULL, NULL, 1, N'dovanduong09@gmail.com')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (1027, N'212312312312', N'1231312', N'31232', N'213213', CAST(N'2018-06-10 17:35:30.293' AS DateTime), NULL, NULL, 1, N'dovanduong02@gmail.com')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (1028, N'111111111111', N'1', N'01629727328', N'11', CAST(N'2018-06-10 17:41:29.047' AS DateTime), NULL, NULL, 1, N'dovanduong09@gmail.com')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (1029, N'321', N'213', N'01629727328', N'23', CAST(N'2018-06-10 17:45:08.383' AS DateTime), NULL, NULL, 1, N'dovanduong02@gmail.com')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (1030, N'2222', N'Giao thủy', N'01629727328', N'2', CAST(N'2018-06-10 18:03:14.060' AS DateTime), NULL, NULL, 1, N'dovanduong02@gmail.com')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (1031, N'Duong', N'Giao thủy', N'01629727328', N'wewq', CAST(N'2018-06-10 18:06:43.670' AS DateTime), NULL, NULL, 1, N'dovanduong02@gmail.com')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (1032, N'3333333333333333', N'Giao thủy', N'01629727328', N'123', CAST(N'2018-06-10 18:09:56.850' AS DateTime), NULL, NULL, 1, N'dovanduong02@gmail.com')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (1033, N'555', N'Giao thủy', N'01629727328', N'2', CAST(N'2018-06-10 18:17:58.693' AS DateTime), NULL, NULL, 1, N'dovanduong02@gmail.com')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (1034, N'Duong', N'Giao thủy', N'01629727328', N'sad', CAST(N'2018-06-10 20:45:14.893' AS DateTime), NULL, NULL, 1, N'dovanduong02@gmail.com')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (1035, N'xxxxxxxxxxx', N'Giao thủy', N'01629727328', N'gfđssdsdf', CAST(N'2018-06-10 22:21:09.747' AS DateTime), NULL, NULL, 1, N'dovanduong02@gmail.com')
INSERT [dbo].[HoaDon] ([ID], [TenKhachHang], [DiaChi], [SDT], [GhiChu], [NgayTao], [NguoiTao], [PhuongThucThanhToan], [TrangThai], [Gmail]) VALUES (1036, N'//////////////', N'Giao thủy', N'01629727328', N'ysdbcv', CAST(N'2018-06-10 22:24:08.437' AS DateTime), NULL, NULL, 0, N'dovanduong02@gmail.com')
SET IDENTITY_INSERT [dbo].[HoaDon] OFF
SET IDENTITY_INSERT [dbo].[PhanHoiKH] ON 

INSERT [dbo].[PhanHoiKH] ([ID], [Name], [Email], [Message], [NgayTao], [TrangThai]) VALUES (1, N'dá', N'dovanduong02@gmail.com', N'sada', CAST(N'2018-06-10 00:41:24.543' AS DateTime), 1)
INSERT [dbo].[PhanHoiKH] ([ID], [Name], [Email], [Message], [NgayTao], [TrangThai]) VALUES (2, N'321', N'312', N'312', CAST(N'2019-02-02 00:00:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[PhanHoiKH] OFF
SET IDENTITY_INSERT [dbo].[SanPham] ON 

INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (3, N'Xiaomi Redmi S2 32GB', 12, NULL, N'Duong', CAST(N'2018-06-10 17:21:38.017' AS DateTime), N'Duong', 1, N'/ckfinder/userfiles/images/636465265824081601_1.jpg', NULL, 1, 0, NULL, N'Xiaomi Redmi S2 32GB', N'<p>dasdsadacccccc</p>
', CAST(5000000 AS Decimal(18, 0)), CAST(3000000 AS Decimal(18, 0)), 3, N'2560 x 1440 pixels', N'5.5                 ', N'8.0 MP', N'8.0 MP', N'	4 nhân 2.3GHz + 4 nhân 1.7GHz', N'8 Nhân', N'	Exynos 8895', N'64 GB', N'64 GB', N'Android 8.0', N'Li-Ion', N'3000Mah', N'2 sim Dual SIM', N'Wi-Fi 802.11 a/b/g/n/ac', N'v5.0', N'A-GPS, GLONASS, BDS')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (4, N'Tai nghe có mic Devia D3 Ripple In-ear', 15, CAST(N'2018-03-22 23:50:06.040' AS DateTime), N'Duong', CAST(N'2018-06-10 20:50:35.067' AS DateTime), N'Duong', 1, N'/ckfinder/userfiles/images/636404017524477485_HASP-TAI-NGHE-CO-MIC-DEVIA-D3-RIPPLE-INEAR-00391761-02.jpg', NULL, 0, 0, NULL, N'Mua 3 món Phụ Kiện khác nhau giảm 10%', NULL, CAST(230000 AS Decimal(18, 0)), CAST(200000 AS Decimal(18, 0)), 1, NULL, N'                    ', NULL, NULL, NULL, NULL, NULL, N'64 GB', N'64 GB', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (5, N'SamSung S10', 1, CAST(N'2018-05-22 23:50:06.040' AS DateTime), N'Duong', CAST(N'2018-06-10 17:20:26.463' AS DateTime), N'Duong', 1, N'/ckfinder/userfiles/images/636552333148760332_1.jpg', NULL, 1, 0, NULL, N'không mô tả', N'<h3>Đ&aacute;nh gi&aacute; chi tiết Xiaomi Redmi Note 5 32GB</h3>

<p><strong><a href="https://fptshop.com.vn/dien-thoai/xiaomi-redmi-note-5" target="_blank">Xiaomi Redmi Note 5</a>&nbsp;l&agrave; thiết bị thứ ba trong ph&acirc;n kh&uacute;c tầm trung - gi&aacute; rẻ của Xiaomi sở hữu m&agrave;n h&igrave;nh tỉ lệ mới 18:9.</strong></p>

<h3><br />
<strong>Thiết kế tỉ mỉ.</strong></h3>

<p>&nbsp;</p>

<p><img alt="xiaomi-redmi-note-5" longdesc="https://fptshop.com.vn/dien-thoai/xiaomi-redmi-note-5" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/xiaomi-redmi-note-5/xiaomi-redmi-note-51.jpg" title="xiaomi-redmi-note-5" /></p>

<p><br />
<strong>Xiaomi Redmi Note 5</strong>&nbsp;sở hữu ng&ocirc;n ngữ thiết kế kh&aacute; quen thuộc với khung viền kim loại c&ugrave;ng hai dải nhựa hỗ trợ thu ph&aacute;t s&oacute;ng tốt hơn. Phần khung được ho&agrave;n thiện một c&aacute;ch tỉ mỉ với những đường cắt kim cương s&aacute;ng b&oacute;ng. Mặt lưng m&aacute;y được bo cong nhẹ, c&ugrave;ng với lớp sơn nh&aacute;m mịn khiến cho m&aacute;y khi cầm &ocirc;m tay hơn v&agrave; kh&ocirc;ng g&acirc;y cảm gi&aacute;c cấn tay kh&oacute; chịu.</p>

<h3><br />
<strong>M&agrave;n h&igrave;nh Full HD+.</strong></h3>

<p>&nbsp;</p>

<p><img alt="xiaomi-redmi-note-5" longdesc="https://fptshop.com.vn/dien-thoai/xiaomi-redmi-note-5" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/xiaomi-redmi-note-5/xiaomi-redmi-note-52.jpg" title="xiaomi-redmi-note-5" /></p>

<p><br />
<a href="https://fptshop.com.vn/dien-thoai/xiaomi-redmi-note-5" target="_blank"><strong>Redmi Note 5</strong></a>&nbsp;c&oacute; m&agrave;n h&igrave;nh k&iacute;ch thước 5.99 inch tr&ecirc;n tấm nền IPS độ ph&acirc;n giải Full HD+. M&aacute;y c&oacute; độ s&aacute;ng cao c&ugrave;ng với g&oacute;c nh&igrave;n rộng. Gi&uacute;p cho người d&ugrave;ng c&oacute; thể thoải m&aacute;i sử dụng m&aacute;y ở điều kiện ngo&agrave;i trời.</p>

<h3><strong>Hiệu năng mượt m&agrave;.</strong></h3>

<p>&nbsp;</p>

<p><img alt="xiaomi-redmi-note-5" longdesc="https://fptshop.com.vn/dien-thoai/xiaomi-redmi-note-5" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/xiaomi-redmi-note-5/xiaomi-redmi-note-53.jpg" title="xiaomi-redmi-note-5" /></p>

<p><br />
Cấu h&igrave;nh lu&ocirc;n l&agrave; yếu tố m&agrave;&nbsp;<strong>Xiaomi</strong>&nbsp;kh&ocirc;ng bao giờ l&agrave;m thất vọng người d&ugrave;ng. Cụ thể&nbsp;<strong>Redmi Note 5</strong>&nbsp;sở hữu con chip Qualcomm SD 636 c&ugrave;ng RAM l&agrave; 3 GB. Bộ nhớ trong c&oacute; dung lượng 32 GB cho bạn thoải m&aacute;i lưu trữ dữ liệu c&aacute; nh&acirc;n. Ngo&agrave;i ra&nbsp;<strong>Xiaomi Redmi Note 5</strong>được chạy tr&ecirc;n nền Android 8.0 &nbsp;mang lại sự mượt m&agrave; v&agrave; ổn định trong qu&aacute; tr&igrave;nh sử dụng.</p>

<h3><br />
<strong>Dung lượng pin kh&aacute;.</strong></h3>

<p>&nbsp;</p>

<p><img alt="xiaomi-redmi-note-5" longdesc="https://fptshop.com.vn/dien-thoai/xiaomi-redmi-note-5" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/xiaomi-redmi-note-5/xiaomi-redmi-note-54.jpg" title="xiaomi-redmi-note-5" /></p>

<p><br />
Vi&ecirc;n pin đi k&egrave;m c&oacute; dung lượng 4.000 mAh gi&uacute;p&nbsp;<strong>Xiaomi Redmi Note 5</strong>&nbsp;đ&aacute;p ứng tốt nhu cầu sử dụng thoải m&aacute;i trong hơn 1 ng&agrave;y. Ngo&agrave;i ra m&aacute;y c&ograve;n được trang bị cảm biến v&acirc;n tay ở mặt lưng gi&uacute;p bạn dễ d&agrave;ng mở kh&oacute;a m&agrave;n h&igrave;nh.</p>
', CAST(15000000 AS Decimal(18, 0)), CAST(13000000 AS Decimal(18, 0)), 3, N'2560 x 1440 pixels', N'5.5                 ', N'8.0 MP', N'8.0 MP', N'	4 nhân 2.3GHz + 4 nhân 1.7GHz', N'8 Nhân', N'	Exynos 8895', N'64 GB', N'64 GB', N'Android 8.0', N'Li-Ion', N'3000Mah', N'2 sim Dual SIM', N'Wi-Fi 802.11 a/b/g/n/ac', N'v5.0', N'A-GPS, GLONASS, BDS')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (6, N'Xiaomi Redmi Note 5 32GB ', 4, CAST(N'2018-05-22 23:50:31.643' AS DateTime), N'Duong', CAST(N'2018-06-10 17:19:44.183' AS DateTime), N'Duong', 1, N'/ckfinder/userfiles/images/636638714302395658_1.jpg', NULL, 1, 0, NULL, N'Xiaomi Redmi Note 5 32GB ', N'<h3>Đ&aacute;nh gi&aacute; chi tiết Xiaomi Redmi Note 5 32GB</h3>

<p><strong><a href="https://fptshop.com.vn/dien-thoai/xiaomi-redmi-note-5" target="_blank">Xiaomi Redmi Note 5</a>&nbsp;l&agrave; thiết bị thứ ba trong ph&acirc;n kh&uacute;c tầm trung - gi&aacute; rẻ của Xiaomi sở hữu m&agrave;n h&igrave;nh tỉ lệ mới 18:9.</strong></p>

<h3><br />
<strong>Thiết kế tỉ mỉ.</strong></h3>

<p>&nbsp;</p>

<p><img alt="xiaomi-redmi-note-5" longdesc="https://fptshop.com.vn/dien-thoai/xiaomi-redmi-note-5" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/xiaomi-redmi-note-5/xiaomi-redmi-note-51.jpg" title="xiaomi-redmi-note-5" /></p>

<p><br />
<strong>Xiaomi Redmi Note 5</strong>&nbsp;sở hữu ng&ocirc;n ngữ thiết kế kh&aacute; quen thuộc với khung viền kim loại c&ugrave;ng hai dải nhựa hỗ trợ thu ph&aacute;t s&oacute;ng tốt hơn. Phần khung được ho&agrave;n thiện một c&aacute;ch tỉ mỉ với những đường cắt kim cương s&aacute;ng b&oacute;ng. Mặt lưng m&aacute;y được bo cong nhẹ, c&ugrave;ng với lớp sơn nh&aacute;m mịn khiến cho m&aacute;y khi cầm &ocirc;m tay hơn v&agrave; kh&ocirc;ng g&acirc;y cảm gi&aacute;c cấn tay kh&oacute; chịu.</p>

<h3><br />
<strong>M&agrave;n h&igrave;nh Full HD+.</strong></h3>

<p>&nbsp;</p>

<p><img alt="xiaomi-redmi-note-5" longdesc="https://fptshop.com.vn/dien-thoai/xiaomi-redmi-note-5" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/xiaomi-redmi-note-5/xiaomi-redmi-note-52.jpg" title="xiaomi-redmi-note-5" /></p>

<p><br />
<a href="https://fptshop.com.vn/dien-thoai/xiaomi-redmi-note-5" target="_blank"><strong>Redmi Note 5</strong></a>&nbsp;c&oacute; m&agrave;n h&igrave;nh k&iacute;ch thước 5.99 inch tr&ecirc;n tấm nền IPS độ ph&acirc;n giải Full HD+. M&aacute;y c&oacute; độ s&aacute;ng cao c&ugrave;ng với g&oacute;c nh&igrave;n rộng. Gi&uacute;p cho người d&ugrave;ng c&oacute; thể thoải m&aacute;i sử dụng m&aacute;y ở điều kiện ngo&agrave;i trời.</p>

<h3><strong>Hiệu năng mượt m&agrave;.</strong></h3>

<p>&nbsp;</p>

<p><img alt="xiaomi-redmi-note-5" longdesc="https://fptshop.com.vn/dien-thoai/xiaomi-redmi-note-5" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/xiaomi-redmi-note-5/xiaomi-redmi-note-53.jpg" title="xiaomi-redmi-note-5" /></p>

<p><br />
Cấu h&igrave;nh lu&ocirc;n l&agrave; yếu tố m&agrave;&nbsp;<strong>Xiaomi</strong>&nbsp;kh&ocirc;ng bao giờ l&agrave;m thất vọng người d&ugrave;ng. Cụ thể&nbsp;<strong>Redmi Note 5</strong>&nbsp;sở hữu con chip Qualcomm SD 636 c&ugrave;ng RAM l&agrave; 3 GB. Bộ nhớ trong c&oacute; dung lượng 32 GB cho bạn thoải m&aacute;i lưu trữ dữ liệu c&aacute; nh&acirc;n. Ngo&agrave;i ra&nbsp;<strong>Xiaomi Redmi Note 5</strong>được chạy tr&ecirc;n nền Android 8.0 &nbsp;mang lại sự mượt m&agrave; v&agrave; ổn định trong qu&aacute; tr&igrave;nh sử dụng.</p>

<h3><br />
<strong>Dung lượng pin kh&aacute;.</strong></h3>

<p>&nbsp;</p>

<p><img alt="xiaomi-redmi-note-5" longdesc="https://fptshop.com.vn/dien-thoai/xiaomi-redmi-note-5" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/xiaomi-redmi-note-5/xiaomi-redmi-note-54.jpg" title="xiaomi-redmi-note-5" /></p>

<p><br />
Vi&ecirc;n pin đi k&egrave;m c&oacute; dung lượng 4.000 mAh gi&uacute;p&nbsp;<strong>Xiaomi Redmi Note 5</strong>&nbsp;đ&aacute;p ứng tốt nhu cầu sử dụng thoải m&aacute;i trong hơn 1 ng&agrave;y. Ngo&agrave;i ra m&aacute;y c&ograve;n được trang bị cảm biến v&acirc;n tay ở mặt lưng gi&uacute;p bạn dễ d&agrave;ng mở kh&oacute;a m&agrave;n h&igrave;nh.</p>
', CAST(213 AS Decimal(18, 0)), CAST(3123 AS Decimal(18, 0)), 12312, N'2560 x 1440 pixels', N'5.5                 ', N'8.0 MP', N'8.0 MP', N'	4 nhân 2.3GHz + 4 nhân 1.7GHz', N'8 Nhân', N'	Exynos 8895', N'64 GB', N'64 GB', N'Android 8.0', N'Li-Ion', N'3000Mah', N'2 sim Dual SIM', N'Wi-Fi 802.11 a/b/g/n/ac', N'v5.0', N'A-GPS, GLONASS, BDS')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (7, N'Huawei Nova 2i ', 1, CAST(N'2018-05-22 23:50:54.840' AS DateTime), N'Duong', CAST(N'2018-06-10 17:18:59.237' AS DateTime), N'Duong', 1, N'/ckfinder/userfiles/images/636455667905520763_1o.jpg', NULL, 1, 0, NULL, N'Thiết kế hiện đại', N'<h3>Đ&aacute;nh gi&aacute; chi tiết Huawei Nova 2i</h3>

<h2>Nova l&agrave; d&ograve;ng sản phẩm trung cấp của Huawei, D&ograve;ng sản phẩm n&agrave;y được tạo ra với mục đ&iacute;ch mang những t&iacute;nh năng của c&aacute;c m&aacute;y cao cấp xuống c&aacute;c m&aacute;y trung cấp, gi&uacute;p cho nhiều kh&aacute;ch hang trẻ c&oacute; cơ hội tiếp cận v&agrave; trải nghiệm, ch&iacute;nh v&igrave; thế Huawei Nova 2i hội tụ c&ugrave;ng l&uacute;c cả hai xu hướng mới nhất hiện nay tr&ecirc;n c&aacute;c smartphone thế hệ mới l&agrave; m&agrave;n h&igrave;nh tr&agrave;n viền v&agrave; chụp ảnh xo&aacute; ph&ocirc;ng.</h2>

<p>&nbsp;</p>

<h3><strong>Thiết kế hiện đại</strong></h3>

<p>&nbsp;</p>

<p><img alt="huawei-nova-2i" longdesc="https://fptshop.com.vn/dien-thoai/huawei-nova-2i" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/11_05_huawei-nova-2i/636444604874184798_HASP-HUAWEI-NOVA-2I-%20(5).jpg" title="huawei-nova-2i" /></p>

<p>&nbsp;</p>

<p><strong>Huawei Nova 2i&nbsp;</strong>g&acirc;y ch&uacute; &yacute; nhiều nhất ở mặt trước với m&agrave;n h&igrave;nh viền mỏng tỷ lệ 18:9 giống với nhiều điện thoại cao cấp hiện nay, &nbsp;viền m&agrave;n h&igrave;nh của Nova 2i được l&agrave;m mỏng, cho k&iacute;ch thước m&agrave;n h&igrave;nh hiển thị lớn hơn, tỉ lệ diện t&iacute;ch n&agrave;y cộng với việc chuyển sang d&ugrave;ng m&agrave;n h&igrave;nh 18:9 m&agrave; nova 2i trở n&ecirc;n thanh mảnh v&agrave; gọn g&agrave;ng hơn hẳn so với c&aacute;c điện thoại 6&quot; d&ugrave;ng 16:9 truyền thống.</p>

<p>&nbsp;</p>

<h3><strong>M&agrave;n h&igrave;nh Full HD</strong></h3>

<p>&nbsp;</p>

<p><img alt="huawei-nova-2i" longdesc="https://fptshop.com.vn/dien-thoai/huawei-nova-2i" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/11_05_huawei-nova-2i/636444604880580183_HASP-HUAWEI-NOVA-2I-%20(7).jpg" title="huawei-nova-2i" /></p>

<p>&nbsp;</p>

<p><strong>Huawei</strong>&nbsp;vẫn d&ugrave;ng m&agrave;n h&igrave;nh FullHD với độ ph&acirc;n giải thật sự l&agrave; 2160 x 1080. Tấm nền IPS cộng với độ ph&acirc;n giải cao dẫn đến chất lượng hiển thị của nova 2i l&agrave; rất tốt. Với m&agrave;n h&igrave;nh viền mỏng c&ugrave;ng tỷ lệ 18:9 cho nội dung hiển thị được nhiều hơn, rộng hơn, &iacute;t phải cuộn trang hơn, h&igrave;nh ảnh tr&agrave;n s&aacute;t ra tận m&eacute;p. M&agrave;n h&igrave;nh của Nova 2i cũng cho độ s&aacute;ng kh&aacute;, nh&igrave;n ổn ngo&agrave;i trời nắng, g&oacute;c nh&igrave;n rộng, m&agrave;u sắc theo hướng tự nhi&ecirc;n, trung thực.</p>

<p>&nbsp;</p>

<h3><strong>Điểm nhấn từ camera</strong></h3>

<p>&nbsp;</p>

<p><img alt="huawei-nova-2i" longdesc="https://fptshop.com.vn/dien-thoai/huawei-nova-2i" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/11_05_huawei-nova-2i/636444604887755493_HASP-HUAWEI-NOVA-2i-18.jpg" title="huawei-nova-2i" /></p>

<p>&nbsp;</p>

<p>Camera l&agrave; điểm nhấn đ&aacute;ng ch&uacute; &yacute; tiếp theo tr&ecirc;n<strong>&nbsp;Huawei Nova 2i</strong>, m&aacute;y sử dụng camera k&eacute;p cho cả ch&iacute;nh v&agrave; phụ, cụ thể th&igrave; camera k&eacute;p ph&iacute;a sau bao gồm 1 camera ch&iacute;nh 16MP v&agrave; 1 camera phụ 2MP. V&agrave; cụm camera k&eacute;p mặt trước bao gồm 1 camera ch&iacute;nh 13MP khẩu f/2.0 v&agrave; 1 camera phụ 2MP điểm ảnh lớn 1.75&mu;m. M&agrave;u sắc trong ảnh của Nova 2i rất tươi tắn, rực rỡ, độ s&aacute;ng cao kể cả khi chụp thiếu s&aacute;ng.</p>

<p>&nbsp;</p>

<h3><strong>Hiệu năng đ&aacute;ng gi&aacute;</strong></h3>

<p>&nbsp;</p>

<p><img alt="huawei-nova-2i" longdesc="https://fptshop.com.vn/dien-thoai/huawei-nova-2i" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/11_05_huawei-nova-2i/636444604886663598_HASP-HUAWEI-NOVA-2i-15.jpg" title="huawei-nova-2i" /></p>

<p>&nbsp;</p>

<p>Về hiệu năng, đ&acirc;y cũng l&agrave; một điểm mạnh của&nbsp;<strong>Nova 2i</strong>. Với chip đồ họa Mali T830MP2, b&ecirc;n cạnh đ&oacute; GPU 4GB RAM v&agrave; 64GB ROM c&ugrave;ng cảm biến v&acirc;n tay, cho bạn trải nghiệm v&agrave; thao t&aacute;c tất cả c&aacute;c t&aacute;c vụ th&ocirc;ng thường thoả th&iacute;ch, thật kh&oacute; c&oacute; đối thủ n&agrave;o c&ugrave;ng mức gi&aacute; thậm ch&iacute; h&agrave;ng x&aacute;ch tay c&oacute; thể so b&igrave; c&ugrave;ng&nbsp;<strong>Nova 2i</strong>.</p>
', CAST(3123 AS Decimal(18, 0)), CAST(123 AS Decimal(18, 0)), 3, N'2560 x 1440 pixels', N'5.5                 ', N'8.0 MP', N'8.0 MP', N'	4 nhân 2.3GHz + 4 nhân 1.7GHz', N'8 Nhân', N'	Exynos 8895', N'64 GB', N'64 GB', N'Android 8.0', N'Li-Ion', N'3000Mah', N'2 sim Dual SIM', N'Wi-Fi 802.11 a/b/g/n/ac', N'v5.0', N'A-GPS, GLONASS, BDS')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (8, N'Xiaomi Mi A1 32GB', 1, CAST(N'2018-05-22 23:51:12.857' AS DateTime), N'Duong', CAST(N'2018-06-10 17:18:06.907' AS DateTime), N'Duong', 1, N'/ckfinder/userfiles/images/636608712721308701_1.jpg', NULL, 1, 0, NULL, N'Là một dự án kết hợp với Android One của Google', N'<h3>Đ&aacute;nh gi&aacute; chi tiết Xiaomi Mi A1 32GB</h3>

<p>&nbsp;</p>

<p>L&agrave; một dự &aacute;n kết hợp với Android One của Google,&nbsp;<a href="https://fptshop.com.vn/dien-thoai/xiaomi-mi-a1-32gb" target="_blank"><strong>Xiaomi Mi A1</strong></a>&nbsp;đ&atilde; từng ra mắt bản 64 GB tại Ấn Độ. Sau một thời gian th&igrave; bản Xiaomi Mi A1 32 GB được tung ra để đ&aacute;p ứng được những kh&aacute;ch h&agrave;ng y&ecirc;u th&iacute;ch thương hiệu Xiaomi nhưng c&oacute; nhu cầu lưu trữ &iacute;t hơn.</p>

<p>&nbsp;</p>

<h3><strong>Thiết kế tinh tế.</strong></h3>

<p>&nbsp;</p>

<p><img alt="xiaomi-mi-a1-32gb" longdesc="https://fptshop.com.vn/dien-thoai/xiaomi-mi-a1-32gb" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/xiaomi-mi-a1-32gb1/xiaomi-mi-a1-32gb1.jpg" title="xiaomi-mi-a1-32gb" /></p>

<p>&nbsp;</p>

<p>Thiết kế của&nbsp;<a href="https://fptshop.com.vn/dien-thoai/xiaomi-mi-a1-32gb" target="_blank">Xiaomi Mi A1 32 GB</a>&nbsp;c&oacute; viền khung kim loại, bo cong c&aacute;c g&oacute;c, thiết kế nguy&ecirc;n khối tạo sự thanh tho&aacute;t v&agrave; dễ cầm nắm. Mặt lưng của Xiaomi Mi A1 32 GB c&oacute; logo &quot;AndroidOne&quot; ở cuối, biểu tượng cho việc chạy bản Android thuần gốc, l&agrave; dự &aacute;n hợp t&aacute;c giữa Xiaomi v&agrave; Google. Viền phải l&agrave; c&aacute;c ph&iacute;m vật l&yacute; v&agrave; viền dưới bao gồm jack tai nghe 3.5 mm c&ugrave;ng cổng sạc USB Type-c.</p>

<p>&nbsp;</p>

<h3><strong>M&agrave;n h&igrave;nh sắc n&eacute;t.</strong></h3>

<p>&nbsp;</p>

<p><img alt="xiaomi-mi-a1-32gb" longdesc="https://fptshop.com.vn/dien-thoai/xiaomi-mi-a1-32gb" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/xiaomi-mi-a1-32gb1/xiaomi-mi-a1-32gb2.jpg" title="xiaomi-mi-a1-32gb" /></p>

<p>&nbsp;</p>

<p>M&agrave;n h&igrave;nh của Xiaomi Mi A1 c&oacute; thiết kế tr&ecirc;n tấm nền LTPS, độ ph&acirc;n giải Full HD v&agrave; 5.5&quot;, đem lại độ sắc n&eacute;t cao, xem phim hay chơi game đều rất dễ chịu cho mắt.</p>

<p>&nbsp;</p>

<h3><strong>Cụm camera k&eacute;p xo&aacute; ph&ocirc;ng tốt.</strong></h3>

<p>&nbsp;</p>

<p><img alt="xiaomi-mi-a1-32gb" longdesc="https://fptshop.com.vn/dien-thoai/xiaomi-mi-a1-32gb" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/xiaomi-mi-a1-32gb1/xiaomi-mi-a1-32gb3.jpg" title="xiaomi-mi-a1-32gb" /></p>

<p>&nbsp;</p>

<p>Camera trước của Xiaomi Mi A1 32 GB c&oacute; độ ph&acirc;n giải 5 MP.&nbsp;Đặc biệt, cụm camera k&eacute;p ở ph&iacute;a sau bao gồm 1 camera ch&iacute;nh 12 MP v&agrave; 1 camera phụ 12 MP c&oacute; khả năng chụp tele v&agrave; zoom quang học 2X. Nhờ thiết kế camera tr&ecirc;n, độ xo&aacute; ph&ocirc;ng của Xiaomi Mi A1 32 GB cũng được đ&aacute;nh gi&aacute; rất tốt.</p>

<p>&nbsp;</p>

<h3><strong>Cấu h&igrave;nh mạnh mẽ.</strong></h3>

<p>&nbsp;</p>

<p><img alt="xiaomi-mi-a1-32gb" longdesc="https://fptshop.com.vn/dien-thoai/xiaomi-mi-a1-32gb" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/xiaomi-mi-a1-32gb1/xiaomi-mi-a1-32gb4.jpg" title="xiaomi-mi-a1-32gb" /></p>

<p>&nbsp;</p>

<p>Xiaomi Mi A1 32 GB c&oacute; cấu h&igrave;nh RAM 4 GB v&agrave; chip Snapdragon 625 8 nh&acirc;n, bạn vẫn ho&agrave;n to&agrave;n y&ecirc;n t&acirc;m về độ mượt khi trải nghiệm c&aacute;c game nặng hay ứng dụng. 32 GB vẫn đủ lưu trữ nhiều h&igrave;nh ảnh, game,...&nbsp; Xiaomi Mi A1 c&oacute; cảm biến v&acirc;n tay, được bố tr&iacute; ở phần lưng ph&iacute;a sau. Trải nghiệm bảo mật v&acirc;n tay, Xiaomi Mi A1 32 GB đem lại kết quả h&agrave;i l&ograve;ng, nhanh v&agrave; ch&iacute;nh x&aacute;c cao.</p>
', CAST(5500000 AS Decimal(18, 0)), CAST(5000000 AS Decimal(18, 0)), 1, N'2560 x 1440 pixels', N'5.5                 ', N'8.0 MP', N'8.0 MP', N'	4 nhân 2.3GHz + 4 nhân 1.7GHz', N'8 Nhân', N'	Exynos 8895', N'64 GB', N'64 GB', N'Android 8.0', N'Li-Ion', N'3000Mah', N'2 sim Dual SIM', N'Wi-Fi 802.11 a/b/g/n/ac', N'v5.0', N'A-GPS, GLONASS, BDS')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (9, N'SamSung J8', 4, CAST(N'2018-05-23 00:54:09.590' AS DateTime), N'Duong', CAST(N'2018-06-10 17:16:46.663' AS DateTime), N'Duong', 1, N'/ckfinder/userfiles/images/636552331208636703_1.jpg', NULL, 1, 0, NULL, N'SẢN PHẨM NHẬN GIAO HÀNG TRONG 1 GIỜ', N'<h3 style="text-align: center;"><strong>Đ&aacute;nh gi&aacute; chi tiết Samsung Galaxy S9+</strong></h3>

<p><strong>Thế hệ&nbsp;điện thoại Samsung Galaxy S&nbsp;tiếp tục được Samsung n&acirc;ng l&ecirc;n một tầm cao mới. Với&nbsp;<a href="https://fptshop.com.vn/dien-thoai/samsung-galaxy-s9-plus" target="_blank">Samsung S9+</a>, bạn sẽ &ldquo;nh&igrave;n thấy điều kh&ocirc;ng thể&rdquo; nhờ bộ phận camera được cải tiến to&agrave;n diện.</strong></p>

<p>&nbsp;</p>

<h3><strong>Thiết kế tinh tế</strong></h3>

<p>&nbsp;</p>

<p><img alt="samsung-galaxy-s9-plus" longdesc="https://fptshop.com.vn/dien-thoai/samsung-galaxy-s9-plus" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/samsung-galaxy-s9-plus/samsung-galaxy-s9-plus1.jpg" title="samsung-galaxy-s9-plus" /></p>

<p>&nbsp;</p>

<p><strong>Samsung Galaxy S9+</strong>&nbsp;to&aacute;t l&ecirc;n sự cuốn h&uacute;t, khơi dậy cảm gi&aacute;c th&iacute;ch th&uacute; cho người d&ugrave;ng ngay từ c&aacute;i nh&igrave;n đầu ti&ecirc;n với thiết kế m&agrave;n h&igrave;nh cong v&ocirc; cực, khung kim loại cứng c&aacute;p v&agrave; hai mặt k&iacute;nh cường lực b&oacute;ng bẩy.</p>

<p>&nbsp;</p>

<h3><strong>M&agrave;n h&igrave;nh sắc n&eacute;t</strong></h3>

<p>&nbsp;</p>

<p><img alt="samsung-galaxy-s9-plus" longdesc="https://fptshop.com.vn/dien-thoai/samsung-galaxy-s9-plus" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/samsung-galaxy-s9-plus/samsung-galaxy-s9-plus2.jpg" title="samsung-galaxy-s9-plus" /></p>

<p>&nbsp;</p>

<p>M&agrave;n h&igrave;nh 6.2 inch tr&ecirc;n&nbsp;<strong>Galaxy S9+</strong>&nbsp;c&oacute; độ ph&acirc;n giải 2K+, sử dụng tấm nền Super AMOLED hỗ trợ HDR. Mọi chi tiết tr&ecirc;n h&igrave;nh ảnh hay video đều được t&aacute;i tạo sắc n&eacute;t với m&agrave;u sắc trung thực, sống động như đang nh&igrave;n thấy ngay trước mắt. Ngo&agrave;i ra&nbsp;<strong>S9+</strong>&nbsp;t&iacute;ch hợp chuẩn kh&aacute;ng bụi &ndash; kh&aacute;ng nước IP68, gi&uacute;p bạn thoải m&aacute;i nghe nhạc b&ecirc;n hồ bơi, nhận cuộc gọi giữa trời mưa v&agrave; y&ecirc;n t&acirc;m khi chẳng may l&agrave;m rơi m&aacute;y xuống nước.</p>

<p>&nbsp;</p>

<h3><strong>Hiệu năng ấn tượng</strong></h3>

<p>&nbsp;</p>

<p><img alt="samsung-galaxy-s9-plus" longdesc="https://fptshop.com.vn/dien-thoai/samsung-galaxy-s9-plus" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/samsung-galaxy-s9-plus/samsung-galaxy-s9-plus3.jpg" title="samsung-galaxy-s9-plus" /></p>

<p>&nbsp;</p>

<p>Với vi xử l&yacute; Exynos 9810 8 nh&acirc;n c&ugrave;ng bộ nhớ RAM l&ecirc;n đến 6 GB,&nbsp;<strong>Samsung Galaxy S9+</strong>&nbsp;cho điểm số thuộc top đầu thị trường ở những b&agrave;i kiểm tra hiệu năng bằng phần mềm. C&ograve;n trong qu&aacute; tr&igrave;nh sử dụng thực tế, tốc độ xử l&yacute; v&agrave; khả năng chạy đa nhiệm của m&aacute;y cũng v&ocirc; c&ugrave;ng ấn tượng.</p>

<p>&nbsp;</p>

<h3><strong>Camera được n&acirc;ng cấp</strong></h3>

<p>&nbsp;</p>

<p><img alt="samsung-galaxy-s9-plus" longdesc="https://fptshop.com.vn/dien-thoai/samsung-galaxy-s9-plus" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/samsung-galaxy-s9-plus/samsung-galaxy-s9-plus4.jpg" title="samsung-galaxy-s9-plus" /></p>

<p>&nbsp;</p>

<p>Điện thoại&nbsp;<strong>Galaxy S9+</strong>&nbsp;c&oacute; camera k&eacute;p 12 MP ở mặt sau với c&ocirc;ng nghệ OIS, Dual Pixel v&agrave; đặc biệt l&agrave; khả năng thay đổi khẩu độ linh hoạt từ f/1.5 đến f/2.4 để chụp ảnh x&oacute;a ph&ocirc;ng tốt hơn v&agrave; chụp ảnh thiếu s&aacute;ng chất lượng hơn. Đặc biệt, m&aacute;y c&ograve;n c&oacute; khả năng quay video si&ecirc;u chạm (slow-motion) ở tốc độ 960fps cho độ ph&acirc;n giải HD mang lại những thước phim đầy nghệ thuật.</p>

<p>&nbsp;</p>

<h3><strong>Dung lượng pin kh&aacute;</strong></h3>

<p>&nbsp;</p>

<p><img alt="samsung-galaxy-s9-plus" longdesc="https://fptshop.com.vn/dien-thoai/samsung-galaxy-s9-plus" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/samsung-galaxy-s9-plus/samsung-galaxy-s9-plus-5.JPG" title="samsung-galaxy-s9-plus" /></p>

<p>&nbsp;</p>

<p><strong>Galaxy S9+</strong>&nbsp;với vi&ecirc;n pin c&oacute; dung lượng l&ecirc;n đến 3500 mAh c&ugrave;ng con chip thế hệ mới, m&aacute;y&nbsp;cho thời gian hoạt động ấn tượng, đủ để người d&ugrave;ng thoải m&aacute;i l&agrave;m việc v&agrave; giải tr&iacute; ở cường độ cao trong ng&agrave;y.</p>
', CAST(18000000 AS Decimal(18, 0)), CAST(13000000 AS Decimal(18, 0)), 3, N'2560 x 1440 pixels', N'5.5                 ', N'8.0 MP', N'8.0 MP', N'4 nhân 2.3GHz + 4 nhân 1.7GHz', N'8 Nhân', N'Exynos 8895', N'64 GB', N'64 GB', N'Android 8.0', N'Li-Ion', N'3000Mah', N'2 sim Dual SIM', N'Wi-Fi 802.11 a/b/g/n/ac', N'v5.0', N'A-GPS, GLONASS, BDS')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (10, N'iphone', 4, CAST(N'2018-05-23 00:54:39.327' AS DateTime), N'Duong', CAST(N'2018-05-26 04:09:25.073' AS DateTime), N'Duong', 1, N'/ckfinder/userfiles/images/636552333148760332_1.jpg', NULL, 1, 0, NULL, N'CPU: Exynos 9810', N'<h3 style="text-align:center"><strong>Đ&aacute;nh gi&aacute; chi tiết Samsung Galaxy S9+ Lilac Purple 128GB</strong></h3>

<p>Thế hệ&nbsp;điện thoại&nbsp;<strong>Samsung Galaxy S</strong>&nbsp;tiếp tục được&nbsp;<strong>Samsung</strong>&nbsp;n&acirc;ng l&ecirc;n một tầm cao mới. Với&nbsp;<strong>Samsung Galaxy S9+ Lilac Purple 128 GB</strong>, bạn sẽ &ldquo;nh&igrave;n thấy điều kh&ocirc;ng thể&rdquo; nhờ bộ phận camera được cải tiến to&agrave;n diện.</p>

<h3><strong>Thiết kế tinh tế</strong></h3>

<p>&nbsp;</p>

<p><img alt="samsung-galaxy-s9-plus-lilac-purple" longdesc="https://fptshop.com.vn/dien-thoai/samsung-galaxy-s9-plus-lilac-purple" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/samsung-galaxy-s9-plus-lilac-purple/samsung-galaxy-s9-plus-lilac-purple-1.JPG" title="samsung-galaxy-s9-plus-lilac-purple" /></p>

<p>&nbsp;</p>

<p><strong>Samsung Galaxy S9+ Lilac Purple</strong>&nbsp;to&aacute;t l&ecirc;n sự cuốn h&uacute;t, khơi dậy cảm gi&aacute;c th&iacute;ch th&uacute; cho người d&ugrave;ng ngay từ c&aacute;i nh&igrave;n đầu ti&ecirc;n với thiết kế m&agrave;n h&igrave;nh cong v&ocirc; cực, khung kim loại cứng c&aacute;p v&agrave; hai mặt k&iacute;nh cường lực b&oacute;ng bẩy.</p>

<h3><strong>M&agrave;n h&igrave;nh sắc n&eacute;t</strong></h3>

<p>&nbsp;</p>

<p><img alt="samsung-galaxy-s9-plus-lilac-purple" longdesc="https://fptshop.com.vn/dien-thoai/samsung-galaxy-s9-plus-lilac-purple" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/samsung-galaxy-s9-plus-lilac-purple/samsung-galaxy-s9-plus-lilac-purple2.JPG" title="samsung-galaxy-s9-plus-lilac-purple" /></p>

<p>&nbsp;</p>

<p>M&agrave;n h&igrave;nh 6.2 inch tr&ecirc;n&nbsp;<strong>Samsung Galaxy S9+ Lilac Purple</strong>&nbsp;c&oacute; độ ph&acirc;n giải 2K+, sử dụng tấm nền Super AMOLED hỗ trợ HDR. Mọi chi tiết tr&ecirc;n h&igrave;nh ảnh hay video đều được t&aacute;i tạo sắc n&eacute;t với m&agrave;u sắc trung thực, sống động như đang nh&igrave;n thấy ngay trước mắt. Ngo&agrave;i ra&nbsp;<strong>Galaxy S9+ Lilac Purple</strong>&nbsp;t&iacute;ch hợp chuẩn kh&aacute;ng bụi &ndash; kh&aacute;ng nước IP68, gi&uacute;p bạn thoải m&aacute;i nghe nhạc b&ecirc;n hồ bơi, nhận cuộc gọi giữa trời mưa v&agrave; y&ecirc;n t&acirc;m khi chẳng may l&agrave;m rơi m&aacute;y xuống nước.</p>

<h3><strong>Hiệu năng ấn tượng</strong></h3>

<p>&nbsp;</p>

<p><img alt="samsung-galaxy-s9-plus-lilac-purple" longdesc="https://fptshop.com.vn/dien-thoai/samsung-galaxy-s9-plus-lilac-purple" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/samsung-galaxy-s9-plus-lilac-purple/samsung-galaxy-s9-plus-lilac-purple3.JPG" title="samsung-galaxy-s9-plus-lilac-purple" /></p>

<p>&nbsp;</p>

<p>Với vi xử l&yacute; Exynos 9810 8 nh&acirc;n c&ugrave;ng bộ nhớ RAM l&ecirc;n đến 6 GB,&nbsp;<strong>Samsung Galaxy S9+ Lilac Purple</strong>&nbsp;cho điểm số thuộc top đầu thị trường ở những b&agrave;i kiểm tra hiệu năng bằng phần mềm. C&ograve;n trong qu&aacute; tr&igrave;nh sử dụng thực tế, tốc độ xử l&yacute; v&agrave; khả năng chạy đa nhiệm của m&aacute;y cũng v&ocirc; c&ugrave;ng ấn tượng.</p>

<h3><strong>Camera được n&acirc;ng cấp</strong></h3>

<p>&nbsp;</p>

<p><img alt="samsung-galaxy-s9-plus-lilac-purple" longdesc="https://fptshop.com.vn/dien-thoai/samsung-galaxy-s9-plus-lilac-purple" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/samsung-galaxy-s9-plus-lilac-purple/samsung-galaxy-s9-plus-lilac-purple4.JPG" title="samsung-galaxy-s9-plus-lilac-purple" /></p>

<p>&nbsp;</p>

<p>Điện thoại&nbsp;<strong>Samsung Galaxy S9+ Lilac Purple</strong>&nbsp;c&oacute; camera k&eacute;p 12 MP ở mặt sau với c&ocirc;ng nghệ OIS, Dual Pixel v&agrave; đặc biệt l&agrave; khả năng thay đổi khẩu độ linh hoạt từ f/1.5 đến f/2.4 để chụp ảnh x&oacute;a ph&ocirc;ng tốt hơn v&agrave; chụp ảnh thiếu s&aacute;ng chất lượng hơn. Đặc biệt, m&aacute;y c&ograve;n c&oacute; khả năng quay video si&ecirc;u chạm (slow-motion) ở tốc độ 960fps cho độ ph&acirc;n giải HD mang lại những thước phim đầy nghệ thuật.</p>

<h3><strong>Dung lượng pin kh&aacute;</strong></h3>

<p>&nbsp;</p>

<p><img alt="samsung-galaxy-s9-plus-lilac-purple" longdesc="https://fptshop.com.vn/dien-thoai/samsung-galaxy-s9-plus-lilac-purple" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/samsung-galaxy-s9-plus-lilac-purple/samsung-galaxy-s9-plus-lilac-purple5.JPG" title="samsung-galaxy-s9-plus-lilac-purple" /></p>

<p>&nbsp;</p>

<p><strong>Samsung Galaxy S9+ Lilac Purple</strong>&nbsp;với vi&ecirc;n pin c&oacute; dung lượng l&ecirc;n đến 3500 mAh c&ugrave;ng con chip thế hệ mới, m&aacute;y&nbsp;cho thời gian hoạt động ấn tượng, đủ để người d&ugrave;ng thoải m&aacute;i l&agrave;m việc v&agrave; giải tr&iacute; ở cường độ cao trong ng&agrave;y.</p>

<p><em>Lưu &yacute;: B&agrave;i viết v&agrave; h&igrave;nh ảnh chỉ c&oacute; t&iacute;nh chất tham khảo v&igrave; cấu h&igrave;nh v&agrave; đặc t&iacute;nh sản phẩm c&oacute; thể thay đổi theo thị trường v&agrave; từng phi&ecirc;n bản. Vui l&ograve;ng gọi tổng đ&agrave;i miễn ph&iacute; 18006601 hoặc đến cửa h&agrave;ng FPT Shop để nhận th&ocirc;ng tin ch&iacute;nh x&aacute;c nhất về sản phẩm.</em></p>

<p>Minhtri Bin</p>

<p>&nbsp;</p>

<p>R&uacute;t gọn&nbsp;<em>▴</em></p>

<h2>Th&ocirc;ng số kỹ thuật của Samsung Galaxy S9+ Lilac Purple 128GB</h2>

<ul>
	<li>Th&ocirc;ng số cơ bản</li>
	<li>Độ ph&acirc;n giải m&agrave;n h&igrave;nh :2K (1440 x 2960 Pixels)</li>
	<li>Camera trước :8 MP</li>
	<li>Camera sau :2 camera 12 MP</li>
	<li>Tốc độ CPU :4 nh&acirc;n 2.8 GHz &amp; 4 nh&acirc;n 1.7 GHz</li>
	<li>Số nh&acirc;n :4 nh&acirc;n 2.8 GHz &amp; 4 nh&acirc;n 1.7 GHz</li>
	<li>Chipset :Exynos 9810 8 nh&acirc;n 64 bit</li>
	<li>RAM :6 GB</li>
	<li>Chip đồ họa (GPU) :Mali-G72 MP18</li>
	<li>ROM :128 GB</li>
	<li>K&iacute;ch thước :D&agrave;i 158.1 mm - Ngang 73.8 mm - 8.5 mm</li>
	<li>Hệ điều h&agrave;nh :Android 8.0</li>
	<li>M&agrave;n h&igrave;nh</li>
	<li>C&ocirc;ng nghệ m&agrave;n h&igrave;nh :Super AMOLED</li>
	<li>M&agrave;u m&agrave;n h&igrave;nh :Đang cập nhật</li>
	<li>Chuẩn m&agrave;n h&igrave;nh :Full HD</li>
	<li>Độ ph&acirc;n giải m&agrave;n h&igrave;nh :2K (1440 x 2960 Pixels)</li>
	<li>C&ocirc;ng nghệ cảm ứng :Đang cập nhật</li>
	<li>Mặt k&iacute;nh m&agrave;n h&igrave;nh :Corning Gorilla Glass 5</li>
	<li>Camera Trước</li>
	<li>Độ ph&acirc;n giải :8 MP</li>
	<li>Th&ocirc;ng tin kh&aacute;c :Chụp bằng giọng n&oacute;i,&nbsp;Nhận diện khu&ocirc;n mặt,&nbsp;Chế độ l&agrave;m đẹp,&nbsp;Quay video Full HD,&nbsp;Tự động lấy n&eacute;t,&nbsp;Đ&egrave;n Flash trợ s&aacute;ng,&nbsp;Camera g&oacute;c rộng,&nbsp;Selfie ngược s&aacute;ng HDR,&nbsp;Tự động chụp khi nhận diện nụ cười,&nbsp;Selfie bằng cử chỉ</li>
	<li>Camera Sau</li>
	<li>Độ ph&acirc;n giải :2 camera 12 MP</li>
	<li>Quay phim :Quay phim si&ecirc;u chậm 960 fps,&nbsp;Quay phim FullHD 1080p@60fps,&nbsp;Quay phim 4K 2160p@60fps</li>
	<li>Đ&egrave;n Flash :C&oacute;</li>
	<li>Chụp ảnh n&acirc;ng cao :Zoom quang học (Camera k&eacute;p),Chụp ảnh x&oacute;a ph&ocirc;ng,&nbsp;Chế độ chụp ban đ&ecirc;m (&aacute;nh s&aacute;ng yếu),Điều chỉnh khẩu độ,Super Slow motion (quay si&ecirc;u chậm),Tự động lấy n&eacute;t,Chạm lấyn&eacute;t,&nbsp;HDR,&nbsp;Panorama,&nbsp;Chống rung quang học (OIS), Ảnh GIF,&nbsp;Chế độ chụp chuy&ecirc;n nghiệp</li>
	<li>Cấu h&igrave;nh phần cứng</li>
	<li>Tốc độ CPU :4 nh&acirc;n 2.8 GHz &amp; 4 nh&acirc;n 1.7 GHz</li>
	<li>Số nh&acirc;n :4 nh&acirc;n 2.8 GHz &amp; 4 nh&acirc;n 1.7 GHz</li>
	<li>Chipset :Exynos 9810 8 nh&acirc;n 64 bit</li>
	<li>RAM :6 GB</li>
	<li>Chip đồ họa (GPU) :Mali-G72 MP18</li>
	<li>Cảm biến :V&acirc;n tay 1 chạm v&agrave; nhịp tim</li>
	<li>Bộ nhớ &amp; Lưu trữ</li>
	<li>Danh bạ lưu trữ :Đang cập nhật</li>
	<li>ROM :128 GB</li>
	<li>Bộ nhớ c&ograve;n lại :Đang cập nhật</li>
	<li>Thẻ nhớ ngo&agrave;i :MicroSD</li>
	<li>Hỗ trợ thẻ nhớ tối đa :400 GB</li>
	<li>Thiết kế &amp; Trọng lượng</li>
	<li>Kiểu d&aacute;ng :Nguy&ecirc;n khối</li>
	<li>Chất liệu :Khung kim loại + mặt k&iacute;nh cường lực</li>
	<li>K&iacute;ch thước :D&agrave;i 158.1 mm - Ngang 73.8 mm - 8.5 mm</li>
	<li>Trọng lượng :189 g</li>
	<li>Khả năng chống nước :C&oacute;</li>
	<li>Th&ocirc;ng tin pin</li>
	<li>Loại pin :Pin chuẩn Li-Ion</li>
	<li>Dung lượng pin :3500 mAh</li>
	<li>Pin c&oacute; thể th&aacute;o rời :Kh&ocirc;ng</li>
	<li>Thời gian chờ :Đang cập nhật</li>
	<li>Thời gian đ&agrave;m thoại :Đang cập nhật</li>
	<li>Thời gian sạc đầy :Đang cập nhật</li>
	<li>Chế độ sạc nhanh :C&oacute;</li>
	<li>Kết nối &amp; Cổng giao tiếp</li>
	<li>Băng tần 2G :C&oacute;</li>
	<li>Băng tần 3G :C&oacute;</li>
	<li>Băng tần 4G :C&oacute;</li>
	<li>Hỗ trợ SIM :Nano Sim</li>
	<li>Khe cắm sim :2 Sim (Sim 2 chung khe thẻ nhớ)</li>
	<li>Wifi :Wi-Fi 802.11 a/b/g/n/ac,&nbsp;Dual-band,&nbsp;DLNA,&nbsp;Wi-Fi Direct,&nbsp;Wi-Fi hotspot</li>
	<li>GPS :BDS,&nbsp;A-GPS,&nbsp;GLONASS</li>
	<li>Bluetooth :v5.0,&nbsp;apt-X,&nbsp;A2DP,&nbsp;LE</li>
	<li>GPRS/EDGE :C&oacute;</li>
	<li>NFC :C&oacute;</li>
	<li>Cổng sạc :USB Type-C</li>
	<li>Jack (Input &amp; Output) :3.5 mm</li>
	<li>Giải tr&iacute; &amp; Ứng dụng</li>
	<li>Xem phim :H.265,&nbsp;3GP,&nbsp;MP4,&nbsp;AVI,&nbsp;WMV,&nbsp;H.264(MPEG4-AVC),&nbsp;DivX,&nbsp;WMV9,&nbsp;Xvid</li>
	<li>Nghe nhạc :Midi,&nbsp;Lossless,&nbsp;MP3,&nbsp;WAV,&nbsp;WMA,&nbsp;AAC++,&nbsp;eAAC+,&nbsp;OGG,&nbsp;AC3,&nbsp;FLAC</li>
	<li>Ghi &acirc;m :C&oacute;</li>
	<li>FM radio :C&oacute;</li>
	<li>Đ&egrave;n pin :C&oacute;</li>
	<li>Chức năng kh&aacute;c :Mở kh&oacute;a bằng khu&ocirc;n mặt,&nbsp;Mở kh&oacute;a bằng v&acirc;n tay,&nbsp;Qu&eacute;t mống mắt</li>
	<li>Bảo h&agrave;nh</li>
	<li>Thời gian bảo h&agrave;nh :12 th&aacute;ng</li>
	<li>Hệ điều h&agrave;nh</li>
	<li>Hệ điều h&agrave;nh :Android 8.0</li>
</ul>
', CAST(22000000 AS Decimal(18, 0)), CAST(23300000 AS Decimal(18, 0)), 2, N'2560 x 1440 pixels', N'5.5                 ', N'8.0 MP', N'8.0 MP', N'	4 nhân 2.3GHz + 4 nhân 1.7GHz', N'8 Nhân', N'	Exynos 8895', N'4GB', N'64 GB', N'Android 8.0', N'Li-Ion', N'3000Mah', N'2 sim Dual SIM', N'Wi-Fi 802.11 a/b/g/n/ac', N'v5.0', N'A-GPS, GLONASS, BDS')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (11, N'iPhone X 64GB', 12, CAST(N'2018-05-23 00:55:09.037' AS DateTime), N'Duong', CAST(N'2018-05-24 02:52:32.287' AS DateTime), N'Duong', 1, N'/ckfinder/userfiles/images/636483223586180190_1.jpg', NULL, 1, 0, NULL, N'Camera: 7.0 MP/ Dual 12.0 MP', N'<h3 style="text-align:center"><strong>Đ&aacute;nh gi&aacute; chi tiết iPhone X 64GB</strong></h3>

<p>Đ&atilde; l&acirc;u lắm rồi Apple mới ra mắt một sản phẩm với thiết kế đột ph&aacute; v&agrave; liều lĩnh. D&ugrave; vấp phải kh&aacute; nhiều &yacute; kiến tr&aacute;i chiều nhưng cũng kh&ocirc;ng thể phủ nhận độ hấp dẫn của chiếc iPhone thế hệ thứ 10 n&agrave;y. C&ocirc;ng nghệ bảo mật mới, loại bỏ n&uacute;t home truyền thống, camera với những t&iacute;nh năng độc quyền, tất cả đ&atilde; khiến người d&ugrave;ng đứng ngồi kh&ocirc;ng y&ecirc;n cho đến khi được tr&ecirc;n tay.</p>

<p>&nbsp;</p>

<h3><strong>iPhone X 64GB c&oacute; thiết kế lột x&aacute;c ho&agrave;n to&agrave;n</strong></h3>

<p>&nbsp;</p>

<p><img alt="iPhone X 64GB có thiết kế lột xác hoàn toàn" id="iPhone X 64GB có thiết kế lột xác hoàn toàn" longdesc="https://be.fptshop.com.vn/iphone-x-64gb" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/T10/iphone-x-64gb/iphone-x-64gb-1.jpg" title="iPhone X 64GB có thiết kế lột xác hoàn toàn" /></p>

<p>&nbsp;</p>

<p><strong><a href="https://fptshop.com.vn/dien-thoai/iphone-x" target="_blank">iPhone X 64GB</a>&nbsp;</strong>đ&atilde; lột x&aacute;c ho&agrave;n to&agrave;n với việc loại bỏ n&uacute;t Home truyền thống, m&agrave;n h&igrave;nh tr&agrave;n viền v&agrave; camera k&eacute;p ở ph&iacute;a sau đ&atilde; được đặt lại vị tr&iacute; theo chiều dọc. Khung viền từ th&eacute;p s&aacute;ng b&oacute;ng bền bỉ v&agrave; mặt lưng k&iacute;nh với c&aacute;c g&oacute;c bo tr&ograve;n dễ d&agrave;ng cầm nắm. C&oacute; thể n&oacute;i đ&acirc;y l&agrave; một thiết kế kh&aacute; đột ph&aacute; m&agrave; l&acirc;u lắm rồi Apple mới thể hiện lại. Người d&ugrave;ng cần phải tr&ecirc;n tay th&igrave; mới cảm nhận được hết n&eacute;t tinh tế v&agrave; sang trọng của sản phẩm.</p>

<p>&nbsp;</p>

<h3><strong>M&agrave;n h&igrave;nh của iPhone X 64GB hiển thị đẹp hơn</strong></h3>

<p>&nbsp;</p>

<p><img alt="iphone-x-64gb" longdesc="https://be.fptshop.com.vn/iphone-x-64gb" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/T10/iphone-x-64gb/iphone-x-64gb-3.jpg" title="iphone-x-64gb" /></p>

<p>&nbsp;</p>

<p><strong>iPhone X 64GB</strong>&nbsp;l&agrave; chiếc smartphone đầu ti&ecirc;n được Apple ưu &aacute;i cho tấm nền m&agrave;n h&igrave;nh OLED, k&iacute;ch thước 5.8 inch v&agrave; độ ph&acirc;n giải đạt chuẩn Super Retina HD, Điều n&agrave;y gi&uacute;p cho m&agrave;n h&igrave;nh c&oacute; m&agrave;u sắc sống động, g&oacute;c nh&igrave;n rộng hơn, cải thiện độ s&aacute;ng v&agrave; tốn &iacute;t điện năng hơn. B&ecirc;n cạnh đ&oacute;, c&ocirc;ng nghệ True Tone c&ograve;n gi&uacute;p m&agrave;u sắc trở n&ecirc;n cực k&igrave; trung thực.</p>

<p>&nbsp;</p>

<h3><strong>iPhone X 64GB được trang bị c&ocirc;ng nghệ bảo mật mới ho&agrave;n to&agrave;n</strong></h3>

<p>&nbsp;</p>

<p><img alt="iPhone X 64GB được trang bị công nghệ bảo mật mới hoàn toàn" id="iPhone X 64GB được trang bị công nghệ bảo mật mới hoàn toàn" longdesc="https://be.fptshop.com.vn/iphone-x-64gb" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/T10/iphone-x-64gb/iphone-x-64gb-4.jpg" title="iPhone X 64GB được trang bị công nghệ bảo mật mới hoàn toàn" /></p>

<p>&nbsp;</p>

<p>Với thiết kế loại bỏ n&uacute;t Home truyền thống vốn được xem l&agrave; biểu tượng của Apple, c&ocirc;ng nghệ bảo mật mới &ndash; Face ID lần đầu ti&ecirc;n xuất hiện tr&ecirc;n một chiếc iPhone với hiệu quả cao gấp 20 lần so với Touch ID, c&oacute; khả năng nhận diện khu&ocirc;n mặt cực k&igrave; chuẩn x&aacute;c d&ugrave; bạn cao đi r&acirc;u, để t&oacute;c d&agrave;i, th&acirc;n h&igrave;nh mập ra,&hellip; Face ID vẫn dễ d&agrave;ng nhận ra bạn.</p>

<h3><br />
<strong>Camera ấn tượng với t&iacute;nh năng độc quyền</strong></h3>

<p>&nbsp;</p>

<p><img alt="Camera ấn tượng với tính năng độc quyền" id="Camera ấn tượng với tính năng độc quyền" longdesc="https://be.fptshop.com.vn/iphone-x-64gb" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/T10/iphone-x-64gb/iphone-x-64gb-2.jpg" title="Camera ấn tượng với tính năng độc quyền" /></p>

<p>&nbsp;</p>

<p><strong>iPhone X 64GB</strong>&nbsp;c&oacute; 3 t&iacute;nh năng độc quyền cho camera trước l&agrave; Portrait Mode Selfie (x&oacute;a ph&ocirc;ng), Portrait Lighting (&aacute;nh s&aacute;ng ch&acirc;n dung), Animoji (biểu tượng cảm x&uacute;c) c&oacute; thể bắt chước điệu bộ khu&ocirc;n mặt v&agrave; giọng n&oacute;i người d&ugrave;ng. Kh&aacute;c biệt lớn nhất của iPhone X l&agrave; chức năng chống rung (OIS) cho cả ống k&iacute;nh g&oacute;c rộng v&agrave; tele ở camera sau, đồng nghĩa<strong>&nbsp;iPhone X</strong>&nbsp;c&oacute; thể chụp ảnh sắc n&eacute;t hơn trong mọi trường hợp.</p>

<h3>&nbsp;</h3>

<h3><strong>Tăng tốc độ phần cứng của iPhone X 64GB</strong></h3>

<p>&nbsp;</p>

<p><img alt="Tăng tốc độ phần cứng của iPhone X 64GB" id="Tăng tốc độ phần cứng của iPhone X 64GB" longdesc="https://be.fptshop.com.vn/iphone-x-64gb" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/T10/iphone-x-64gb/iphone-x-64gb-5.jpg" title="Tăng tốc độ phần cứng của iPhone X 64GB" /></p>

<p>&nbsp;</p>

<p><strong>iPhone X 64GB&nbsp;</strong>được cung cấp sức mạnh bởi chip xử l&yacute; A11 Bionic s&aacute;u l&otilde;i (Hexa core) 64 bit, gồm 2 l&otilde;i hiệu suất cao v&agrave; 4 l&otilde;i hiệu suất thấp hơn. Ước t&iacute;nh, tốc độ của 2 l&otilde;i hiệu suất cao c&oacute; tốc độ nhanh hơn 25% so với chip A10 cũ, gi&uacute;p tiết kiệm năng lượng l&ecirc;n tới 70%. Ngo&agrave;i ra, chip xử l&yacute; đồ họa GPU M11 cũng gi&uacute;p cải thiện tốc độ l&ecirc;n khoảng 30% so với GPU năm ngo&aacute;i. Nhờ sự kết hợp n&agrave;y, người d&ugrave;ng sẽ c&oacute; cơ hội lướt game nhanh v&agrave; &ldquo;mượt&rdquo; hơn.</p>

<p>&nbsp;</p>

<h3><strong>Pin của iPhone X 64GB bền bỉ, hỗ trợ sạc kh&ocirc;ng d&acirc;y</strong></h3>

<p>&nbsp;</p>

<p><img alt="Pin của iPhone X 64GB bền bỉ, hỗ trợ sạc không dây" id="Pin của iPhone X 64GB bền bỉ, hỗ trợ sạc không dây" longdesc="https://be.fptshop.com.vn/iphone-x-64gb" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/T10/iphone-x-64gb/iphone-x-64gb-6.jpg" title="Pin của iPhone X 64GB bền bỉ, hỗ trợ sạc không dây" /></p>

<p>&nbsp;</p>

<p>Theo c&ocirc;ng bố, thời lượng pin của iPhone X sẽ l&acirc;u hơn iPhone 7 khoảng 2 giờ đồng hồ. Hai t&iacute;nh năng th&uacute; vị kh&aacute;c cũng được đưa l&ecirc;n sản phẩm: sạc nhanh (sạc pin 50% chỉ trong 30 ph&uacute;t) v&agrave; sạc kh&ocirc;ng d&acirc;y Qi. Với tấm sạc Air Power của h&atilde;ng, bạn c&oacute; thể sạc c&ugrave;ng l&uacute;c iPhone X, đồng hồ Apple Watch v&agrave; tai nghe kh&ocirc;ng d&acirc;y Air Pods.</p>

<p>&nbsp;</p>

<p><em>Lưu &yacute;: B&agrave;i viết v&agrave; h&igrave;nh ảnh chỉ c&oacute; t&iacute;nh chất tham khảo v&igrave; cấu h&igrave;nh v&agrave; đặc t&iacute;nh sản phẩm c&oacute; thể thay đổi theo thị trường v&agrave; từng phi&ecirc;n bản. Vui l&ograve;ng gọi tổng đ&agrave;i miễn ph&iacute; 18006601 hoặc đến cửa h&agrave;ng FPT Shop để nhận th&ocirc;ng tin ch&iacute;nh x&aacute;c nhất về sản phẩm.</em></p>

<p><em>Via Ph&uacute;c</em></p>

<p>R&uacute;t gọn&nbsp;<em>▴</em></p>

<h2>Th&ocirc;ng số kỹ thuật của iPhone X 64GB</h2>

<ul>
	<li>Th&ocirc;ng số cơ bản</li>
	<li>Độ ph&acirc;n giải m&agrave;n h&igrave;nh :2436 x 1125 pixel</li>
	<li>Camera trước :7.0 MP</li>
	<li>Camera sau :Dual 12.0 MP</li>
	<li>Số nh&acirc;n :6</li>
	<li>Chipset :Apple A11 Bionic</li>
	<li>RAM :3 GB</li>
	<li>Chip đồ họa (GPU) :Apple GPU (three-core graphics)</li>
	<li>ROM :64 GB</li>
	<li>K&iacute;ch thước :143.6 x 70.9 x 7.7 mm</li>
	<li>Hệ điều h&agrave;nh :iOS 11</li>
	<li>M&agrave;n h&igrave;nh</li>
	<li>C&ocirc;ng nghệ m&agrave;n h&igrave;nh :OLED Multi-Touch display HDR display</li>
	<li>M&agrave;u m&agrave;n h&igrave;nh :16 Triệu m&agrave;u</li>
	<li>Chuẩn m&agrave;n h&igrave;nh :Super Retina HD</li>
	<li>Độ ph&acirc;n giải m&agrave;n h&igrave;nh :2436 x 1125 pixel</li>
	<li>C&ocirc;ng nghệ cảm ứng :3D Touch</li>
	<li>Mặt k&iacute;nh m&agrave;n h&igrave;nh :K&iacute;nh cường lực</li>
	<li>Camera Trước</li>
	<li>Video Call :C&oacute;</li>
	<li>Độ ph&acirc;n giải :7.0 MP</li>
	<li>Th&ocirc;ng tin kh&aacute;c :&fnof;/2.2, Auto HDR</li>
	<li>Camera Sau</li>
	<li>Độ ph&acirc;n giải :Dual 12.0 MP</li>
	<li>Quay phim :4K video recording at 24 fps, 30 fps, or 60 fps</li>
	<li>Đ&egrave;n Flash :C&oacute;</li>
	<li>Chụp ảnh n&acirc;ng cao :Auto HDR, Live Photos, Panorama...</li>
	<li>Cấu h&igrave;nh phần cứng</li>
	<li>Số nh&acirc;n :6</li>
	<li>Chipset :Apple A11 Bionic</li>
	<li>RAM :3 GB</li>
	<li>Chip đồ họa (GPU) :Apple GPU (three-core graphics)</li>
	<li>Bộ nhớ &amp; Lưu trữ</li>
	<li>Danh bạ lưu trữ :Kh&ocirc;ng giới hạn</li>
	<li>ROM :64 GB</li>
	<li>Thẻ nhớ ngo&agrave;i :Kh&ocirc;ng</li>
	<li>Hỗ trợ thẻ nhớ tối đa :Kh&ocirc;ng</li>
	<li>Thiết kế &amp; Trọng lượng</li>
	<li>Kiểu d&aacute;ng :Thanh (thẳng) + Cảm ứng</li>
	<li>Chất liệu :Khung kim loại + mặt k&iacute;nh cường lực</li>
	<li>K&iacute;ch thước :143.6 x 70.9 x 7.7 mm</li>
	<li>Trọng lượng :174 g</li>
	<li>Khả năng chống nước :Chuẩn IP67</li>
	<li>Th&ocirc;ng tin pin</li>
	<li>Loại pin :Li-Ion</li>
	<li>Dung lượng pin :2716 mAh</li>
	<li>Pin c&oacute; thể th&aacute;o rời :Kh&ocirc;ng</li>
	<li>Kết nối &amp; Cổng giao tiếp</li>
	<li>NFC :C&oacute;</li>
	<li>Kết nối USB :Lightning</li>
	<li>Cổng sạc :Lightning</li>
	<li>Jack (Input &amp; Output) :Lightning</li>
	<li>Băng tần 2G :GSM/EDGE (850, 900, 1800, 1900 MHz)</li>
	<li>Băng tần 3G :UMTS/HSPA+/DC-HSDPA (850, 900, 1700/2100, 1900, 2100 MHz)</li>
	<li>Băng tần 4G :C&oacute;</li>
	<li>Hỗ trợ SIM :Nano Sim</li>
	<li>Khe cắm sim :1 Sim</li>
	<li>Wifi :802.11ac Wi‑Fi with MIMO</li>
	<li>GPS :C&oacute;</li>
	<li>Bluetooth :v5.0</li>
	<li>Giải tr&iacute; &amp; Ứng dụng</li>
	<li>Xem phim :HEVC, H.264, MPEG-4 Part 2, and Motion JPEG</li>
	<li>Nghe nhạc :AAC-LC, HE-AAC, HE-AAC v2, Protected AAC, MP3, Linear PCM, Apple Lossless, FLAC</li>
	<li>Ghi &acirc;m :C&oacute;</li>
	<li>Đ&egrave;n pin :C&oacute;</li>
	<li>Bảo h&agrave;nh</li>
	<li>Thời gian bảo h&agrave;nh :12 Th&aacute;ng</li>
	<li>Hệ điều h&agrave;nh</li>
	<li>Hệ điều h&agrave;nh :iOS 11</li>
</ul>
', CAST(2920000 AS Decimal(18, 0)), CAST(3300000 AS Decimal(18, 0)), 12, N'2560 x 1440 pixels', N'5.5                 ', N'8.0 MP', N'8.0 MP', N'	4 nhân 2.3GHz + 4 nhân 1.7GHz', N'8 Nhân', N'	Exynos 8895', N'4GB', N'64 GB', N'Android 8.0', N'Li-Ion', N'3000Mah', N'2 sim Dual SIM', N'Wi-Fi 802.11 a/b/g/n/ac', N'v5.0', N'A-GPS, GLONASS, BDS')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (12, N'iPhone 7 Plus 32GB', 1, CAST(N'2018-05-23 00:55:59.597' AS DateTime), N'Duong', CAST(N'2018-05-24 02:50:07.923' AS DateTime), N'Duong', 1, N'/ckfinder/userfiles/images/636159432323817451_ip7p-gold-1.jpg', NULL, 1, 0, NULL, N'Màn Hình: 5.5 inch (1920 x 1080 pixels)', N'<h3><strong>Đ&aacute;nh gi&aacute; chi tiết iPhone 8 Plus 256GB PRODUCT RED</strong></h3>

<p>Apple vừa giới thiệu phi&ecirc;n bản m&agrave;u đỏ PRODUCT RED cho bộ đ&ocirc;i iPhone 8 v&agrave; 8 Plus. Điểm đặc biệt, sản phẩm nằm trong mối hợp t&aacute;c giữa T&aacute;o khuyết với (RED), tổ chức g&acirc;y quỹ ph&ograve;ng chống HIV/AIDS tại ch&acirc;u Phi v&agrave; một phần doanh thu b&aacute;n&nbsp;<strong>iPhone 8 v&agrave; iPhone 8 Plus RED - Đỏ</strong>&nbsp;sẽ được quy&ecirc;n g&oacute;p cho quỹ từ thiện của (RED).</p>

<h3><strong>Thiết kế h&agrave;i h&ograve;a</strong></h3>

<p>&nbsp;</p>

<p><img alt="iphone-8-plus-256G-product-red" longdesc="https://fptshop.com.vn/dien-thoai/iphone-8-plus-256G-product-red" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/iphone-8-plus-256G-product-red/iphone-8-plus-256G-product-red1.jpg" title="iphone-8-plus-256G-product-red" /></p>

<p><br />
<strong>Apple iPhone 8 Plus 256 GB PRODUCT RED</strong>&nbsp;được thay đổi về chất liệu so với iPhone 7 Plus: khung nh&ocirc;m cứng c&aacute;p kết hợp c&ugrave;ng mặt k&iacute;nh cường lực b&oacute;ng bẩy ở mặt sau. Điểm nổi bật ở phi&ecirc;n bản n&agrave;y l&agrave; ri&ecirc;ng mặt lưng lại c&oacute; m&agrave;u đỏ v&agrave; mặt trước lại c&oacute; m&agrave;u đen nh&igrave;n h&agrave;i h&ograve;a v&agrave; đẹp hơn so với mặt trước m&agrave;u trắng của iPhone 7 / 7 Plus đỏ.</p>

<h3><strong>M&agrave;n h&igrave;nh hiển thị sắc n&eacute;t</strong></h3>

<p>&nbsp;</p>

<p><img alt="iphone-8-plus-256G-product-red" longdesc="https://fptshop.com.vn/dien-thoai/iphone-8-plus-256G-product-red" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/iphone-8-plus-256G-product-red/iphone-8-plus-256G-product-red2.jpg" title="iphone-8-plus-256G-product-red" /></p>

<p><br />
M&agrave;n h&igrave;nh của<strong>&nbsp;iPhone 8 Plus 256 GB PRODUCT RED</strong>&nbsp;c&oacute; k&iacute;ch thước 5.5 inch, độ ph&acirc;n giải Full HD tr&ecirc;n tấm nền IPS LCD mang lại những h&igrave;nh ảnh rất r&otilde; n&eacute;t, mọi chi tiết đều hiển thị r&otilde; r&agrave;ng. Đồng thời c&ocirc;ng nghệ True-tone gi&uacute;p tự điều chỉnh cường độ m&agrave;n h&igrave;nh v&agrave; &aacute;nh s&aacute;ng dựa tr&ecirc;n m&ocirc;i trường xung quanh để t&aacute;i tạo m&agrave;u sắc một c&aacute;ch ch&acirc;n thực nhất.</p>

<h3><strong>Camera k&eacute;p</strong></h3>

<p>&nbsp;</p>

<p><img alt="iphone-8-plus-256G-product-red" longdesc="https://fptshop.com.vn/dien-thoai/iphone-8-plus-256G-product-red" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/iphone-8-plus-256G-product-red/iphone-8-plus-256G-product-red3.jpg" title="iphone-8-plus-256G-product-red" /></p>

<p><br />
<strong>iPhone 8 Plus 256 GB PRODUCT RED</strong>&nbsp;được được trang bị cụm camera k&eacute;p 12 MP ở mặt sau, hỗ trợ tự động lấy n&eacute;t theo pha, cụm 4 đ&egrave;n flash LED 2 t&ocirc;ng m&agrave;u, c&ocirc;ng nghệ chống rung quang học, t&iacute;ch hợp t&iacute;nh năng mới mang t&ecirc;n Portrait Lightning cho ph&eacute;p điều chỉnh &aacute;nh s&aacute;ng trước khi chụp ảnh ch&acirc;n dung ở chế độ selfie. Hai t&iacute;nh năng chụp ảnh x&oacute;a ph&ocirc;ng v&agrave; zoom quang học cũng được cải thiện, gi&uacute;p bạn ghi lại mọi khoảnh khắc đ&aacute;ng nhớ.</p>

<h3><strong>Khả năng chống bụi, chống nước</strong></h3>

<p>&nbsp;</p>

<p><img alt="iphone-8-plus-256G-product-red" longdesc="https://fptshop.com.vn/dien-thoai/iphone-8-plus-256G-product-red" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/iphone-8-plus-256G-product-red/iphone-8-plus-256G-product-red4.jpg" title="iphone-8-plus-256G-product-red" /></p>

<p><br />
Nhờ ti&ecirc;u chuẩn chống bụi &ndash; chống nước IP67 m&agrave; Apple đ&atilde; t&iacute;ch hợp cho<strong>&nbsp;iPhone 8 Plus 256 GB PRODUCT RED</strong>, người d&ugrave;ng y&ecirc;n t&acirc;m nếu chẳng may phải nghe điện thoại dưới trời mưa hoặc v&ocirc; t&igrave;nh l&agrave;m rơi m&aacute;y xuống nước, cụ thể l&agrave; m&aacute;y sẽ c&oacute; khả năng chịu được nước trong 30 ph&uacute;t ở độ s&acirc;u từ 15 cm đến 1 m.</p>

<h3><strong>Thời lượng pin tốt</strong></h3>

<p>&nbsp;</p>

<p><img alt="iphone-8-plus-256G-product-red" longdesc="https://fptshop.com.vn/dien-thoai/iphone-8-plus-256G-product-red" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/iphone-8-plus-256G-product-red/iphone-8-plus-256G-product-red5.jpg" title="iphone-8-plus-256G-product-red" /></p>

<p><br />
<strong>Apple iPhone 8 Plus 256 GB PRODUCT RED&nbsp;</strong>sở hữu vi&ecirc;n pin 2675 mAh, kh&ocirc;ng qu&aacute; cao nhưng nhờ con chip A11 mới tiết kiệm điện v&agrave; hệ điều h&agrave;nh iOS quản l&yacute; điện năng hiệu quả, v&igrave; vậy dễ d&agrave;ng đ&aacute;p ứng một ng&agrave;y d&agrave;i l&agrave;m việc v&agrave; giải tr&iacute; ở cường độ cao. B&ecirc;n cạnh đ&oacute;, sản phẩm cũng được t&iacute;ch hợp hai c&ocirc;ng nghệ hiện đại l&agrave; sạc nhanh v&agrave; sạc kh&ocirc;ng d&acirc;y gi&uacute;p người d&ugrave;ng dễ d&agrave;ng sạc đầy pin cho m&aacute;y.</p>

<p><em>Lưu &yacute;: B&agrave;i viết v&agrave; h&igrave;nh ảnh chỉ c&oacute; t&iacute;nh chất tham khảo v&igrave; cấu h&igrave;nh v&agrave; đặc t&iacute;nh sản phẩm c&oacute; thể thay đổi theo thị trường v&agrave; từng phi&ecirc;n bản. Vui l&ograve;ng gọi tổng đ&agrave;i miễn ph&iacute; 18006601 hoặc đến cửa h&agrave;ng FPT Shop để nhận th&ocirc;ng tin ch&iacute;nh x&aacute;c nhất về sản phẩm.</em></p>

<p>Minhtri Bin</p>

<p><strong>Th&ocirc;ng số kỹ thuật của iPhone 8 Plus 256GB PRODUCT RED</strong></p>

<p>&nbsp;</p>

<table border="1" cellpadding="1" cellspacing="1">
	<tbody>
		<tr>
			<td>Độ ph&acirc;n giải m&agrave;n h&igrave;nh :</td>
			<td>1083 x 1920 pixels</td>
		</tr>
		<tr>
			<td>Camera trước :</td>
			<td>7 MP</td>
		</tr>
		<tr>
			<td>Camera sau :</td>
			<td>2 camera 12 MP</td>
		</tr>
		<tr>
			<td>Tốc độ CPU :</td>
			<td>2.1 GHz</td>
		</tr>
		<tr>
			<td>Số nh&acirc;n :</td>
			<td>2 nh&acirc;n Monsoon v&agrave; 4 nh&acirc;n Mistral</td>
		</tr>
		<tr>
			<td>Chipset :</td>
			<td>Apple A11 Bionic 6 nh&acirc;n</td>
		</tr>
		<tr>
			<td>RAM :</td>
			<td>3GB</td>
		</tr>
		<tr>
			<td>Chip đồ họa (GPU) :</td>
			<td>Apple GPU 3 nh&acirc;n</td>
		</tr>
		<tr>
			<td>ROM :</td>
			<td>256GB</td>
		</tr>
		<tr>
			<td>K&iacute;ch thước :</td>
			<td>D&agrave;i 158.4 mm - Ngang 78.1 mm - D&agrave;y 7.5 mm</td>
		</tr>
		<tr>
			<td>Hệ điều h&agrave;nh :</td>
			<td>iOS11</td>
		</tr>
		<tr>
			<td>Tốc độ CPU :</td>
			<td>2.1 GHz</td>
		</tr>
	</tbody>
</table>
', CAST(13000000 AS Decimal(18, 0)), CAST(14200000 AS Decimal(18, 0)), 3, N'2560 x 1440 pixels', N'5.5                 ', N'8.0 MP', N'8.0 MP', N'	4 nhân 2.3GHz + 4 nhân 1.7GHz', N'8 Nhân', N'	Exynos 8895', N'4GB', N'64 GB', N'Android 8.0', N'Li-Ion', N'3000Mah', N'2 sim Dual SIM', N'Wi-Fi 802.11 a/b/g/n/ac', N'v5.0', N'A-GPS, GLONASS, BDS')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (13, N'iPhone 8 Plus 256GB  RED', 1, CAST(N'2018-05-23 00:56:36.633' AS DateTime), N'Duong', CAST(N'2018-05-24 02:47:39.553' AS DateTime), N'Duong', 1, N'/ckfinder/userfiles/images/636614727176851624_iphone--8-plus-red-4.png', NULL, 1, 0, NULL, N'Sản phẩm chạy Hệ điều hành iOS 11 ', N'<h3 style="text-align:center"><strong>Đ&aacute;nh gi&aacute; chi tiết iPhone 8 Plus 256GB PRODUCT RED</strong></h3>

<p>Apple vừa giới thiệu phi&ecirc;n bản m&agrave;u đỏ PRODUCT RED cho bộ đ&ocirc;i iPhone 8 v&agrave; 8 Plus. Điểm đặc biệt, sản phẩm nằm trong mối hợp t&aacute;c giữa T&aacute;o khuyết với (RED), tổ chức g&acirc;y quỹ ph&ograve;ng chống HIV/AIDS tại ch&acirc;u Phi v&agrave; một phần doanh thu b&aacute;n&nbsp;<strong>iPhone 8 v&agrave; iPhone 8 Plus RED - Đỏ</strong>&nbsp;sẽ được quy&ecirc;n g&oacute;p cho quỹ từ thiện của (RED).</p>

<h3><strong>Thiết kế h&agrave;i h&ograve;a</strong></h3>

<p>&nbsp;</p>

<p><img alt="iphone-8-plus-256G-product-red" longdesc="https://fptshop.com.vn/dien-thoai/iphone-8-plus-256G-product-red" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/iphone-8-plus-256G-product-red/iphone-8-plus-256G-product-red1.jpg" title="iphone-8-plus-256G-product-red" /></p>

<p><br />
<strong>Apple iPhone 8 Plus 256 GB PRODUCT RED</strong>&nbsp;được thay đổi về chất liệu so với iPhone 7 Plus: khung nh&ocirc;m cứng c&aacute;p kết hợp c&ugrave;ng mặt k&iacute;nh cường lực b&oacute;ng bẩy ở mặt sau. Điểm nổi bật ở phi&ecirc;n bản n&agrave;y l&agrave; ri&ecirc;ng mặt lưng lại c&oacute; m&agrave;u đỏ v&agrave; mặt trước lại c&oacute; m&agrave;u đen nh&igrave;n h&agrave;i h&ograve;a v&agrave; đẹp hơn so với mặt trước m&agrave;u trắng của iPhone 7 / 7 Plus đỏ.</p>

<h3><strong>M&agrave;n h&igrave;nh hiển thị sắc n&eacute;t</strong></h3>

<p>&nbsp;</p>

<p><img alt="iphone-8-plus-256G-product-red" longdesc="https://fptshop.com.vn/dien-thoai/iphone-8-plus-256G-product-red" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/iphone-8-plus-256G-product-red/iphone-8-plus-256G-product-red2.jpg" title="iphone-8-plus-256G-product-red" /></p>

<p><br />
M&agrave;n h&igrave;nh của<strong>&nbsp;iPhone 8 Plus 256 GB PRODUCT RED</strong>&nbsp;c&oacute; k&iacute;ch thước 5.5 inch, độ ph&acirc;n giải Full HD tr&ecirc;n tấm nền IPS LCD mang lại những h&igrave;nh ảnh rất r&otilde; n&eacute;t, mọi chi tiết đều hiển thị r&otilde; r&agrave;ng. Đồng thời c&ocirc;ng nghệ True-tone gi&uacute;p tự điều chỉnh cường độ m&agrave;n h&igrave;nh v&agrave; &aacute;nh s&aacute;ng dựa tr&ecirc;n m&ocirc;i trường xung quanh để t&aacute;i tạo m&agrave;u sắc một c&aacute;ch ch&acirc;n thực nhất.</p>

<h3><strong>Camera k&eacute;p</strong></h3>

<p>&nbsp;</p>

<p><img alt="iphone-8-plus-256G-product-red" longdesc="https://fptshop.com.vn/dien-thoai/iphone-8-plus-256G-product-red" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/iphone-8-plus-256G-product-red/iphone-8-plus-256G-product-red3.jpg" title="iphone-8-plus-256G-product-red" /></p>

<p><br />
<strong>iPhone 8 Plus 256 GB PRODUCT RED</strong>&nbsp;được được trang bị cụm camera k&eacute;p 12 MP ở mặt sau, hỗ trợ tự động lấy n&eacute;t theo pha, cụm 4 đ&egrave;n flash LED 2 t&ocirc;ng m&agrave;u, c&ocirc;ng nghệ chống rung quang học, t&iacute;ch hợp t&iacute;nh năng mới mang t&ecirc;n Portrait Lightning cho ph&eacute;p điều chỉnh &aacute;nh s&aacute;ng trước khi chụp ảnh ch&acirc;n dung ở chế độ selfie. Hai t&iacute;nh năng chụp ảnh x&oacute;a ph&ocirc;ng v&agrave; zoom quang học cũng được cải thiện, gi&uacute;p bạn ghi lại mọi khoảnh khắc đ&aacute;ng nhớ.</p>

<h3><strong>Khả năng chống bụi, chống nước</strong></h3>

<p>&nbsp;</p>

<p><img alt="iphone-8-plus-256G-product-red" longdesc="https://fptshop.com.vn/dien-thoai/iphone-8-plus-256G-product-red" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/iphone-8-plus-256G-product-red/iphone-8-plus-256G-product-red4.jpg" title="iphone-8-plus-256G-product-red" /></p>

<p><br />
Nhờ ti&ecirc;u chuẩn chống bụi &ndash; chống nước IP67 m&agrave; Apple đ&atilde; t&iacute;ch hợp cho<strong>&nbsp;iPhone 8 Plus 256 GB PRODUCT RED</strong>, người d&ugrave;ng y&ecirc;n t&acirc;m nếu chẳng may phải nghe điện thoại dưới trời mưa hoặc v&ocirc; t&igrave;nh l&agrave;m rơi m&aacute;y xuống nước, cụ thể l&agrave; m&aacute;y sẽ c&oacute; khả năng chịu được nước trong 30 ph&uacute;t ở độ s&acirc;u từ 15 cm đến 1 m.</p>

<h3><strong>Thời lượng pin tốt</strong></h3>

<p>&nbsp;</p>

<p><img alt="iphone-8-plus-256G-product-red" longdesc="https://fptshop.com.vn/dien-thoai/iphone-8-plus-256G-product-red" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/iphone-8-plus-256G-product-red/iphone-8-plus-256G-product-red5.jpg" title="iphone-8-plus-256G-product-red" /></p>

<p><br />
<strong>Apple iPhone 8 Plus 256 GB PRODUCT RED&nbsp;</strong>sở hữu vi&ecirc;n pin 2675 mAh, kh&ocirc;ng qu&aacute; cao nhưng nhờ con chip A11 mới tiết kiệm điện v&agrave; hệ điều h&agrave;nh iOS quản l&yacute; điện năng hiệu quả, v&igrave; vậy dễ d&agrave;ng đ&aacute;p ứng một ng&agrave;y d&agrave;i l&agrave;m việc v&agrave; giải tr&iacute; ở cường độ cao. B&ecirc;n cạnh đ&oacute;, sản phẩm cũng được t&iacute;ch hợp hai c&ocirc;ng nghệ hiện đại l&agrave; sạc nhanh v&agrave; sạc kh&ocirc;ng d&acirc;y gi&uacute;p người d&ugrave;ng dễ d&agrave;ng sạc đầy pin cho m&aacute;y.</p>

<p><em>Lưu &yacute;: B&agrave;i viết v&agrave; h&igrave;nh ảnh chỉ c&oacute; t&iacute;nh chất tham khảo v&igrave; cấu h&igrave;nh v&agrave; đặc t&iacute;nh sản phẩm c&oacute; thể thay đổi theo thị trường v&agrave; từng phi&ecirc;n bản. Vui l&ograve;ng gọi tổng đ&agrave;i miễn ph&iacute; 18006601 hoặc đến cửa h&agrave;ng FPT Shop để nhận th&ocirc;ng tin ch&iacute;nh x&aacute;c nhất về sản phẩm.</em></p>

<p>Minhtri Bin</p>

<p><strong>Th&ocirc;ng số kỹ thuật của iPhone 8 Plus 256GB PRODUCT RED</strong></p>

<p style="text-align:center">&nbsp;</p>

<table border="1" cellpadding="1" cellspacing="1" style="width:500px">
	<tbody>
		<tr>
			<td>Độ ph&acirc;n giải m&agrave;n h&igrave;nh :</td>
			<td>1083 x 1920 pixels</td>
		</tr>
		<tr>
			<td>Camera trước :</td>
			<td>7 MP</td>
		</tr>
		<tr>
			<td>Camera sau :</td>
			<td>2 camera 12 MP</td>
		</tr>
		<tr>
			<td>Tốc độ CPU :</td>
			<td>2.1 GHz</td>
		</tr>
		<tr>
			<td>Số nh&acirc;n :</td>
			<td>2 nh&acirc;n Monsoon v&agrave; 4 nh&acirc;n Mistral</td>
		</tr>
		<tr>
			<td>Chipset :</td>
			<td>Apple A11 Bionic 6 nh&acirc;n</td>
		</tr>
		<tr>
			<td>RAM :</td>
			<td>3GB</td>
		</tr>
		<tr>
			<td>Chip đồ họa (GPU) :</td>
			<td>Apple GPU 3 nh&acirc;n</td>
		</tr>
		<tr>
			<td>ROM :</td>
			<td>256GB</td>
		</tr>
		<tr>
			<td>K&iacute;ch thước :</td>
			<td>D&agrave;i 158.4 mm - Ngang 78.1 mm - D&agrave;y 7.5 mm</td>
		</tr>
		<tr>
			<td>Hệ điều h&agrave;nh :</td>
			<td>iOS11</td>
		</tr>
		<tr>
			<td>Tốc độ CPU :</td>
			<td>2.1 GHz</td>
		</tr>
	</tbody>
</table>

<h2>&nbsp;</h2>
', CAST(28900000 AS Decimal(18, 0)), CAST(26900000 AS Decimal(18, 0)), 2, N'2560 x 1440 pixels', N'5.5                 ', N'8.0 MP', N'8.0 MP', N'	4 nhân 2.3GHz + 4 nhân 1.7GHz', N'8 Nhân', N'	Exynos 8895', N'4GB', N'64 GB', N'Android 8.0', N'Li-Ion', N'3000Mah', N'2 sim Dual SIM', N'Wi-Fi 802.11 a/b/g/n/ac', N'v5.0', N'A-GPS, GLONASS, BDS')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (14, N'iPhone X 64GBx', 1, CAST(N'2018-05-23 00:57:13.323' AS DateTime), N'Duong', CAST(N'2018-06-10 17:49:54.107' AS DateTime), N'Duong', 0, N'/ckfinder/userfiles/images/ip.jpg', NULL, 1, 0, NULL, N'iPhone X 64GB là chiếc smartphone đầu tiên được Apple ưu ái cho tấm nền màn hình OLED', N'<h3 style="text-align:center"><strong>Đ&aacute;nh gi&aacute; chi tiết iPhone X 64GB</strong></h3>

<p>Đ&atilde; l&acirc;u lắm rồi Apple mới ra mắt một sản phẩm với thiết kế đột ph&aacute; v&agrave; liều lĩnh. D&ugrave; vấp phải kh&aacute; nhiều &yacute; kiến tr&aacute;i chiều nhưng cũng kh&ocirc;ng thể phủ nhận độ hấp dẫn của chiếc iPhone thế hệ thứ 10 n&agrave;y. C&ocirc;ng nghệ bảo mật mới, loại bỏ n&uacute;t home truyền thống, camera với những t&iacute;nh năng độc quyền, tất cả đ&atilde; khiến người d&ugrave;ng đứng ngồi kh&ocirc;ng y&ecirc;n cho đến khi được tr&ecirc;n tay.</p>

<p>&nbsp;</p>

<h3><strong>iPhone X 64GB c&oacute; thiết kế lột x&aacute;c ho&agrave;n to&agrave;n</strong></h3>

<p>&nbsp;</p>

<p><img alt="iPhone X 64GB có thiết kế lột xác hoàn toàn" id="iPhone X 64GB có thiết kế lột xác hoàn toàn" longdesc="https://be.fptshop.com.vn/iphone-x-64gb" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/T10/iphone-x-64gb/iphone-x-64gb-1.jpg" title="iPhone X 64GB có thiết kế lột xác hoàn toàn" /></p>

<p>&nbsp;</p>

<p><strong><a href="https://fptshop.com.vn/dien-thoai/iphone-x" target="_blank">iPhone X 64GB</a>&nbsp;</strong>đ&atilde; lột x&aacute;c ho&agrave;n to&agrave;n với việc loại bỏ n&uacute;t Home truyền thống, m&agrave;n h&igrave;nh tr&agrave;n viền v&agrave; camera k&eacute;p ở ph&iacute;a sau đ&atilde; được đặt lại vị tr&iacute; theo chiều dọc. Khung viền từ th&eacute;p s&aacute;ng b&oacute;ng bền bỉ v&agrave; mặt lưng k&iacute;nh với c&aacute;c g&oacute;c bo tr&ograve;n dễ d&agrave;ng cầm nắm. C&oacute; thể n&oacute;i đ&acirc;y l&agrave; một thiết kế kh&aacute; đột ph&aacute; m&agrave; l&acirc;u lắm rồi Apple mới thể hiện lại. Người d&ugrave;ng cần phải tr&ecirc;n tay th&igrave; mới cảm nhận được hết n&eacute;t tinh tế v&agrave; sang trọng của sản phẩm.</p>

<p>&nbsp;</p>

<h3><strong>M&agrave;n h&igrave;nh của iPhone X 64GB hiển thị đẹp hơn</strong></h3>

<p>&nbsp;</p>

<p><img alt="iphone-x-64gb" longdesc="https://be.fptshop.com.vn/iphone-x-64gb" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/T10/iphone-x-64gb/iphone-x-64gb-3.jpg" title="iphone-x-64gb" /></p>

<p>&nbsp;</p>

<p><strong>iPhone X 64GB</strong>&nbsp;l&agrave; chiếc smartphone đầu ti&ecirc;n được Apple ưu &aacute;i cho tấm nền m&agrave;n h&igrave;nh OLED, k&iacute;ch thước 5.8 inch v&agrave; độ ph&acirc;n giải đạt chuẩn Super Retina HD, Điều n&agrave;y gi&uacute;p cho m&agrave;n h&igrave;nh c&oacute; m&agrave;u sắc sống động, g&oacute;c nh&igrave;n rộng hơn, cải thiện độ s&aacute;ng v&agrave; tốn &iacute;t điện năng hơn. B&ecirc;n cạnh đ&oacute;, c&ocirc;ng nghệ True Tone c&ograve;n gi&uacute;p m&agrave;u sắc trở n&ecirc;n cực k&igrave; trung thực.</p>

<p>&nbsp;</p>

<h3><strong>iPhone X 64GB được trang bị c&ocirc;ng nghệ bảo mật mới ho&agrave;n to&agrave;n</strong></h3>

<p>&nbsp;</p>

<p><img alt="iPhone X 64GB được trang bị công nghệ bảo mật mới hoàn toàn" id="iPhone X 64GB được trang bị công nghệ bảo mật mới hoàn toàn" longdesc="https://be.fptshop.com.vn/iphone-x-64gb" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/T10/iphone-x-64gb/iphone-x-64gb-4.jpg" title="iPhone X 64GB được trang bị công nghệ bảo mật mới hoàn toàn" /></p>

<p>&nbsp;</p>

<p>Với thiết kế loại bỏ n&uacute;t Home truyền thống vốn được xem l&agrave; biểu tượng của Apple, c&ocirc;ng nghệ bảo mật mới &ndash; Face ID lần đầu ti&ecirc;n xuất hiện tr&ecirc;n một chiếc iPhone với hiệu quả cao gấp 20 lần so với Touch ID, c&oacute; khả năng nhận diện khu&ocirc;n mặt cực k&igrave; chuẩn x&aacute;c d&ugrave; bạn cao đi r&acirc;u, để t&oacute;c d&agrave;i, th&acirc;n h&igrave;nh mập ra,&hellip; Face ID vẫn dễ d&agrave;ng nhận ra bạn.</p>

<h3><br />
<strong>Camera ấn tượng với t&iacute;nh năng độc quyền</strong></h3>

<p>&nbsp;</p>

<p><img alt="Camera ấn tượng với tính năng độc quyền" id="Camera ấn tượng với tính năng độc quyền" longdesc="https://be.fptshop.com.vn/iphone-x-64gb" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/T10/iphone-x-64gb/iphone-x-64gb-2.jpg" title="Camera ấn tượng với tính năng độc quyền" /></p>

<p>&nbsp;</p>

<p><strong>iPhone X 64GB</strong>&nbsp;c&oacute; 3 t&iacute;nh năng độc quyền cho camera trước l&agrave; Portrait Mode Selfie (x&oacute;a ph&ocirc;ng), Portrait Lighting (&aacute;nh s&aacute;ng ch&acirc;n dung), Animoji (biểu tượng cảm x&uacute;c) c&oacute; thể bắt chước điệu bộ khu&ocirc;n mặt v&agrave; giọng n&oacute;i người d&ugrave;ng. Kh&aacute;c biệt lớn nhất của iPhone X l&agrave; chức năng chống rung (OIS) cho cả ống k&iacute;nh g&oacute;c rộng v&agrave; tele ở camera sau, đồng nghĩa<strong>&nbsp;iPhone X</strong>&nbsp;c&oacute; thể chụp ảnh sắc n&eacute;t hơn trong mọi trường hợp.</p>

<h3>&nbsp;</h3>

<h3><strong>Tăng tốc độ phần cứng của iPhone X 64GB</strong></h3>

<p>&nbsp;</p>

<p><img alt="Tăng tốc độ phần cứng của iPhone X 64GB" id="Tăng tốc độ phần cứng của iPhone X 64GB" longdesc="https://be.fptshop.com.vn/iphone-x-64gb" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/T10/iphone-x-64gb/iphone-x-64gb-5.jpg" title="Tăng tốc độ phần cứng của iPhone X 64GB" /></p>

<p>&nbsp;</p>

<p><strong>iPhone X 64GB&nbsp;</strong>được cung cấp sức mạnh bởi chip xử l&yacute; A11 Bionic s&aacute;u l&otilde;i (Hexa core) 64 bit, gồm 2 l&otilde;i hiệu suất cao v&agrave; 4 l&otilde;i hiệu suất thấp hơn. Ước t&iacute;nh, tốc độ của 2 l&otilde;i hiệu suất cao c&oacute; tốc độ nhanh hơn 25% so với chip A10 cũ, gi&uacute;p tiết kiệm năng lượng l&ecirc;n tới 70%. Ngo&agrave;i ra, chip xử l&yacute; đồ họa GPU M11 cũng gi&uacute;p cải thiện tốc độ l&ecirc;n khoảng 30% so với GPU năm ngo&aacute;i. Nhờ sự kết hợp n&agrave;y, người d&ugrave;ng sẽ c&oacute; cơ hội lướt game nhanh v&agrave; &ldquo;mượt&rdquo; hơn.</p>

<p>&nbsp;</p>

<h3><strong>Pin của iPhone X 64GB bền bỉ, hỗ trợ sạc kh&ocirc;ng d&acirc;y</strong></h3>

<p>&nbsp;</p>

<p><img alt="Pin của iPhone X 64GB bền bỉ, hỗ trợ sạc không dây" id="Pin của iPhone X 64GB bền bỉ, hỗ trợ sạc không dây" longdesc="https://be.fptshop.com.vn/iphone-x-64gb" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/T10/iphone-x-64gb/iphone-x-64gb-6.jpg" title="Pin của iPhone X 64GB bền bỉ, hỗ trợ sạc không dây" /></p>

<p>&nbsp;</p>

<p>Theo c&ocirc;ng bố, thời lượng pin của iPhone X sẽ l&acirc;u hơn iPhone 7 khoảng 2 giờ đồng hồ. Hai t&iacute;nh năng th&uacute; vị kh&aacute;c cũng được đưa l&ecirc;n sản phẩm: sạc nhanh (sạc pin 50% chỉ trong 30 ph&uacute;t) v&agrave; sạc kh&ocirc;ng d&acirc;y Qi. Với tấm sạc Air Power của h&atilde;ng, bạn c&oacute; thể sạc c&ugrave;ng l&uacute;c iPhone X, đồng hồ Apple Watch v&agrave; tai nghe kh&ocirc;ng d&acirc;y Air Pods.</p>

<p>&nbsp;</p>

<p><em>Lưu &yacute;: B&agrave;i viết v&agrave; h&igrave;nh ảnh chỉ c&oacute; t&iacute;nh chất tham khảo v&igrave; cấu h&igrave;nh v&agrave; đặc t&iacute;nh sản phẩm c&oacute; thể thay đổi theo thị trường v&agrave; từng phi&ecirc;n bản. Vui l&ograve;ng gọi tổng&nbsp;</em></p>
', CAST(29000000 AS Decimal(18, 0)), NULL, 12, N'2560 x 1440 pixels', N'5.5                 ', N'8.0 MP', N'8.0 MP', N'	4 nhân 2.3GHz + 4 nhân 1.7GHz', N'8 Nhân', N'	Exynos 8895', N'64 GB', N'64 GB', N'Android 8.0', N'Li-Ion', N'3000Mah', N'2 sim Dual SIM', N'Wi-Fi 802.11 a/b/g/n/ac', N'v5.0', N'A-GPS, GLONASS, BDS')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (15, N'234', 1, CAST(N'2018-05-24 17:19:37.173' AS DateTime), N'Duong', NULL, NULL, 0, NULL, NULL, 1, 0, NULL, N'23', NULL, CAST(324 AS Decimal(18, 0)), NULL, 423, N'2560 x 1440 pixels', N'5.5                 ', N'8.0 MP', N'8.0 MP', N'	4 nhân 2.3GHz + 4 nhân 1.7GHz', N'8 Nhân', N'	Exynos 8895', N'4GB', N'64 GB', N'Android 8.0', N'Li-Ion', N'3000Mah', N'2 sim Dual SIM', N'Wi-Fi 802.11 a/b/g/n/ac', N'v5.0', N'A-GPS, GLONASS, BDS')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (16, N'SAmSung S9', 1, CAST(N'2018-06-09 23:35:55.747' AS DateTime), N'Duong', CAST(N'2018-06-10 17:01:29.087' AS DateTime), N'Duong', 1, N'/ckfinder/userfiles/images/636552333148760332_1.jpg', NULL, 1, 0, NULL, N'khong mo ta', N'<h3>Đ&aacute;nh gi&aacute; chi tiết Samsung Galaxy S8 Plus</h3>

<p><a href="https://fptshop.com.vn/dien-thoai/samsung-galaxy-s8-plus" target="_blank">Samsung S8 Plus</a>&nbsp;ra mắt đ&atilde; l&agrave;m h&agrave;i l&ograve;ng giới c&ocirc;ng nghệ lẫn người ti&ecirc;u d&ugrave;ng h&acirc;m mộ h&atilde;ng điện thoại danh tiếng đến từ H&agrave;n Quốc &ndash; Samsung. Thiết kế c&oacute; thể chưa được xem l&agrave; đột ph&aacute; ho&agrave;n to&agrave;n nhưng ngay từ c&aacute;i nh&igrave;n đầu ti&ecirc;n đ&atilde; mang lại cảm x&uacute;c th&aacute;n phục bởi sự sắc sảo, tinh tế đến từ chi tiết v&agrave; một m&agrave;n h&igrave;nh cong tr&agrave;n cạnh &ldquo;kh&ocirc;ng viền&rdquo; đ&aacute;ng ngạc nhi&ecirc;n. K&egrave;m theo l&agrave; nhiều t&iacute;nh năng đặc biệt th&uacute; vị nhằm n&acirc;ng cao trải nghiệm cho người d&ugrave;ng. S8 Plus hứa hẹn sẽ mang lại sự th&agrave;nh c&ocirc;ng mới cho Samsung trong năm nay.</p>

<h3>&nbsp;</h3>

<h3><strong>Thiết kế nổi bật v&agrave; sang trọng</strong></h3>

<p>&nbsp;</p>

<p><img alt="samsung-galaxy-s8-plus" longdesc="https://fptshop.com.vn/dien-thoai/samsung-galaxy-s8-plus" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/samsung-galaxy-s8-plus/samsung-galaxy-s8-plus-1.JPG" title="samsung-galaxy-s8-plus" /></p>

<p>&nbsp;</p>

<p>Trong khi thiết kế c&aacute;c d&ograve;ng smartphone hiện nay đa số đi theo lối m&ograve;n quen thuộc th&igrave; Galaxy S8 Plus vẫn tự tin kho&aacute;c l&ecirc;n m&igrave;nh một vẻ đẹp kh&oacute; cưỡng lại. Đ&oacute; l&agrave; sự tổng hợp của k&iacute;nh, kim loại v&agrave; một m&agrave;n h&igrave;nh lớn với viền &ldquo;v&ocirc; cực&rdquo;.</p>

<p>&nbsp;</p>

<p><img alt="samsung-galaxy-s8-plus" longdesc="https://fptshop.com.vn/dien-thoai/samsung-galaxy-s8-plus" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/samsung-galaxy-s8-plus/samsung-galaxy-s8-plus-3.JPG" title="samsung-galaxy-s8-plus" /></p>

<p>&nbsp;</p>

<p>Sự ho&agrave;n thiện cũng như tỉ mỉ đ&atilde; được Samsung thực hiện kh&aacute; ho&agrave;n hảo. Ở mặt trước, n&uacute;t Home vật l&yacute; đ&atilde; thay thế bằng n&uacute;t Home cảm ứng lực tr&ecirc;n m&agrave;n h&igrave;nh, c&ograve;n cảm biến v&acirc;n tay th&igrave; được chuyển sang mặt lưng m&aacute;y. Thiết kế n&agrave;y gi&uacute;p cho mặt trước sản phẩm phẳng v&agrave; gần như kh&ocirc;ng c&oacute; g&igrave; ngo&agrave;i m&agrave;n h&igrave;nh.</p>

<p>&nbsp;</p>

<h3><strong>M&agrave;n h&igrave;nh lớn với viền &ldquo;v&ocirc; cực&rdquo;</strong></h3>

<p>&nbsp;</p>

<p><img alt="samsung-galaxy-s8-plus" longdesc="https://fptshop.com.vn/dien-thoai/samsung-galaxy-s8-plus" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/samsung-galaxy-s8-plus/samsung-galaxy-s8-plus-2.JPG" title="samsung-galaxy-s8-plus" /></p>

<p>&nbsp;</p>

<p>M&agrave;n h&igrave;nh với k&iacute;ch thước 6.2 inch Super AMOLED độ ph&acirc;n giải QHD+ (1440 x 2960 pixel) th&igrave; c&oacute; thể kh&ocirc;ng cần b&agrave;n c&atilde;i về chất lượng hiển thị tr&ecirc;n Samsung S8 Plus nữa. Chắc chắn người d&ugrave;ng sẽ c&oacute; những h&igrave;nh ảnh, thước phim r&otilde; n&eacute;t v&agrave; lung linh nhất c&oacute; thể trong mọi điều kiện &aacute;nh s&aacute;ng. Điểm độc đ&aacute;o ch&iacute;nh l&agrave; thiết kế cong tr&agrave;n cạnh hai b&ecirc;n v&agrave; tối đa cho cả cạnh tr&ecirc;n, dưới khiến bạn sẽ nghĩ tr&ecirc;n tay đang cầm một tấm gương. Mặc d&ugrave; vậy th&igrave; tỷ lệ m&agrave;n h&igrave;nh được cho l&agrave; kh&aacute; thu&ocirc;n d&agrave;i, c&oacute; thể sẽ c&oacute; thao t&aacute;c bằng một tay.</p>
', CAST(200000 AS Decimal(18, 0)), CAST(180000 AS Decimal(18, 0)), 6, N'2560 x 1440 pixels', N'5.5                 ', N'8.0 MP', N'8.0 MP', N'	4 nhân 2.3GHz + 4 nhân 1.7GHz', N'8 Nhân', N'	Exynos 8895', N'4GB', N'64 GB', N'Android 8.0', N'Li-Ion', N'3000Mah', N'2 sim Dual SIM', N'Wi-Fi 802.11 a/b/g/n/ac', N'v5.0', N'A-GPS, GLONASS, BDS')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (17, N'sdasdsadsadsadsa', 1, CAST(N'2018-06-09 23:39:38.807' AS DateTime), N'Duong', NULL, NULL, 0, N'/ckfinder/userfiles/images/2014-06-01_ObservatoryFabra_ROW11976730323_1920x1080.jpg', NULL, 1, 0, NULL, N'dá', NULL, NULL, NULL, NULL, N'2560 x 1440 pixels', N'5.5                 ', N'8.0 MP', N'8.0 MP', N'	4 nhân 2.3GHz + 4 nhân 1.7GHz', N'8 Nhân', N'	Exynos 8895', N'4GB', N'64 GB', N'Android 8.0', N'Li-Ion', N'3000Mah', N'2 sim Dual SIM', N'Wi-Fi 802.11 a/b/g/n/ac', N'v5.0', N'A-GPS, GLONASS, BDS')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (18, N'đá', 1, CAST(N'2018-06-09 23:44:44.400' AS DateTime), N'Duong', NULL, NULL, 0, N'/ckfinder/userfiles/images/2014-06-01_UndergroundDischarge_JA-JP10666149791_1920x1080.jpg', NULL, 1, 0, NULL, N'fas', NULL, NULL, NULL, NULL, N'2560 x 1440 pixels', N'5.5                 ', N'8.0 MP', N'8.0 MP', N'	4 nhân 2.3GHz + 4 nhân 1.7GHz', N'8 Nhân', N'	Exynos 8895', N'4GB', N'64 GB', N'Android 8.0', N'Li-Ion', N'3000Mah', N'2 sim Dual SIM', N'Wi-Fi 802.11 a/b/g/n/ac', N'v5.0', N'A-GPS, GLONASS, BDS')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (19, N'dá', 1, CAST(N'2018-06-09 23:47:26.893' AS DateTime), N'Duong', NULL, NULL, 0, N'/ckfinder/userfiles/images/2014-06-01_ObservatoryFabra_ROW11976730323_1920x1080.jpg', NULL, 1, 0, NULL, N'da', NULL, CAST(200000 AS Decimal(18, 0)), NULL, NULL, N'2560 x 1440 pixels', N'5.5                 ', N'8.0 MP', N'8.0 MP', N'	4 nhân 2.3GHz + 4 nhân 1.7GHz', N'8 Nhân', N'	Exynos 8895', N'4GB', N'64 GB', N'Android 8.0', N'Li-Ion', N'3000Mah', N'2 sim Dual SIM', N'Wi-Fi 802.11 a/b/g/n/ac', N'v5.0', N'A-GPS, GLONASS, BDS')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (20, N'sdasdsadsadsadsa', 1, CAST(N'2018-06-09 23:47:50.630' AS DateTime), N'Duong', NULL, NULL, 0, N'/ckfinder/userfiles/images/2014-06-01_ObservatoryFabra_ROW11976730323_1920x1080.jpg', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, N'2560 x 1440 pixels', N'5.5                 ', N'8.0 MP', N'8.0 MP', N'	4 nhân 2.3GHz + 4 nhân 1.7GHz', N'8 Nhân', N'	Exynos 8895', N'4GB', N'64 GB', N'Android 8.0', N'Li-Ion', N'3000Mah', N'2 sim Dual SIM', N'Wi-Fi 802.11 a/b/g/n/ac', N'v5.0', N'A-GPS, GLONASS, BDS')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (21, N'dsa', 1, CAST(N'2018-06-09 23:49:07.473' AS DateTime), N'Duong', NULL, NULL, 0, N'/ckfinder/userfiles/images/2014-06-01_UndergroundDischarge_JA-JP10666149791_1920x1080.jpg', NULL, 1, 0, NULL, N'dá', NULL, CAST(200000 AS Decimal(18, 0)), NULL, NULL, N'2560 x 1440 pixels', N'5.5                 ', N'8.0 MP', N'8.0 MP', N'	4 nhân 2.3GHz + 4 nhân 1.7GHz', N'8 Nhân', N'	Exynos 8895', N'4GB', N'64 GB', N'Android 8.0', N'Li-Ion', N'3000Mah', N'2 sim Dual SIM', N'Wi-Fi 802.11 a/b/g/n/ac', N'v5.0', N'A-GPS, GLONASS, BDS')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (22, N'dsa', 1, CAST(N'2018-06-09 23:50:02.270' AS DateTime), N'Duong', NULL, NULL, 0, N'/ckfinder/userfiles/images/2014-06-01_UndergroundDischarge_JA-JP10666149791_1920x1080.jpg', NULL, 1, 0, NULL, N'dá', NULL, CAST(200000 AS Decimal(18, 0)), NULL, NULL, N'2560 x 1440 pixels', N'5.5                 ', N'8.0 MP', N'8.0 MP', N'	4 nhân 2.3GHz + 4 nhân 1.7GHz', N'8 Nhân', N'	Exynos 8895', N'4GB', N'64 GB', N'Android 8.0', N'Li-Ion', N'3000Mah', N'2 sim Dual SIM', N'Wi-Fi 802.11 a/b/g/n/ac', N'v5.0', N'A-GPS, GLONASS, BDS')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (23, N'sda', 1, CAST(N'2018-06-09 23:50:41.407' AS DateTime), N'Duong', NULL, NULL, 0, N'/ckfinder/userfiles/images/2014-06-01_UndergroundDischarge_JA-JP10666149791_1920x1080.jpg', NULL, 1, 0, NULL, N'dá', N'<p>&nbsp; &nbsp; &nbsp; &nbsp; &lt;div class=&quot;form-group&quot;&gt;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; @Html.LabelFor(model =&gt; model.NoiDung, htmlAttributes: new { @class = &quot;control-label col-md-2&quot; })<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;div class=&quot;col-md-10&quot;&gt;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; @Html.TextAreaFor(model =&gt; model.NoiDung, new { htmlAttributes = new { @class = &quot;form-control&quot; }, id = &quot;txtContent&quot; })<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; @Html.ValidationMessageFor(model =&gt; model.NoiDung, &quot;&quot;, new { @class = &quot;text-danger&quot; })<br />
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;/div&gt;<br />
&nbsp; &nbsp; &nbsp; &nbsp; &lt;/div&gt;</p>
', NULL, NULL, NULL, N'2560 x 1440 pixels', N'5.5                 ', N'8.0 MP', N'8.0 MP', N'	4 nhân 2.3GHz + 4 nhân 1.7GHz', N'8 Nhân', N'	Exynos 8895', N'4GB', N'64 GB', N'Android 8.0', N'Li-Ion', N'3000Mah', N'2 sim Dual SIM', N'Wi-Fi 802.11 a/b/g/n/ac', N'v5.0', N'A-GPS, GLONASS, BDS')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (24, N'sdasdsadsadsadsa', 1, CAST(N'2018-06-09 23:51:16.523' AS DateTime), N'Duong', NULL, NULL, 0, N'/ckfinder/userfiles/images/2014-06-01_UndergroundDischarge_JA-JP10666149791_1920x1080.jpg', NULL, 1, 0, NULL, N'da', N'<h3>Đ&aacute;nh gi&aacute; chi tiết Samsung Galaxy S8 Plus</h3>

<p><a href="https://fptshop.com.vn/dien-thoai/samsung-galaxy-s8-plus" target="_blank">Samsung S8 Plus</a>&nbsp;ra mắt đ&atilde; l&agrave;m h&agrave;i l&ograve;ng giới c&ocirc;ng nghệ lẫn người ti&ecirc;u d&ugrave;ng h&acirc;m mộ h&atilde;ng điện thoại danh tiếng đến từ H&agrave;n Quốc &ndash; Samsung. Thiết kế c&oacute; thể chưa được xem l&agrave; đột ph&aacute; ho&agrave;n to&agrave;n nhưng ngay từ c&aacute;i nh&igrave;n đầu ti&ecirc;n đ&atilde; mang lại cảm x&uacute;c th&aacute;n phục bởi sự sắc sảo, tinh tế đến từ chi tiết v&agrave; một m&agrave;n h&igrave;nh cong tr&agrave;n cạnh &ldquo;kh&ocirc;ng viền&rdquo; đ&aacute;ng ngạc nhi&ecirc;n. K&egrave;m theo l&agrave; nhiều t&iacute;nh năng đặc biệt th&uacute; vị nhằm n&acirc;ng cao trải nghiệm cho người d&ugrave;ng. S8 Plus hứa hẹn sẽ mang lại sự th&agrave;nh c&ocirc;ng mới cho Samsung trong năm nay.</p>

<h3>&nbsp;</h3>

<h3><strong>Thiết kế nổi bật v&agrave; sang trọng</strong></h3>

<p>&nbsp;</p>

<p><img alt="samsung-galaxy-s8-plus" longdesc="https://fptshop.com.vn/dien-thoai/samsung-galaxy-s8-plus" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/samsung-galaxy-s8-plus/samsung-galaxy-s8-plus-1.JPG" title="samsung-galaxy-s8-plus" /></p>

<p>&nbsp;</p>

<p>Trong khi thiết kế c&aacute;c d&ograve;ng smartphone hiện nay đa số đi theo lối m&ograve;n quen thuộc th&igrave; Galaxy S8 Plus vẫn tự tin kho&aacute;c l&ecirc;n m&igrave;nh một vẻ đẹp kh&oacute; cưỡng lại. Đ&oacute; l&agrave; sự tổng hợp của k&iacute;nh, kim loại v&agrave; một m&agrave;n h&igrave;nh lớn với viền &ldquo;v&ocirc; cực&rdquo;.</p>

<p>&nbsp;</p>

<p><img alt="samsung-galaxy-s8-plus" longdesc="https://fptshop.com.vn/dien-thoai/samsung-galaxy-s8-plus" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/samsung-galaxy-s8-plus/samsung-galaxy-s8-plus-3.JPG" title="samsung-galaxy-s8-plus" /></p>

<p>&nbsp;</p>

<p>Sự ho&agrave;n thiện cũng như tỉ mỉ đ&atilde; được Samsung thực hiện kh&aacute; ho&agrave;n hảo. Ở mặt trước, n&uacute;t Home vật l&yacute; đ&atilde; thay thế bằng n&uacute;t Home cảm ứng lực tr&ecirc;n m&agrave;n h&igrave;nh, c&ograve;n cảm biến v&acirc;n tay th&igrave; được chuyển sang mặt lưng m&aacute;y. Thiết kế n&agrave;y gi&uacute;p cho mặt trước sản phẩm phẳng v&agrave; gần như kh&ocirc;ng c&oacute; g&igrave; ngo&agrave;i m&agrave;n h&igrave;nh.</p>

<p>&nbsp;</p>

<h3><strong>M&agrave;n h&igrave;nh lớn với viền &ldquo;v&ocirc; cực&rdquo;</strong></h3>

<p>&nbsp;</p>

<p><img alt="samsung-galaxy-s8-plus" longdesc="https://fptshop.com.vn/dien-thoai/samsung-galaxy-s8-plus" src="https://fptshop.com.vn/Uploads/images/2015/SANPHAM/MinhtriBin/samsung-galaxy-s8-plus/samsung-galaxy-s8-plus-2.JPG" title="samsung-galaxy-s8-plus" /></p>

<p>&nbsp;</p>

<p>M&agrave;n h&igrave;nh với k&iacute;ch thước 6.2 inch Super AMOLED độ ph&acirc;n giải QHD+ (1440 x 2960 pixel) th&igrave; c&oacute; thể kh&ocirc;ng cần b&agrave;n c&atilde;i về chất lượng hiển thị tr&ecirc;n Samsung S8 Plus nữa. Chắc chắn người d&ugrave;ng sẽ c&oacute; những h&igrave;nh ảnh, thước phim r&otilde; n&eacute;t v&agrave; lung linh nhất c&oacute; thể trong mọi điều kiện &aacute;nh s&aacute;ng. Điểm độc đ&aacute;o ch&iacute;nh l&agrave; thiết kế cong tr&agrave;n cạnh hai b&ecirc;n v&agrave; tối đa cho cả cạnh tr&ecirc;n, dưới khiến bạn sẽ nghĩ tr&ecirc;n tay đang cầm một tấm gương. Mặc d&ugrave; vậy th&igrave; tỷ lệ m&agrave;n h&igrave;nh được cho l&agrave; kh&aacute; thu&ocirc;n d&agrave;i, c&oacute; thể sẽ c&oacute; thao t&aacute;c bằng một tay.</p>
', NULL, NULL, NULL, N'2560 x 1440 pixels', N'5.5                 ', N'8.0 MP', N'8.0 MP', N'	4 nhân 2.3GHz + 4 nhân 1.7GHz', N'8 Nhân', N'	Exynos 8895', N'4GB', N'64 GB', N'Android 8.0', N'Li-Ion', N'3000Mah', N'2 sim Dual SIM', N'Wi-Fi 802.11 a/b/g/n/ac', N'v5.0', N'A-GPS, GLONASS, BDS')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (25, N'Tai nghe có mic Earmac EM-770', 15, CAST(N'2018-02-10 17:31:36.880' AS DateTime), N'Duong', NULL, NULL, 1, N'/ckfinder/userfiles/images/636077217867300496_TAI-NGHE-EARMAC-EM-770-5.jpg', NULL, 0, 0, NULL, N'Tai nghe có mic Earmac EM-770', N'<h3>Th&ocirc;ng số cơ bản</h3>

<ul>
	<li>
	<p>Chế độ bảo h&agrave;nh :12 th&aacute;ng</p>
	</li>
	<li>
	<p>M&agrave;u sắc :Đen</p>
	</li>
	<li>
	<p>Độ d&agrave;i d&acirc;y :1,2m</p>
	</li>
	<li>
	<p>D&ograve;ng m&aacute;y tương th&iacute;ch :Tất cả m&aacute;y t&iacute;nh để b&agrave;n, laptop v&agrave; điện thoại c&oacute; cổng cắm &acirc;m thanh 3.5mm</p>
	</li>
	<li>
	<p>T&iacute;nh năng :Nghe nhạc, nhỏ gọn, th&iacute;ch hợp di chuyển</p>
	</li>
	<li>
	<p>Thương hiệu :Earmac</p>
	</li>
	<li>
	<p><img alt="" src="https://fptshop.com.vn/Uploads/Originals/2015/1/2/201501021629544421_tai-nghe-co-mic-earmac-em-770.jpg" title="" /></p>

	<h3>tai-nghe-co-mic-earmac-em-770</h3>

	<p>&nbsp;</p>

	<p>Tai nghe c&oacute; mic Earmac EM-770 l&agrave; thiết bị hiện đại với thiết kế nhỏ gọn</p>

	<p>&nbsp;</p>
	</li>
</ul>
', CAST(500000 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (26, N's', 12, CAST(N'2018-06-23 00:01:26.600' AS DateTime), N'', CAST(N'2018-06-23 00:01:26.600' AS DateTime), N'', 0, N'', N'', 1, 0, NULL, N's', N'xxx', CAST(1 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), 1, N's', N's                   ', N's', N's', N's', N's', N's', N's', N's', N's', N's', N's', N's', N's', N's', N's')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (27, N's', 12, CAST(N'2018-06-23 00:04:44.817' AS DateTime), N'', CAST(N'2018-06-23 00:04:44.817' AS DateTime), N'', 0, N'', N'', 1, 0, NULL, N's', N'xxx', CAST(1 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), 1, N's', N's                   ', N's', N's', N's', N's', N's', N's', N's', N's', N's', N's', N's', N's', N's', N's')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (28, N's', 12, CAST(N'2018-06-23 00:09:12.830' AS DateTime), N'', CAST(N'2018-06-23 00:09:12.830' AS DateTime), N'', 0, N'', N'', 1, 0, NULL, N's', N'xxx', CAST(1 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), 1, N's', N's                   ', N's', N's', N's', N's', N's', N's', N's', N's', N's', N's', N's', N's', N's', N's')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (29, N'213', 12, CAST(N'2018-06-23 00:12:10.253' AS DateTime), N'', CAST(N'2018-06-23 00:12:10.253' AS DateTime), N'', 0, N'', N'', 1, 0, NULL, N'23', N'xxx', CAST(1 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), 1, N's', N's                   ', N's', N's', N's', N's', N's', N's', N's', N's', N's', N's', N's', N's', N's', N's')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (30, N'ds', 12, CAST(N'2018-06-23 00:15:16.680' AS DateTime), N'', CAST(N'2018-06-23 00:15:16.680' AS DateTime), N'', 0, N'', N'', 1, 0, NULL, N'sda', N'', CAST(231 AS Decimal(18, 0)), CAST(312 AS Decimal(18, 0)), 31, N'dsa', N'da                  ', N'sd', N'a', N'sda', N'sda', N's', N'dsa', N'das', N'das', N'das', N'dsa', N'dsa', N'das', N'das', N'das')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (31, N'1', 12, CAST(N'2018-06-23 00:47:36.537' AS DateTime), N'', CAST(N'2018-06-23 00:47:36.537' AS DateTime), N'', 0, N'', N'', 1, 0, NULL, N'4', N'<p>gdhgccnbcnb</p>
', CAST(45334 AS Decimal(18, 0)), CAST(5651320 AS Decimal(18, 0)), 1, N'w', N'e                   ', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (32, N'1', 12, CAST(N'2018-06-23 00:48:43.527' AS DateTime), N'', CAST(N'2018-06-23 00:48:43.527' AS DateTime), N'', 0, N'', N'', 1, 0, NULL, N'4', N'<p>gdhgccnbcnb</p>
', CAST(45334 AS Decimal(18, 0)), CAST(5651320 AS Decimal(18, 0)), 1, N'w', N'e                   ', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (33, N'1', 12, CAST(N'2018-06-23 00:49:24.980' AS DateTime), N'', CAST(N'2018-06-23 00:49:24.980' AS DateTime), N'', 0, N'', N'', 1, 0, NULL, N'4', N'<p>gdhgccnbcnb</p>
', CAST(45334 AS Decimal(18, 0)), CAST(5651320 AS Decimal(18, 0)), 1, N'w', N'e                   ', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (34, N'1', 12, CAST(N'2018-06-23 00:50:17.067' AS DateTime), N'', CAST(N'2018-06-23 00:50:17.067' AS DateTime), N'', 0, N'/ckfinder/userfiles/images/2017-10-12_190257.png', N'', 1, 0, NULL, N'4', N'<p>gdhgccnbcnb</p>
', CAST(45334 AS Decimal(18, 0)), CAST(5651320 AS Decimal(18, 0)), 1, N'w', N'e                   ', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w')
INSERT [dbo].[SanPham] ([ID], [TenSanPham], [DanhMucID], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [image], [GhiChu], [SPHOT], [ViewCount], [MoreImage], [MoTa], [NoiDung], [Gia], [GiaKhuyenMai], [BaoHanh], [DoPhanGiai], [ManHinh], [CamTruoc], [CamSau], [CPU], [SoNhan], [Chip], [Ram], [ROM], [HeDieuHanh], [Pin], [DungluongPin], [Sim], [wifi], [Bluetooth], [GPS]) VALUES (35, N'1', 12, CAST(N'2018-06-23 00:50:35.217' AS DateTime), N'', CAST(N'2018-06-23 00:50:35.217' AS DateTime), N'', 0, N'/ckfinder/userfiles/images/2017-10-12_190257.png', N'', 1, 0, NULL, N'4', N'<p>gdhgccnbcnb</p>
', CAST(45334 AS Decimal(18, 0)), CAST(5651320 AS Decimal(18, 0)), 1, N'w', N'e                   ', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w', N'w')
SET IDENTITY_INSERT [dbo].[SanPham] OFF
SET IDENTITY_INSERT [dbo].[Slide] ON 

INSERT [dbo].[Slide] ([ID], [Name], [Image], [url], [STT], [Trangthai], [NoiDung], [btn]) VALUES (1, N'sadf', N'/ckfinder/userfiles/images/slide.png', N'http://localhost:31432/SanPham/SanPham/4', 1, 1, N'<p><span style="color:#FFFF00"><strong>Từ 1/1/2019 - 21/3/2020</strong></span></p>

<h1><span style="color:#FFFF00"><strong>Iphone X Free</strong></span></h1>
', N'Mua ngay')
INSERT [dbo].[Slide] ([ID], [Name], [Image], [url], [STT], [Trangthai], [NoiDung], [btn]) VALUES (2, NULL, N'/ckfinder/userfiles/images/16_05_2018_16_02_00_Huawei-P20-Pro-800-300-1.png', NULL, 2, 0, N'<h2><span style="color:#FFFFFF"><span style="font-size:12px"><span style="font-family:arial,helvetica,sans-serif">Giảm gi&aacute; c&aacute;c mặt h&agrave;ng nh&acirc;n dip 1-6</span></span></span></h2>

<p><span style="color:#FFFFFF"><span style="font-family:arial,helvetica,sans-serif">Giảm 100%</span></span></p>
', N'Click')
INSERT [dbo].[Slide] ([ID], [Name], [Image], [url], [STT], [Trangthai], [NoiDung], [btn]) VALUES (3, NULL, N'/ckfinder/userfiles/images/16_05_2018_16_02_00_Huawei-P20-Pro-800-300-1.png', NULL, 3, 0, NULL, NULL)
INSERT [dbo].[Slide] ([ID], [Name], [Image], [url], [STT], [Trangthai], [NoiDung], [btn]) VALUES (4, N'Khong name', N'/ckfinder/userfiles/images/09_06_2018_09_05_11_oppo-800-300.png', N'http://localhost:31432/SanPham/CtSanPham/11', 3, 1, NULL, N'Mua ngay')
INSERT [dbo].[Slide] ([ID], [Name], [Image], [url], [STT], [Trangthai], [NoiDung], [btn]) VALUES (5, N'Iphone', N'/ckfinder/userfiles/images/07_06_2018_10_00_32_Hotsale-j6_800-300.png', N'#', 2, 1, NULL, N'Xem ngay')
INSERT [dbo].[Slide] ([ID], [Name], [Image], [url], [STT], [Trangthai], [NoiDung], [btn]) VALUES (6, NULL, NULL, NULL, NULL, 0, NULL, NULL)
INSERT [dbo].[Slide] ([ID], [Name], [Image], [url], [STT], [Trangthai], [NoiDung], [btn]) VALUES (7, NULL, NULL, NULL, NULL, 0, NULL, NULL)
INSERT [dbo].[Slide] ([ID], [Name], [Image], [url], [STT], [Trangthai], [NoiDung], [btn]) VALUES (8, NULL, NULL, NULL, NULL, 0, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Slide] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([ID], [Pass], [Name], [Address], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [GroupID], [SDT], [Email], [HoTen]) VALUES (1, N'827ccb0eea8a706c4c34a16891f84e7b', N'Duong', N'Nam Dinh', CAST(N'2019-02-02 00:00:00.000' AS DateTime), N'2019-2-2', CAST(N'2018-05-19 02:12:54.793' AS DateTime), NULL, 0, 1, NULL, N'mail', N'Đỗ Văn Dương')
INSERT [dbo].[User] ([ID], [Pass], [Name], [Address], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [GroupID], [SDT], [Email], [HoTen]) VALUES (2, N'15de21c670ae7c3f6f3f1f37029303c9', N'ngoctrinh', N'mmmmn', NULL, NULL, CAST(N'2018-05-19 02:09:36.007' AS DateTime), NULL, 0, 1, N'21312', N'bbb', N'Ngọc Trinh')
INSERT [dbo].[User] ([ID], [Pass], [Name], [Address], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [GroupID], [SDT], [Email], [HoTen]) VALUES (3, N'8542516f8870173d7d1daba1daaaf0a1', N'Kiều Anh Hera', N'132', NULL, NULL, NULL, NULL, 0, 1, N'02121', N'123', NULL)
INSERT [dbo].[User] ([ID], [Pass], [Name], [Address], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [GroupID], [SDT], [Email], [HoTen]) VALUES (4, N'b3ddbc502e307665f346cbd6e52cc10d', N'Ngộ Không', N'123', NULL, NULL, NULL, NULL, 0, 1, N'023', N'123', NULL)
INSERT [dbo].[User] ([ID], [Pass], [Name], [Address], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [GroupID], [SDT], [Email], [HoTen]) VALUES (5, N'9b04d152845ec0a378394003c96da594', N'CODE', N'3123', NULL, NULL, NULL, NULL, 0, 1, N'12', N'3123', N'do van duog')
INSERT [dbo].[User] ([ID], [Pass], [Name], [Address], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [GroupID], [SDT], [Email], [HoTen]) VALUES (6, N'202cb962ac59075b964b07152d234b70', N'ad', NULL, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, NULL)
INSERT [dbo].[User] ([ID], [Pass], [Name], [Address], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [GroupID], [SDT], [Email], [HoTen]) VALUES (7, N'202cb962ac59075b964b07152d234b70', N'ggg', N'w', NULL, NULL, NULL, NULL, 1, 1, N'w', N'w', N'gg')
INSERT [dbo].[User] ([ID], [Pass], [Name], [Address], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [GroupID], [SDT], [Email], [HoTen]) VALUES (8, N'289dff07669d7a23de0ef88d2f7129e7', N'cc', N'c', NULL, NULL, NULL, NULL, 1, 1, N'c', N'c', N'duong')
INSERT [dbo].[User] ([ID], [Pass], [Name], [Address], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [GroupID], [SDT], [Email], [HoTen]) VALUES (9, N'a8f5f167f44f4964e6c998dee827110c', N'dasdsa', N'asd', NULL, NULL, NULL, NULL, 1, 1, N'dsa', N'das', N'das')
INSERT [dbo].[User] ([ID], [Pass], [Name], [Address], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [GroupID], [SDT], [Email], [HoTen]) VALUES (10, N'12345', N'duong123', N'ha noi', CAST(N'2018-06-20 14:10:44.000' AS DateTime), N'duong', NULL, NULL, NULL, 0, N'24421', N'do vand uongnds', N'dovanduong')
INSERT [dbo].[User] ([ID], [Pass], [Name], [Address], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [GroupID], [SDT], [Email], [HoTen]) VALUES (11, N'12345', N'duong123', N'ha noi', CAST(N'2018-06-20 14:11:15.000' AS DateTime), N'duong', NULL, NULL, NULL, 0, N'24421', N'do vand uongnds', N'dovanduong')
INSERT [dbo].[User] ([ID], [Pass], [Name], [Address], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [GroupID], [SDT], [Email], [HoTen]) VALUES (12, N'12345', N'duong123', N'ha noi', CAST(N'2018-06-20 14:12:19.000' AS DateTime), N'duong', NULL, NULL, 0, 0, N'24421', N'do vand uongnds', N'dovanduong')
INSERT [dbo].[User] ([ID], [Pass], [Name], [Address], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [GroupID], [SDT], [Email], [HoTen]) VALUES (13, N'1232', N'do vad uong', N'3122123', CAST(N'2018-06-20 14:31:45.000' AS DateTime), N'duong', NULL, NULL, 1, 0, N'213', N'312', N'231')
INSERT [dbo].[User] ([ID], [Pass], [Name], [Address], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [GroupID], [SDT], [Email], [HoTen]) VALUES (14, N'1232', N'do vad uong', N'3122123', CAST(N'2018-06-20 14:32:33.000' AS DateTime), N'duong', NULL, NULL, 1, 0, N'213', N'312', N'231')
INSERT [dbo].[User] ([ID], [Pass], [Name], [Address], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [GroupID], [SDT], [Email], [HoTen]) VALUES (15, N'1232', N'do vad uong', N'3122123', CAST(N'2018-06-20 14:33:31.000' AS DateTime), N'duong', NULL, NULL, 1, 0, N'213', N'312', N'231')
INSERT [dbo].[User] ([ID], [Pass], [Name], [Address], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [GroupID], [SDT], [Email], [HoTen]) VALUES (16, N'1232', N'do vad uong', N'3122123', CAST(N'2018-06-20 14:33:45.000' AS DateTime), N'duong', NULL, NULL, 1, 0, N'213', N'312', N'231')
INSERT [dbo].[User] ([ID], [Pass], [Name], [Address], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [GroupID], [SDT], [Email], [HoTen]) VALUES (17, N'1232', N'do vad uong', N'3122123', CAST(N'2018-06-20 14:34:25.000' AS DateTime), N'duong', NULL, NULL, 1, 0, N'213', N'312', N'231')
INSERT [dbo].[User] ([ID], [Pass], [Name], [Address], [NgayTao], [NguoiTao], [NgayUpdate], [NguoiUpdate], [TrangThai], [GroupID], [SDT], [Email], [HoTen]) VALUES (18, N'21312', N'duong', N'321231', CAST(N'2018-06-20 14:41:16.000' AS DateTime), N'duong', NULL, NULL, 1, 0, N'312', N'312', N'312')
SET IDENTITY_INSERT [dbo].[User] OFF
ALTER TABLE [dbo].[BaiViet]  WITH CHECK ADD  CONSTRAINT [FK_BaiViet_DanhMucBaiViet] FOREIGN KEY([DanhMucID])
REFERENCES [dbo].[DanhMucBaiViet] ([ID])
GO
ALTER TABLE [dbo].[BaiViet] CHECK CONSTRAINT [FK_BaiViet_DanhMucBaiViet]
GO
ALTER TABLE [dbo].[BaiVietTag]  WITH CHECK ADD  CONSTRAINT [FK_BaiVietTag_BaiViet] FOREIGN KEY([ID])
REFERENCES [dbo].[BaiViet] ([ID])
GO
ALTER TABLE [dbo].[BaiVietTag] CHECK CONSTRAINT [FK_BaiVietTag_BaiViet]
GO
ALTER TABLE [dbo].[BaiVietTag]  WITH CHECK ADD  CONSTRAINT [FK_BaiVietTag_TAGS] FOREIGN KEY([TagID])
REFERENCES [dbo].[TAGS] ([ID])
GO
ALTER TABLE [dbo].[BaiVietTag] CHECK CONSTRAINT [FK_BaiVietTag_TAGS]
GO
ALTER TABLE [dbo].[ChiTietHoaDon]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHoaDon_HoaDon] FOREIGN KEY([ID])
REFERENCES [dbo].[HoaDon] ([ID])
GO
ALTER TABLE [dbo].[ChiTietHoaDon] CHECK CONSTRAINT [FK_ChiTietHoaDon_HoaDon]
GO
ALTER TABLE [dbo].[ChiTietHoaDon]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHoaDon_SanPham] FOREIGN KEY([IDSanPham])
REFERENCES [dbo].[SanPham] ([ID])
GO
ALTER TABLE [dbo].[ChiTietHoaDon] CHECK CONSTRAINT [FK_ChiTietHoaDon_SanPham]
GO
ALTER TABLE [dbo].[Menu]  WITH CHECK ADD  CONSTRAINT [FK_Menu_MenuGroup] FOREIGN KEY([GroupID])
REFERENCES [dbo].[MenuGroup] ([ID])
GO
ALTER TABLE [dbo].[Menu] CHECK CONSTRAINT [FK_Menu_MenuGroup]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SanPham_DanhMucSanPham] FOREIGN KEY([DanhMucID])
REFERENCES [dbo].[DanhMucSanPham] ([ID])
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_SanPham_DanhMucSanPham]
GO
/****** Object:  StoredProcedure [dbo].[check_login]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[check_login]
@name NVARCHAR(50),@pass VARCHAR(32)
AS
BEGIN 

	SELECT *FROM dbo.[User] WHERE Name = @name AND Pass = @pass
END

GO
/****** Object:  StoredProcedure [dbo].[cthoadon]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[cthoadon]
@mahd int
AS
BEGIN

	SELECT dbo.SanPham.ID, dbo.SanPham.TenSanPham, dbo.ChiTietHoaDon.SoLuong, dbo.ChiTietHoaDon.Gia*dbo.ChiTietHoaDon.SoLuong AS 'gia' FROM dbo.ChiTietHoaDon,dbo.SanPham WHERE dbo.ChiTietHoaDon.IDSanPham = dbo.SanPham.ID
	AND dbo.ChiTietHoaDon.ID = @mahd
END
GO
/****** Object:  StoredProcedure [dbo].[doanhthunam]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[doanhthunam]
@nam int
As
BEGIN

	SELECT DATEPART(MONTH, dbo.HoaDon.NgayTao) AS 'Thang',SUM(dbo.ChiTietHoaDon.Gia) AS 'DoanhThu' FROM dbo.SanPham, dbo.ChiTietHoaDon,dbo.HoaDon WHERE dbo.SanPham.ID = dbo.ChiTietHoaDon.IDSanPham AND dbo.ChiTietHoaDon.ID = dbo.HoaDon.ID
	AND DATEPART(YEAR,HoaDon.NgayTao) = @nam
	GROUP BY DATEPART(MONTH, dbo.HoaDon.NgayTao) ORDER BY DATEPART(MONTH, dbo.HoaDon.NgayTao)
END

GO
/****** Object:  StoredProcedure [dbo].[load_data]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[load_data]
@search nvarchar(100)
AS
BEGIN
	SELECT *FROM dbo.[User] WHERE TrangThai = 1 and dbo.fChuyenCoDauThanhKhongDau(Name) LIKE '%'+dbo.fChuyenCoDauThanhKhongDau(@search)+'%'
END
GO
/****** Object:  StoredProcedure [dbo].[pr_addBV]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[pr_addBV]
@TenBaiViet nvarchar(500)
,@DanhMucID  INT
,@image NVARCHAR(500)
,@NoiDung  NTEXT
,@TieuDeBaiViet nvarchar(500)
,@MoTa nvarchar(500)
AS
BEGIN
	INSERT dbo.BaiViet
	        ( TenBaiViet ,
	          DanhMucID ,
	          NgayTao ,
	          NguoiTao ,
	          NgayUpdate ,
	          NguoiUpdate ,
	          TrangThai ,
	          image ,
	          GhiChu ,
	          ViewCount ,
	          MoreImage ,
	          NoiDung ,
	          TieuDeBaiViet ,
	          MoTa
	        )
	VALUES  ( @TenBaiViet , -- TenBaiViet - nvarchar(500)
	          @DanhMucID , -- DanhMucID - int
	          GETDATE() , -- NgayTao - datetime
	          '' , -- NguoiTao - varchar(50)
	          GETDATE() , -- NgayUpdate - datetime
	          '' , -- NguoiUpdate - varchar(50)
	          1 , -- TrangThai - bit
	          @image, -- image - nvarchar(500)
	          N'' , -- GhiChu - nvarchar(max)
	          0 , -- ViewCount - int
	          NULL , -- MoreImage - xml
	          @NoiDung , -- NoiDung - ntext
	          @TieuDeBaiViet , -- TieuDeBaiViet - nvarchar(500)
	          @MoTa  -- MoTa - nvarchar(500)
	        )
END
GO
/****** Object:  StoredProcedure [dbo].[pr_addDanhMucSP]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[pr_addDanhMucSP]
@tendanhmuc nvarchar(250), @thutu INT, @pk bit
AS
BEGIN
	INSERT dbo.DanhMucSanPham
	        ( TenDanhMuc ,
	          ThuTu ,
	          NgayTao ,
	          NguoiTao ,
	          NgayUpdate ,
	          NguoiUpdate ,
	          TrangThai ,
	          image ,
	          PhuKien
	        )
	VALUES  ( @tendanhmuc , -- TenDanhMuc - nvarchar(250)
	          @thutu , -- ThuTu - int
	          GETDATE() , -- NgayTao - datetime
	          '' , -- NguoiTao - varchar(50)
	          GETDATE() , -- NgayUpdate - datetime
	          '' , -- NguoiUpdate - varchar(50)
	          1 , -- TrangThai - bit
	          N'' , -- image - nvarchar(500)
	          @pk  -- PhuKien - bit
	        )
END
GO
/****** Object:  StoredProcedure [dbo].[pr_addDMBV]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[pr_addDMBV]
@TenDanhMuc nvarchar(250),@ThuTu INT
AS
BEGIN 
	INSERT dbo.DanhMucBaiViet
	        ( TenDanhMuc ,
	          ThuTu ,
	          NgayTao ,
	          NguoiTao ,
	          NgayUpdate ,
	          NguoiUpdate ,
	          TrangThai ,
	          image
	        )
	VALUES  ( @TenDanhMuc , -- TenDanhMuc - nvarchar(250)
	          @ThuTu , -- ThuTu - int
	          GETDATE() , -- NgayTao - datetime
	          '' , -- NguoiTao - varchar(50)
	          GETDATE() , -- NgayUpdate - datetime
	          '' , -- NguoiUpdate - varchar(50)
	          1 , -- TrangThai - bit
	          N''  -- image - nvarchar(500)
	        )
END
GO
/****** Object:  StoredProcedure [dbo].[pr_addSP]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[pr_addSP]
@TenSanPham  nvarchar(500),@DanhMucID INT,@image nvarchar(500),@SPHOT  BIT,@MoTa  nvarchar(max),
@NoiDung nvarchar(max),@Gia DECIMAL,@GiaKhuyenMai DECIMAL,@BaoHanh  int
, @DoPhanGiai nvarchar(250)
,@ManHinh nchar(20)
,@CamTruoc nvarchar(50)
,@CamSau nvarchar(50)
,@CPU nvarchar(250)
,@SoNhan nvarchar(250)
,@Chip nvarchar(250)
,@Ram nvarchar(50)
,@ROM nvarchar(50)
,@HeDieuHanh  nvarchar(250)
,@Pin  nvarchar(50)
,@DungluongPin  nvarchar(50)
,@Sim nvarchar(250)
,@wifi  nvarchar(250)
,@Bluetooth  nvarchar(50)
,@GPS  nvarchar(50)
AS 
BEGIN
	INSERT dbo.SanPham
	        ( TenSanPham ,
	          DanhMucID ,
	          NgayTao ,
	          NguoiTao ,
	          NgayUpdate ,
	          NguoiUpdate ,
	          TrangThai ,
	          image ,
	          GhiChu ,
	          SPHOT ,
	          ViewCount ,
	          MoreImage ,
	          MoTa ,
	          NoiDung ,
	          Gia ,
	          GiaKhuyenMai ,
	          BaoHanh ,
	          DoPhanGiai ,
	          ManHinh ,
	          CamTruoc ,
	          CamSau ,
	          CPU ,
	          SoNhan ,
	          Chip ,
	          Ram ,
	          ROM ,
	          HeDieuHanh ,
	          Pin ,
	          DungluongPin ,
	          Sim ,
	          wifi ,
	          Bluetooth ,
	          GPS
	        )
	VALUES  ( @TenSanPham , -- TenSanPham - nvarchar(500)
	          @DanhMucID , -- DanhMucID - int
	          GETDATE() , -- NgayTao - datetime
	          '' , -- NguoiTao - varchar(50)
	          GETDATE() , -- NgayUpdate - datetime
	          '' , -- NguoiUpdate - varchar(50)
	         1 , -- TrangThai - bit
	          @image , -- image - nvarchar(500)
	          N'' , -- GhiChu - nvarchar(max)
	          @SPHOT , -- SPHOT - bit
	          0 , -- ViewCount - int
	          NULL , -- MoreImage - xml
	          @MoTa , -- MoTa - nvarchar(max)
	          @NoiDung , -- NoiDung - nvarchar(max)
	          @Gia , -- Gia - decimal
	          @GiaKhuyenMai , -- GiaKhuyenMai - decimal
	          @BaoHanh , -- BaoHanh - int
	          @DoPhanGiai , -- DoPhanGiai - nvarchar(250)
	          @ManHinh , -- ManHinh - nchar(20)
	          @CamTruoc , -- CamTruoc - nvarchar(50)
	          @CamSau , -- CamSau - nvarchar(50)
	          @CPU , -- CPU - nvarchar(250)
	          @SoNhan , -- SoNhan - nvarchar(250)
	          @Chip , -- Chip - nvarchar(250)
	          @Ram , -- Ram - nvarchar(50)
	          @ROM , -- ROM - nvarchar(50)
	          @HeDieuHanh , -- HeDieuHanh - nvarchar(250)
	          @Pin , -- Pin - nvarchar(50)
	          @DungluongPin , -- DungluongPin - nvarchar(50)
	          @Sim , -- Sim - nvarchar(250)
	          @wifi , -- wifi - nvarchar(250)
	          @wifi , -- Bluetooth - nvarchar(50)
	          @wifi  -- GPS - nvarchar(50)
	        )
END

GO
/****** Object:  StoredProcedure [dbo].[pr_addUser]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[pr_addUser]
@user nvarchar(50),@pass VARCHAR(32), @address NVARCHAR(500), @hoten NVARCHAR(250),@sdt VARCHAR(50),@email nvarchar(500),
@createdate DATETIME, @nguoitao VARCHAR(50)
AS
BEGIN
	INSERT dbo.[User]
	        ( Pass ,
	          Name ,
	          Address ,
	          NgayTao ,
	          NguoiTao ,
	          NgayUpdate ,
	          NguoiUpdate ,
	          TrangThai ,
	          GroupID ,
	          SDT ,
	          Email ,
	          HoTen
	        )
	VALUES  ( @pass , -- Pass - varchar(32)
	          @user , -- Name - nvarchar(50)
	          @address , -- Address - nvarchar(500)
	          @createdate , -- NgayTao - datetime
	          @nguoitao , -- NguoiTao - varchar(50)
	          NULL , -- NgayUpdate - datetime
	          NULL , -- NguoiUpdate - varchar(50)
	          1 , -- TrangThai - bit
	          0 , -- GroupID - int
	          @sdt , -- SDT - varchar(50)
	          @email , -- Email - nvarchar(500)
	          @hoten  -- HoTen - nvarchar(250)
	        )
END
GO
/****** Object:  StoredProcedure [dbo].[pr_deleteBV]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[pr_deleteBV]
@id int
AS
BEGIN 
	UPDATE dbo.BaiViet SET TrangThai = 0 WHERE ID = @id
END
GO
/****** Object:  StoredProcedure [dbo].[pr_deleteDMBV]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[pr_deleteDMBV]
@id int
AS
BEGIN 
	UPDATE dbo.DanhMucBaiViet SET TrangThai = 0 WHERE ID = @id
END
GO
/****** Object:  StoredProcedure [dbo].[pr_deleteDMSP]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[pr_deleteDMSP]
@id int
AS
BEGIN 
	UPDATE dbo.DanhMucSanPham SET TrangThai = 0 WHERE ID = @id
END

GO
/****** Object:  StoredProcedure [dbo].[pr_deleteSP]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[pr_deleteSP]
@id int
AS
BEGIN 
	UPDATE dbo.SanPham SET TrangThai = 0 WHERE ID = @id
END
GO
/****** Object:  StoredProcedure [dbo].[pr_deleteUser]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[pr_deleteUser]
@id int
AS
BEGIN
UPDATE dbo.[User] SET TrangThai = 0 WHERE ID = @id
end
GO
/****** Object:  StoredProcedure [dbo].[pr_detailsp]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[pr_detailsp]
@id int
AS
BEGIN
SELECT id,TenSanPham,DanhMucID,image,MoTa,NoiDung,Gia,SPHOT, GiaKhuyenMai,BaoHanh,DoPhanGiai,ManHinh,CamTruoc,CamSau,CPU,SoNhan,Chip,Ram,ROM,HeDieuHanh,Pin,DungluongPin,Sim,wifi,Bluetooth,GPS FROM dbo.SanPham
WHERE TrangThai = 1 AND ID = @id
END
GO
/****** Object:  StoredProcedure [dbo].[pr_loadDanhMucBV]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[pr_loadDanhMucBV]
AS
BEGIN
SELECT ID,TenDanhMuc,ThuTu FROM dbo.DanhMucBaiViet WHERE TrangThai = 1 ORDER BY ThuTu asc
END

GO
/****** Object:  StoredProcedure [dbo].[pr_loadDanhMucSanPham]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[pr_loadDanhMucSanPham]
AS
BEGIN
SELECT ID,TenDanhMuc,ThuTu FROM dbo.DanhMucSanPham WHERE TrangThai = 1 ORDER BY ThuTu asc
END

GO
/****** Object:  StoredProcedure [dbo].[pr_loadPK]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROC [dbo].[pr_loadPK]
AS
BEGIN
SELECT ID,TenDanhMuc,ThuTu FROM dbo.DanhMucSanPham WHERE TrangThai = 1 and phukien = 1 ORDER BY ThuTu asc
END
GO
/****** Object:  StoredProcedure [dbo].[pr_loadSanPham]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[pr_loadSanPham]
@search nvarchar(250)
AS
BEGIN
SELECT ID,TenSanPham,image FROM dbo.SanPham WHERE TrangThai = 1 AND dbo.fChuyenCoDauThanhKhongDau(TenSanPham) LIKE '%'+dbo.fChuyenCoDauThanhKhongDau(@search)+'%'
END
GO
/****** Object:  StoredProcedure [dbo].[pr_Thongkesanpham]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[pr_Thongkesanpham]
AS
BEGIN
	   SELECT dbo.ChiTietHoaDon.IDSanPham,TenSanPham,COUNT(*) AS 'sl',SUM(ChiTietHoaDon.Gia) AS 'tonggia' FROM dbo.SanPham, dbo.ChiTietHoaDon WHERE dbo.SanPham.ID = dbo.ChiTietHoaDon.IDSanPham GROUP BY ChiTietHoaDon.IDSanPham,TenSanPham
END

GO
/****** Object:  StoredProcedure [dbo].[pr_updateBV]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[pr_updateBV]
@TenBaiViet nvarchar(500)
,@DanhMucID  INT
,@image NVARCHAR(500)
,@NoiDung  NTEXT
,@TieuDeBaiViet nvarchar(500)
,@MoTa nvarchar(500)
,@id int
AS
BEGIN
	UPDATE dbo.BaiViet SET TenBaiViet = @TenBaiViet,DanhMucID= @DanhMucID,image = @image,NoiDung = @NoiDung,TieuDeBaiViet=@TieuDeBaiViet,MoTa=@MoTa
	WHERE id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[pr_updateDMBV]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[pr_updateDMBV]
@TenDanhMuc nvarchar(250), @thutu INT, @id INT
AS
BEGIN 
	UPDATE dbo.DanhMucBaiViet SET TenDanhMuc = @TenDanhMuc, ThuTu = @thutu WHERE ID = @id
END
GO
/****** Object:  StoredProcedure [dbo].[pr_updateDMSP]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[pr_updateDMSP]
@TenDanhMuc nvarchar(250), @thutu INT, @id INT,@pk bit
AS
BEGIN 
	UPDATE dbo.DanhMucSanPham SET TenDanhMuc = @TenDanhMuc, ThuTu = @thutu,PhuKien = @pk WHERE ID = @id
END
GO
/****** Object:  StoredProcedure [dbo].[pr_updateSP]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[pr_updateSP]
@TenSanPham  nvarchar(500),@DanhMucID INT,@image nvarchar(500),@SPHOT  BIT,@MoTa  nvarchar(max),
@NoiDung nvarchar(max),@Gia DECIMAL,@GiaKhuyenMai DECIMAL,@BaoHanh  int
, @DoPhanGiai nvarchar(250)
,@ManHinh nchar(20)
,@CamTruoc nvarchar(50)
,@CamSau nvarchar(50)
,@CPU nvarchar(250)
,@SoNhan nvarchar(250)
,@Chip nvarchar(250)
,@Ram nvarchar(50)
,@ROM nvarchar(50)
,@HeDieuHanh  nvarchar(250)
,@Pin  nvarchar(50)
,@DungluongPin  nvarchar(50)
,@Sim nvarchar(250)
,@wifi  nvarchar(250)
,@Bluetooth  nvarchar(50)
,@GPS  nvarchar(50),@ID int
AS
BEGIN
	UPDATE dbo.SanPham SET TenSanPham = @TenSanPham, DanhMucID = @DanhMucID,image = @image,SPHOT = @SPHOT,MoTa=@MoTa,NoiDung=@NoiDung,Gia=@gia,
	GiaKhuyenMai=@GiaKhuyenMai,BaoHanh=@BaoHanh,DoPhanGiai=@DoPhanGiai,ManHinh=@ManHinh,CamTruoc=@CamTruoc, CamSau = @CamSau,CPU = @CPU,
	SoNhan = @SoNhan,Chip = @Chip,Ram = @Ram,ROM = @ROM,HeDieuHanh=@HeDieuHanh,Pin = @Pin,DungluongPin = @DungluongPin,Sim = @Sim,
	wifi = @wifi,Bluetooth = @Bluetooth,GPS = @GPS WHERE ID = @ID
END
GO
/****** Object:  StoredProcedure [dbo].[pr_updateUser]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[pr_updateUser]
@user nvarchar(50), @hoten nvarchar(250),@diachi nvarchar(500), @sdt varchar(50) ,@mail nvarchar(500), @id int
AS
BEGIN 
UPDATE dbo.[User] SET Name = @user ,HoTen = @hoten, Address = @diachi, SDT = @sdt,Email = @mail WHERE ID = @id
END


GO
/****** Object:  StoredProcedure [dbo].[thongke]    Script Date: 7/7/2018 10:38:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[thongke]
@thang int, @nam int
AS
BEGIN
	SELECT dbo.ChiTietHoaDon.IDSanPham,TenSanPham,SUM(dbo.ChiTietHoaDon.SoLuong) AS 'Soluong' , SUM(ChiTietHoaDon.Gia) AS 'Tong' FROM dbo.SanPham, dbo.ChiTietHoaDon,dbo.HoaDon WHERE dbo.SanPham.ID = dbo.ChiTietHoaDon.IDSanPham AND dbo.ChiTietHoaDon.ID = dbo.HoaDon.ID
	AND DATEPART(MONTH,HoaDon.NgayTao) = @thang AND DATEPART(YEAR,HoaDon.NgayTao) = @nam
	GROUP BY dbo.ChiTietHoaDon.IDSanPham,TenSanPham ORDER BY SUM(dbo.ChiTietHoaDon.SoLuong) DESC
END
GO
USE [master]
GO
ALTER DATABASE [Duongxxx] SET  READ_WRITE 
GO
