/****** Object:  StoredProcedure [dbo].[sp_getschedules]    Script Date: 10/11/2021 3:34:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[sp_getschedules]
	
	@schedule_id	Int

AS
BEGIN

	SET NOCOUNT ON;

	SELECT schedule_id, movie_id, cinema_id, price, date_time,
	title = ISNULL(b.title, ''),
	description = ISNULL(c.description, ''),
	status = CASE WHEN date_time >= GETDATE() THEN 'OPEN' ELSE 'CLOSED' END,
	reserved_count = ISNULL((SELECT COUNT(reservation_id) FROM tblreservations WHERE schedule_id = a.schedule_id AND status = 'RESERVED'), 0),
	reserved = ISNULL((SELECT TOP 1 reservation_id FROM tblreservations WITH(NOLOCK) WHERE schedule_id = a.schedule_id AND status IN ('RESERVED', 'USED')), 0)
	FROM tblschedules a WITH(NOLOCK)
	OUTER APPLY (SELECT title FROM tblmovies b WITH(NOLOCK) WHERE a.movie_id = b.movie_id) b
	OUTER APPLY (SELECT description FROM tblcinemas c WITH(NOLOCK) WHERE a.cinema_id = c.cinema_id) c
	WHERE (@schedule_id = 0 AND schedule_id <> 0) OR (@schedule_id <> 0 AND schedule_id = @schedule_id)
	ORDER BY
	CASE WHEN date_time >= GETDATE() THEN 0 ELSE 1 END,
	date_time
	
END
GO

/****** Object:  StoredProcedure [dbo].[sp_getmovies]    Script Date: 10/11/2021 3:34:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_getmovies]
	
	@movie_id	Int

AS
BEGIN

	SET NOCOUNT ON;

	SELECT movie_id, title, description, imgtype, default_price,
	reserved = ISNULL((SELECT TOP 1 reservation_id
				FROM tblreservations b WITH(NOLOCK)
				OUTER APPLY (SELECT movie_id FROM tblschedules c WHERE b.schedule_id = c.schedule_id) c
				WHERE c.movie_id = movie_id AND b.status IN ('RESERVED', 'USED')), 0)
	FROM tblmovies a WITH(NOLOCK)
	WHERE (@movie_id = 0 AND movie_id <> 0) OR (@movie_id <> 0 AND movie_id = @movie_id)
	ORDER BY title
	
END
GO

/****** Object:  StoredProcedure [dbo].[sp_getcinemas]    Script Date: 10/11/2021 3:34:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_getcinemas]
	
	@cinema_id	Int

AS
BEGIN

	SET NOCOUNT ON;

	SELECT cinema_id, description, seat_count, default_price,
	schedule_count = (SELECT COUNT(schedule_id) FROM tblschedules WHERE cinema_id = a.cinema_id AND date_time >= GETDATE()),
	reserved = ISNULL((SELECT TOP 1 reservation_id
				FROM tblreservations b WITH(NOLOCK)
				OUTER APPLY (SELECT cinema_id FROM tblschedules c WHERE b.schedule_id = c.schedule_id) c
				WHERE c.cinema_id = a.cinema_id AND b.status IN ('RESERVED', 'USED')), 0)
	FROM tblcinemas a WITH(NOLOCK)
	WHERE (@cinema_id = 0 AND cinema_id <> 0) OR (@cinema_id <> 0 AND cinema_id = @cinema_id)
	ORDER BY description
	
END
GO

/****** Object:  StoredProcedure [dbo].[sp_checkschedulecount]    Script Date: 10/11/2021 3:34:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_checkschedulecount]
	
	@schedule_id	Int,
	@cinema_id		Tinyint,
	@date_time		Smalldatetime

AS
BEGIN

	SET NOCOUNT ON;

	SELECT COUNT(schedule_id)
	FROM tblschedules WITH(NOLOCK)
	WHERE schedule_id <> @schedule_id
	ANd cinema_id = @cinema_id
	AND CAST(date_time AS DATE) = CAST(@date_time AS DATE)
	
END
GO

/****** Object:  StoredProcedure [dbo].[sp_getnowshowing]    Script Date: 10/11/2021 3:34:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_getnowshowing]
	
AS
BEGIN

	SET NOCOUNT ON;

	SELECT a.cinema_id, a.description,
	seat_count = a.seat_count - (SELECT COUNT(seat_id) FROM tblreservationdetails WHERE reservation_id IN (
									SELECT reservation_id FROM tblreservations WHERE schedule_id = b.schedule_id AND status = 'RESERVED'
								)),
	schedule_id = ISNULL(b.schedule_id, 0),
	movie_id = ISNULL(b.movie_id, 0),
	price = ISNULL(b.price, 0),
	date_time = ISNULL(b.date_time, '1/1/1900'),
	movietitle = ISNULL(c.title, ''),
	moviedescription = ISNULL(c.description, ''),
	imgtype = ISNULL(c.imgtype, '')
	FROM tblcinemas a WITH(NOLOCK)
	OUTER APPLY (SELECT TOP 1 schedule_id, movie_id, price, date_time FROM tblschedules b WITH(NOLOCK) WHERE a.cinema_id = b.cinema_id AND b.date_time >= GETDATE() ORDER BY date_time) b
	OUTER APPLY (SELECT title, description, imgtype FROM tblmovies c WITH(NOLOCK) WHERE b.movie_id = c.movie_id) c
	WHERE b.date_time >= GETDATE()
	ORDER BY a.description
	
END
GO

/****** Object:  StoredProcedure [dbo].[sp_gethistory]    Script Date: 10/11/2021 3:34:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_gethistory]
	
	@schedule_id	Int

AS
BEGIN

	SET NOCOUNT ON;

	SELECT reservation_id, date_reserved, customer_name, status, seats = '', date_cancelled,
	date_time = ISNULL(b.date_time, '1/1/1900'),
	description = ISNULL(c.description, ''),
	title = ISNULL(d.title, '')
	FROM tblreservations a WITH(NOLOCK)
	OUTER APPLY (SELECT movie_id, cinema_id, date_time FROM tblschedules b WITH(NOLOCK) WHERE a.schedule_id = b.schedule_id) b
	OUTER APPLY (SELECT description FROM tblcinemas c WITH(NOLOCK) WHERE b.cinema_id = c.cinema_id) c
	OUTER APPLY (SELECT title FROM tblmovies d WITH(NOLOCK) WHERE b.movie_id = d.movie_id) d
	WHERE (@schedule_id = 0 AND schedule_id <> 0) OR (@schedule_id <> 0 AND schedule_id = @schedule_id)
	ORDER BY date_reserved
	
END
GO

/****** Object:  StoredProcedure [dbo].[sp_cancelreservation]    Script Date: 10/11/2021 3:34:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_cancelreservation]
	
	@reservation_id	Int

AS
BEGIN

	SET NOCOUNT ON;

	UPDATE tblreservations SET
	status = 'CANCELLED',
	date_cancelled = GETDATE()
	WHERE reservation_id = @reservation_id
	
END
GO

/****** Object:  StoredProcedure [dbo].[sp_cancelallreservation]    Script Date: 10/11/2021 3:34:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_cancelallreservation]
	
	@schedule_id	Int

AS
BEGIN

	SET NOCOUNT ON;

	UPDATE tblreservations SET
	status = 'CANCELLED',
	date_cancelled = GETDATE()
	WHERE schedule_id = @schedule_id AND status = 'RESERVED'
	
END
GO

/****** Object:  StoredProcedure [dbo].[sp_checkmovie]    Script Date: 10/11/2021 3:34:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_checkmovie]
	
	@movie_id		Int,
	@title			Varchar(100),
	@description	Varchar(250)

AS
BEGIN

	SET NOCOUNT ON;

	SELECT TOP 1 movie_id
	FROM tblmovies WITH(NOLOCK)
	WHERE movie_id <> @movie_id
	AND title = @title
	AND description = @description
	
END
GO

/****** Object:  StoredProcedure [dbo].[sp_checkcinema]    Script Date: 10/11/2021 3:34:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_checkcinema]
	
	@cinema_id		Tinyint,
	@description	Varchar(50)

AS
BEGIN

	SET NOCOUNT ON;

	SELECT TOP 1 cinema_id
	FROM tblcinemas WITH(NOLOCK)
	WHERE cinema_id <> @cinema_id
	AND description = @description
	
END
GO

/****** Object:  StoredProcedure [dbo].[sp_savemovie]    Script Date: 10/11/2021 3:34:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_savemovie]
	
	@movie_id		Int,
	@title			Varchar(100),
	@description	Varchar(250),
	@imgtype		Varchar(5),
	@default_price	Numeric(18,2)

AS
BEGIN

	SET NOCOUNT ON;

	IF @movie_id = 0
	BEGIN
		INSERT INTO tblmovies (title)
		VALUES (@title)
		SELECT @movie_id = @@IDENTITY
	END

	UPDATE tblmovies SET
	title = @title,
	description = @description,
	imgtype = @imgtype,
	default_price = @default_price
	WHERE movie_id = @movie_id

	SELECT @movie_id
	
END
GO

/****** Object:  StoredProcedure [dbo].[sp_savecinema]    Script Date: 10/11/2021 3:34:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_savecinema]
	
	@cinema_id		Int,
	@description	Varchar(100),
	@seat_count		Int,
	@default_price	Numeric(18,2)

AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @row	Int = 0,
			@col	Int = 0

	IF @cinema_id = 0
	BEGIN
		INSERT INTO tblcinemas (description)
		VALUES (@description)
		SELECT @cinema_id = @@IDENTITY
	END

	UPDATE tblcinemas SET
	description = @description,
	seat_count = @seat_count,
	default_price = @default_price
	WHERE cinema_id = @cinema_id

	SELECT TOP 1 @row = row, @col = col
	FROM tblseats WITH(NOLOCK)
	WHERE cinema_id = @cinema_id
	ORDER BY row DESC, col DESC

	SELECT cinema_id = @cinema_id, row = @row, col = @col
	
END
GO

/****** Object:  StoredProcedure [dbo].[sp_getcinemaseats]    Script Date: 10/11/2021 3:34:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_getcinemaseats]
	
	@schedule_id	Int

AS
BEGIN

	SET NOCOUNT ON;

	SELECT seat_id = ISNULL(b.seat_id, 0),
	row = ISNULL(b.row, 0),
	col = ISNULL(b.col, 0),
	status = ISNULL(d.status, 'VACANT')
	FROM tblschedules a WITH(NOLOCK)
	OUTER APPLY (SELECT seat_id, row, col FROM tblseats b WITH(NOLOCK) WHERE a.cinema_id = b.cinema_id) b
	OUTER APPLY (SELECT reservation_id, seat_id FROM tblreservationdetails c WITH(NOLOCK) WHERE a.schedule_id = c.schedule_id AND b.seat_id = c.seat_id AND c.reservation_id NOT IN (SELECT reservation_id FROM tblreservations WHERE status = 'CANCELLED')) c
	OUTER APPLY (SELECT status FROM tblreservations d WITH(NOLOCK) WHERE a.schedule_id = d.schedule_id AND c.reservation_id = d.reservation_id AND d.status = 'RESERVED') d
	WHERE a.schedule_id = @schedule_id
	ORDER BY row, col
	
END
GO

/****** Object:  StoredProcedure [dbo].[sp_gethistoryseats]    Script Date: 10/11/2021 3:34:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_gethistoryseats]
	
	@schedule_id	Int

AS
BEGIN

	SET NOCOUNT ON;

	SELECT a.reservation_id,
	row = ISNULL(c.row, 0),
	col = ISNULL(c.col, 0)
	FROM tblreservations a WITH(NOLOCK)
	OUTER APPLY (SELECT seat_id FROM tblreservationdetails b WITH(NOLOCK) WHERE a.reservation_id = b.reservation_id) b
	OUTER APPLY (SELECT row, col FROM tblseats c WITH(NOLOCK) WHERE b.seat_id = c.seat_id) c
	WHERE (@schedule_id = 0 AND schedule_id <> 0) OR (@schedule_id <> 0 AND schedule_id = @schedule_id)
	ORDER BY reservation_id, row, col
	
END
GO

/****** Object:  StoredProcedure [dbo].[sp_savereservation]    Script Date: 10/11/2021 3:34:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_savereservation]
	
	@schedule_id	Int,
	@customer_name	Varchar(100),
	@total			Numeric(18,2)

AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @reservation_id	Int	= 0

	INSERT INTO tblreservations (schedule_id, customer_name, status, date_reserved, total)
	VALUES (@schedule_id, @customer_name, 'RESERVED', GETDATE(), @total)
	SELECT @reservation_id = @@IDENTITY

	SELECT @reservation_id
	
END
GO

/****** Object:  StoredProcedure [dbo].[sp_savereservationdetail]    Script Date: 10/11/2021 3:34:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_savereservationdetail]
	
	@reservation_id			Int,
	@seat_id				Int,
	@schedule_id			Int

AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @reservation_detail_id	Int	= 0

	INSERT INTO tblreservationdetails (reservation_id, seat_id, schedule_id)
	VALUES (@reservation_id, @seat_id, @schedule_id)
	SELECT @reservation_detail_id = @@IDENTITY

	SELECT @reservation_detail_id
	
END
GO

/****** Object:  StoredProcedure [dbo].[sp_getcinemaschedules]    Script Date: 10/11/2021 3:34:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[sp_getcinemaschedules]
	
	@cinema_id	Int

AS
BEGIN

	SET NOCOUNT ON;

	SELECT schedule_id, movie_id, price, date_time,
	title = ISNULL(b.title, ''),
	imgtype = ISNULL(b.imgtype, ''),
	imgurl = CAST(movie_id AS VARCHAR) + ISNULL(b.imgtype, '')
	FROM tblschedules a WITH(NOLOCK)
	OUTER APPLY (SELECT title, imgtype FROM tblmovies b WITH(NOLOCK) WHERE a.movie_id = b.movie_id) b
	WHERE ((cinema_id = @cinema_id)
	AND (date_time >= GETDATE()))
	ORDER BY date_time
	
END
GO

/****** Object:  StoredProcedure [dbo].[sp_saveseat]    Script Date: 10/11/2021 3:34:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_saveseat]
	
	@seat_id	Int,
	@cinema_id	Tinyint,
	@row		Tinyint,
	@col		Tinyint

AS
BEGIN

	SET NOCOUNT ON;

	IF @seat_id = 0
	BEGIN
		INSERT INTO tblseats (cinema_id)
		VALUES (@cinema_id)
		SELECT @seat_id = @@IDENTITY
	END

	UPDATE tblseats SET
	cinema_id = @cinema_id,
	row = @row,
	col = @col
	WHERE seat_id = @seat_id

	SELECT @seat_id
	
END
GO

/****** Object:  StoredProcedure [dbo].[sp_checkschedule]    Script Date: 10/11/2021 3:34:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_checkschedule]
	
	@schedule_id	Int,
	@cinema_id		Tinyint,
	@date_time		Smalldatetime

AS
BEGIN

	SET NOCOUNT ON;

	SELECT TOP 1 schedule_id
	FROM tblschedules WITH(NOLOCK)
	WHERE schedule_id <> @schedule_id
	AND cinema_id = @cinema_id
	AND date_time = @date_time
	
END
GO

/****** Object:  StoredProcedure [dbo].[sp_updateusedreservation]    Script Date: 10/11/2021 3:34:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_updateusedreservation]
	
	@schedule_id	Int

AS
BEGIN

	SET NOCOUNT ON;

	UPDATE b SET
	status = 'USED'
	FROM tblschedules a
	OUTER APPLY (SELECT status, date_reserved FROM tblreservations b WHERE a.schedule_id = b.schedule_id) b
	WHERE a.schedule_id = @schedule_id AND a.date_time <= GETDATE() AND b.status = 'RESERVED' AND b.date_reserved <= GETDATE()
	
END
GO

/****** Object:  StoredProcedure [dbo].[sp_saveschedule]    Script Date: 10/11/2021 3:34:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_saveschedule]
	
	@schedule_id	Int,
	@movie_id		Int,
	@cinema_id		Tinyint,
	@price			Numeric(18,2),
	@date_time		Smalldatetime

AS
BEGIN

	SET NOCOUNT ON;

	IF @schedule_id = 0
	BEGIN
		INSERT INTO tblschedules (movie_id)
		VALUES (@movie_id)
		SELECT @schedule_id = @@IDENTITY
	END

	UPDATE tblschedules SET
	movie_id = @movie_id,
	cinema_id = @cinema_id,
	price = @price,
	date_time = @date_time
	WHERE schedule_id = @schedule_id

	SELECT @schedule_id
	
END
GO

/****** Object:  StoredProcedure [dbo].[sp_getnewmovieid]    Script Date: 10/11/2021 3:34:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[sp_getnewmovieid]

AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @movie_id Int = 0

	SELECT TOP 1 @movie_id = movie_id
	FROM tblmovies WITH(NOLOCK)
	ORDER BY movie_id DESC

	SELECT @movie_id + 1
	
END
GO


