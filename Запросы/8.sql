--with [aaa]
--	AS 
--		(SELECT [authors].[a_id], [authors].[a_name], COUNT([m2m_books_genres].[g_id]) AS [genres_count] 
--		FROM [authors] 
--		JOIN [m2m_books_authors] ON [authors].[a_id] = [m2m_books_authors].[a_id] 
--		JOIN [m2m_books_genres] ON [m2m_books_authors].[b_id] = [m2m_books_genres].[b_id] 
--		GROUP BY [authors].[a_id], [a_name], [m2m_books_authors].[b_id] 
--		HAVING COUNT([m2m_books_genres].[g_id]) > 1
--		)  
--SELECT [a_id], 
--		[a_name], 
--		MAX([genres_count]) AS [genres_count] 
--FROM [aaa]		 
--GROUP BY [a_id], [a_name]--with [aaa]--as--(SELECT DISTINCT [m2m_books_authors].[a_id],
-- [m2m_books_genres].[g_id]
-- FROM [m2m_books_genres]
-- JOIN [m2m_books_authors]
-- ON [m2m_books_genres].[b_id] = [m2m_books_authors].[b_id])-- SELECT [aaa].[a_id],
-- [a_name],
-- COUNT([g_id]) AS [genres_count]
--FROM [aaa]
-- JOIN [authors]
-- ON [aaa].[a_id] = [authors].[a_id]
--GROUP BY [aaa].[a_id],
-- [a_name]
--HAVING COUNT([g_id]) > 1

--with [aaa]
--	AS 
--		(SELECT [subscribers].[s_id], [subscribers].[s_name], COUNT([m2m_books_genres].[g_id]) AS [genres_count] 
--		FROM [subscribers] 
--		JOIN [subscriptions] ON [subscribers].[s_id] = [subscriptions].[sb_subscriber] 
--		JOIN [m2m_books_genres] ON [subscriptions].[sb_book] = [m2m_books_genres].[b_id] 
--		GROUP BY [subscribers].[s_id], [subscribers].[s_name], [subscriptions].[sb_book]
--		HAVING COUNT([m2m_books_genres].[g_id]) > 1
--		)  
--SELECT [s_id], 
--		[s_name], 
--		MAX([genres_count]) AS [genres_count] 
--FROM [aaa]		 
--GROUP BY [s_id], [s_name]


--with prep
--as (
--    select sb_subscriber, s_name, count(g_id) as count_g
--    from (
--            select sb_subscriber, s_name, g_id
--            from subscriptions
--            join subscribers on subscriptions.sb_subscriber = subscribers.s_id
--            join m2m_books_genres on subscriptions.sb_book = m2m_books_genres.b_id
--            group by sb_subscriber, s_name, g_id) a
--    group by sb_subscriber, s_name
--    )
--select s_name
--from prep
--where count_g = (select max(count_g)
--                   from prep)

