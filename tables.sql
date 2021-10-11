/****** Object:  Table [dbo].[tblschedules]    Script Date: 10/11/2021 3:33:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblschedules](
	[schedule_id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[movie_id] [int] NOT NULL,
	[cinema_id] [tinyint] NOT NULL,
	[price] [numeric](18, 2) NOT NULL,
	[date_time] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_tblschedules] PRIMARY KEY CLUSTERED 
(
	[schedule_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[tblmovies]    Script Date: 10/11/2021 3:33:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblmovies](
	[movie_id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[title] [varchar](100) NOT NULL,
	[description] [varchar](250) NOT NULL,
	[imgtype] [varchar](5) NOT NULL,
	[default_price] [numeric](18, 2) NOT NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[tblcinemas]    Script Date: 10/11/2021 3:33:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblcinemas](
	[cinema_id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[description] [varchar](50) NOT NULL,
	[seat_count] [int] NOT NULL,
	[default_price] [numeric](18, 2) NOT NULL,
 CONSTRAINT [PK_tblcinemas] PRIMARY KEY CLUSTERED 
(
	[cinema_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[tblreservations]    Script Date: 10/11/2021 3:33:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblreservations](
	[reservation_id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[schedule_id] [int] NOT NULL,
	[customer_name] [varchar](100) NOT NULL,
	[date_reserved] [smalldatetime] NOT NULL,
	[status] [varchar](20) NOT NULL,
	[total] [numeric](18, 2) NOT NULL,
	[date_cancelled] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_tblreservations] PRIMARY KEY CLUSTERED 
(
	[reservation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[tblreservationdetails]    Script Date: 10/11/2021 3:33:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblreservationdetails](
	[reservation_detail_id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[reservation_id] [int] NOT NULL,
	[seat_id] [int] NOT NULL,
	[schedule_id] [int] NOT NULL,
 CONSTRAINT [PK_tblreservationdetails] PRIMARY KEY CLUSTERED 
(
	[reservation_detail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[tblseats]    Script Date: 10/11/2021 3:33:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblseats](
	[seat_id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[cinema_id] [tinyint] NOT NULL,
	[row] [tinyint] NOT NULL,
	[col] [tinyint] NOT NULL,
 CONSTRAINT [PK_tblseats] PRIMARY KEY CLUSTERED 
(
	[seat_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblschedules] ADD  CONSTRAINT [DF_tblschedules_movie_id]  DEFAULT ((0)) FOR [movie_id]
GO

ALTER TABLE [dbo].[tblschedules] ADD  CONSTRAINT [DF_tblschedules_cinema_id]  DEFAULT ((0)) FOR [cinema_id]
GO

ALTER TABLE [dbo].[tblschedules] ADD  CONSTRAINT [DF_tblschedules_price]  DEFAULT ((0)) FOR [price]
GO

ALTER TABLE [dbo].[tblschedules] ADD  CONSTRAINT [DF_tblschedules_start_date]  DEFAULT (((1)/(1))/(1900)) FOR [date_time]
GO

ALTER TABLE [dbo].[tblmovies] ADD  CONSTRAINT [DF_tblmovies_title]  DEFAULT ('') FOR [title]
GO

ALTER TABLE [dbo].[tblmovies] ADD  CONSTRAINT [DF_tblmovies_description]  DEFAULT ('') FOR [description]
GO

ALTER TABLE [dbo].[tblmovies] ADD  CONSTRAINT [DF_tblmovies_imgtype]  DEFAULT ('') FOR [imgtype]
GO

ALTER TABLE [dbo].[tblmovies] ADD  CONSTRAINT [DF_tblmovies_default_price]  DEFAULT ((0)) FOR [default_price]
GO

ALTER TABLE [dbo].[tblcinemas] ADD  CONSTRAINT [DF_tblcinemas_description]  DEFAULT ('') FOR [description]
GO

ALTER TABLE [dbo].[tblcinemas] ADD  CONSTRAINT [DF_tblcinemas_seatcount]  DEFAULT ((0)) FOR [seat_count]
GO

ALTER TABLE [dbo].[tblcinemas] ADD  CONSTRAINT [DF_tblcinemas_default_price]  DEFAULT ((0)) FOR [default_price]
GO

ALTER TABLE [dbo].[tblreservations] ADD  CONSTRAINT [DF_tblreservations_customer_name]  DEFAULT ('') FOR [customer_name]
GO

ALTER TABLE [dbo].[tblreservations] ADD  CONSTRAINT [DF_tblreservations_date_reserved]  DEFAULT (((1)/(1))/(1900)) FOR [date_reserved]
GO

ALTER TABLE [dbo].[tblreservations] ADD  CONSTRAINT [DF_tblreservations_status]  DEFAULT ('') FOR [status]
GO

ALTER TABLE [dbo].[tblreservations] ADD  CONSTRAINT [DF_tblreservations_total]  DEFAULT ((0)) FOR [total]
GO

ALTER TABLE [dbo].[tblreservations] ADD  CONSTRAINT [DF_tblreservations_date_cancelled]  DEFAULT (((1)/(1))/(1900)) FOR [date_cancelled]
GO

ALTER TABLE [dbo].[tblreservationdetails] ADD  CONSTRAINT [DF_tblreservationdetails_reservation_id]  DEFAULT ((0)) FOR [reservation_id]
GO

ALTER TABLE [dbo].[tblreservationdetails] ADD  CONSTRAINT [DF_tblreservationdetails_seat_id]  DEFAULT ((0)) FOR [seat_id]
GO

ALTER TABLE [dbo].[tblreservationdetails] ADD  CONSTRAINT [DF_tblreservationdetails_schedule_id]  DEFAULT ((0)) FOR [schedule_id]
GO

ALTER TABLE [dbo].[tblseats] ADD  CONSTRAINT [DF_tblseats_cinema_id]  DEFAULT ((0)) FOR [cinema_id]
GO

ALTER TABLE [dbo].[tblseats] ADD  CONSTRAINT [DF_tblseats_row]  DEFAULT ((0)) FOR [row]
GO

ALTER TABLE [dbo].[tblseats] ADD  CONSTRAINT [DF_tblseats_column]  DEFAULT ((0)) FOR [col]
GO


