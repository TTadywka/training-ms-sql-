--UPDATE [subscriptions] 
--SET [sb_is_active] = 'N' 
--WHERE [sb_id] <= 50

--UPDATE [subscriptions] 
--SET [sb_start] = DATEADD(day, -3, [sb_start]) 
--WHERE [sb_start] < CONVERT(date, '2012-01-01')

--UPDATE [subscriptions] 
--SET [sb_is_active] = 'y' 
--WHERE sb_subscriber = 2

--UPDATE [subscriptions] 
--SET [sb_is_active] = 'y' 
--WHERE sb_subscriber = 2

--DELETE FROM [subscriptions] 
--WHERE [sb_book] = 1

--delete from books
--where b_id in (select b_id 
-- from m2m_books_genres
-- where g_id = 5)

-- delete from subscriptions
--where day([sb_start]) between 21 and 31

--MERGE INTO [genres] 
--USING ( VALUES (N'Политика'), (N'Психология'), (N'История') ) AS [new_genres]([g_name]) 
--ON [genres].[g_name] = [new_genres].[g_name] 
--WHEN NOT MATCHED BY TARGET THEN 
--INSERT ([g_name]) 
--VALUES ([new_genres].[g_name]);

--SET IDENTITY_INSERT [subscribers] ON;
--MERGE [UP_ ip320_IvanovArtem].[dbo].[subscribers] AS [destination]
--USING [UP_ ip320_IvanovArtem_b].[dbo].[subscribers] AS [source]
--ON [destination].[s_id] = [source].[s_id]
--WHEN MATCHED THEN
-- UPDATE SET [destination].[s_name] =
-- CONCAT([destination].[s_name], N' [OLD]')
--WHEN NOT MATCHED THEN
-- INSERT ([s_id],
-- [s_name])
-- VALUES ([source].[s_id],
-- [source].[s_name]); 
--SET IDENTITY_INSERT [subscribers] OFF;--INSERT INTO [subscribers]
-- (
-- [s_name]
-- )
-- VALUES
-- (
-- 'Сидоров С.С.',
-- CASE
-- WHEN s_name < CONVERT(date, '2015-07-20')
-- THEN (SELECT N'N')
-- ELSE (SELECT N'Y')
-- END
-- ),
-- (
-- 4,
-- 3,
-- CONVERT(date, '2015-02-01'),
-- CONVERT(date, '2015-07-20'),
-- CASE
-- WHEN CONVERT(date, GETDATE()) < CONVERT(date, '2015-07-20')
-- THEN (SELECT N'N')
-- ELSE (SELECT N'Y')
-- END
-- ) WITH [prepared_data]
 AS (SELECT [authors].[a_id], COUNT([b_id]) AS [x]
 FROM [authors]
 JOIN [m2m_books_authors]
 on [authors].[a_id] = m2m_books_authors.a_id
 group by [authors].[a_id])
UPDATE [authors]
SET [authors].[a_name] =
 (CASE
 WHEN [x] > 3
 THEN (SELECT [authors].[a_name] + '[+]' )
 ELSE (SELECT [authors].[a_name] + '[-]')
 END)
FROM [authors]
JOIN [prepared_data]
 ON [authors].[a_id] = [prepared_data].[a_id] with [prepared_data]
as (
		SELECT DISTINCT [m2m_books_authors].[a_id], [m2m_books_genres].[g_id] 
		FROM [m2m_books_genres] 
		JOIN [m2m_books_authors] ON [m2m_books_genres].[b_id] = [m2m_books_authors].[b_id]
	)
SELECT [prepared_data].[a_id], [a_name], 
		COUNT([g_id]) AS [genres_count] 
FROM  [prepared_data]  
JOIN [authors] ON [prepared_data].[a_id] = [authors].[a_id] 
GROUP BY [prepared_data].[a_id], [a_name] 
HAVING COUNT([g_id]) > 1

create view count_sub_plus_book
as
select s_name, count(sb_book) as count_sb_b 
from subscribers
join subscriptions on subscribers.s_id = subscriptions.sb_subscriber
where sb_is_active = 'Y'
group by s_name, subscribers.s_id
having subscribers.s_id in (select sb_subscriber 
from subscriptions  
where sb_is_active = 'Y' 
and CONVERT(date, GETDATE()) > CONVERT(date, sb_finish))