--SELECT [s_name]
--FROM [subscribers]
--WHERE [s_id] = (SELECT [sb_subscriber]
-- FROM [subscriptions]
--WHERE [sb_id] = (SELECT max([sb_id])
-- FROM [subscriptions]))-- WITH [prepared_data]
-- AS (SELECT DISTINCT [s_id],
-- [s_name],
--DATEDIFF(day, [sb_start], [sb_finish]) AS [days]
-- FROM [subscribers]
-- JOIN [subscriptions]
-- ON [s_id] = [sb_subscriber]
-- WHERE [sb_is_active] = 'y')
--SELECT [s_id],
-- [s_name],
-- [days]
--FROM [prepared_data]
--WHERE [days] = (SELECT max([days])
-- FROM [prepared_data]) -- WITH [step_1]
-- AS (SELECT [sb_subscriber],
-- max([sb_start]) AS [max_date]
-- FROM [subscriptions]
-- GROUP BY [sb_subscriber]),
-- [step_2]
-- AS (SELECT [subscriptions].[sb_subscriber],
-- [subscriptions].[sb_book]
-- FROM [subscriptions]
-- JOIN [step_1]
-- ON [subscriptions].[sb_subscriber] =
-- [step_1].[sb_subscriber]
-- AND [subscriptions].[sb_start] = [step_1].[max_date]),
-- [step_3]
-- AS (SELECT [s_id],
-- [s_name],
-- [b_name]
-- FROM [subscribers]
-- JOIN [step_2]
-- ON [s_id] = [sb_subscriber]
-- JOIN [books]
-- ON [sb_book] = [b_id])
--SELECT [s_id],
-- [s_name],
-- STUFF
--((SELECT ', ' + [int].[b_name]
-- FROM [step_3] AS [int]
-- WHERE [ext].[s_id] = [int].[s_id]
-- ORDER BY [int].[b_name]
-- FOR xml path(''), type).value('.', 'nvarchar(max)'),
-- 1, 2, '') AS [books_list]
--FROM [step_3] AS [ext]
--GROUP BY [s_id], [s_name]--WITH [step_1]
-- AS (SELECT [sb_subscriber],
-- max([sb_start]) AS [min_sb_start]
-- FROM [subscriptions]
-- GROUP BY [sb_subscriber]),
-- [step_2]
-- AS (SELECT [subscriptions].[sb_subscriber],
-- max([sb_id]) AS [min_sb_id]
-- FROM [subscriptions]
-- JOIN [step_1]
-- ON [subscriptions].[sb_subscriber] =
-- [step_1].[sb_subscriber]
-- AND [subscriptions].[sb_start] =
-- [step_1].[min_sb_start]
-- GROUP BY [subscriptions].[sb_subscriber],
-- [min_sb_start]),
-- [step_3]
-- AS (SELECT [subscriptions].[sb_subscriber],
-- [sb_book]
-- FROM [subscriptions]
-- JOIN [step_2]
-- ON [subscriptions].[sb_id] = [step_2].[min_sb_id])
--SELECT [s_id],
-- [s_name],
-- [b_name]
--FROM [step_3]
-- JOIN [subscribers]
-- ON [sb_subscriber] = [s_id]
-- JOIN [books]
-- ON [sb_book] = [b_id]

 select s_id,s_name,sb_start
 from subscriptions
 inner join subscribers
 on s_id = sb_subscriber

 select s_id,s_name,sb_start
 from subscriptions
 right outer join subscribers
 on s_id = sb_subscriber

 select s_id,s_name,sb_start
 from subscriptions
 full outer join subscribers
 on s_id = sb_subscriber
 where s_id is null or sb_subscriber is null

 select b_id,b_name
 from books
 left outer join subscriptions
 on b_id = sb_book
 where sb_book is null

 select b_name,b_year
 from books
  where b_year < 2010

  select s_id,s_name,sb_start
 from subscriptions
 full outer join subscribers
 on s_id = sb_subscriber
 where s_id is null or sb_subscriber is null

 select s_id,s_name,sb_start
 from subscriptions
 right outer join subscribers
 on s_id = sb_subscriber

 select b_id,b_name
 from books

 select s_name,b_name
 from books,subscribers
 except select s_name,b_name
 from subscribers
 join subscriptions
 on s_id = sb_subscriber
 join books
 on sb_book = b_id

  select s_name,b_name
 from books,subscribers
 except select s_name,b_name
 from subscribers
 join subscriptions
 on s_id = sb_subscriber
 join books
 on sb_book = b_id
  where b_year < 2010

  select s_id,s_name,sb_start
 from subscriptions
 full outer join subscribers
 on s_id = sb_subscriber
 where s_id is null or sb_subscriber is null

 insert into subscribers values
 ('Орлов О.О.'),
 ('Соколов С.С.'),
 ('«Беркутов Б.Б.')
 
 insert into subscriptions values
 (5,6,'2012-01-20','2012-02-20','n'),
 (6,6,'2012-01-20','2012-02-20','n'),
 (7,6,'2012-01-20','2012-02-20','n')

 insert into authors values
 ('М.Горький'),
 ('Ф.М.Достоевский'),
 ('И.С.Тургенев'),
 ('А.А.Блок'),
 ('Н.В.Гоголь')

  insert into books values
 ('На дне',1929,2),
 ('Старуха Изергиль',1912,4),
 ('Идиот',1921,2),
 ('Белые ночи',1932,1),
 ('Андрей Колосов',1923,8),
 ('Ася',1931,1),
 ('Балаганчик',1913,5),
 ('«Бегут неверные дневные тени...»',1941,2),
 ('Мертвые души',1941,7),
 ('Ревизор',1911,4)

 insert into m2m_books_authors values
(8,8),
(9,8),
(10,9),
(11,9),
(12,10),
(13,10),
(14,11),
(15,11),
(16,12),
(17,12)

insert into m2m_books_genres values
(8,5),
(9,5),
(10,5),
(11,5),
(12,5),
(13,5),
(14,5),
(15,5),
(16,5),
(17,5)