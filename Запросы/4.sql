--CREATE FUNCTION TSK_A(@s_id int)
--RETURNS @table table(b_id int)
--AS
--BEGIN
--insert @table
--select sb_book from subscriptions
--where sb_subscriber = @s_id and sb_is_active = 'y'
--return 
--END;
--GO

--SELECT * from TSK_A(1)

--CREATE FUNCTION GET_FREE_KEYS_IN_SUBSCRIPTIONS()
--RETURNS @free_keys TABLE
-- (
-- [start] INT,
-- [stop] INT
-- )
--AS
--BEGIN
--INSERT @free_keys
-- SELECT top  [start],
-- [stop]
-- FROM (SELECT [min_t].[sb_id] + 1 AS [start],
-- (SELECT MIN([sb_id]) - 1
-- FROM [subscriptions] AS [x]
-- WHERE [x].[sb_id] > [min_t].[sb_id]) AS [stop]
-- FROM [subscriptions] AS [min_t]
-- UNION
-- SELECT 1 AS [start],
-- (SELECT MIN([sb_id]) - 1
-- FROM [subscriptions] AS [x]
-- WHERE [sb_id] > 0) AS [stop]
-- ) AS [data]
-- WHERE [stop] >= [start]
-- ORDER BY [start],
-- [stop]
--RETURN
--END;
--GO--SELECT * FROM GET_FREE_KEYS_IN_SUBSCRIPTIONS()--CREATE FUNCTION CHECK_SUBSCRIPTION_DATES1(@sb_start DATE,
-- @sb_finish DATE)
--RETURNS INT
--WITH SCHEMABINDING
--AS
--BEGIN
--DECLARE @result INT = 1;
---- Блокировка выдач книг с датой выдачи в будущем
--IF (@sb_start > CONVERT(date, GETDATE()))
-- BEGIN
-- SET @result = -1;
-- END;
---- Блокировка выдач книг с датой возврата в прошлом.
--IF ((@sb_finish < CONVERT(date, GETDATE())))
-- BEGIN
-- SET @result = -2;
-- END;
---- Блокировка выдач книг с датой возврата меньшей, чем дата выдачи.
--IF (@sb_finish < @sb_start)
-- BEGIN
-- SET @result = -3;
-- END;
--RETURN @result;
--END;--select --CREATE TRIGGER [512TSKA]
--ON [subscriptions]
--AFTER INSERT, UPDATE
--AS
--DECLARE @sb_start date
--DECLARE @sb_finish date
--DECLARE @result int;
--select @sb_start = sb_start,
--@sb_finish = @sb_finish from inserted
--select @result = dbo.CHECK_SUBSCRIPTION_DATES1(@sb_start,@sb_finish)
--if @result = -1
-- begin
-- raiserror('Выдача в будущем',16,1,@result)
-- rollback tran
-- end
-- if @result = -2
-- begin
-- raiserror('Выдача в прошлом',16,1,@result)
-- rollback tran
-- end
-- if @result = -3
-- begin
-- raiserror('Меньше чем дата выдачи',16,1,@result)
-- rollback tran
-- end

-- insert into subscriptions values (2,4,'2022-01-01','2023-01-01','y')

create function chek_books(@sb_subscriber int)
returns int
as
begin
declare @sb_book int
set @sb_book= (select count (sb_book) from subscriptions 
where @sb_subscriber = subscriptions.sb_subscriber)
declare @result int = 1;
if (@sb_book >= 10)
begin
set @result = 0;
end;
return @result;
end;



CREATE function books_cntrl_year_ins_upd(@b_id int)
returns int
AS
begin
declare @result int = 1;
declare @year int;
set @year =  (select (YEAR(GETDATE()) - b_year) from books where @b_id = b_id)
	if (@year>100)
	begin set @result = 0;
	end;
	return @result
	end

	select dbo.books_cntrl_year_ins_upd(3)





