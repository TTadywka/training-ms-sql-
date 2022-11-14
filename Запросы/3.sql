SELECT DISTINCT [s_id],
 [s_name]
FROM [subscribers]
 JOIN [subscriptions]
 ON [s_id] = [sb_subscriber] SELECT [s_id],
 [s_name]
FROM [subscribers]
WHERE [s_id] IN (SELECT DISTINCT [sb_subscriber]
 FROM [subscriptions]) SELECT [s_id],
 [s_name]
FROM [subscribers]
 LEFT JOIN [subscriptions]
 ON [s_id] = [sb_subscriber]
WHERE [sb_subscriber] IS NULLSELECT [s_id],
 [s_name]
FROM [subscribers]
WHERE [s_id] NOT IN (SELECT DISTINCT [sb_subscriber]
 FROM [subscriptions]) SELECT DISTINCT [b_id],
 [b_name]
FROM [books]
 left JOIN [subscriptions]
 ON [b_id] = [sb_book]
 where sb_book is null

 SELECT [s_id],
 [s_name]
FROM [subscribers]
 LEFT OUTER JOIN [subscriptions]
 ON [s_id] = [sb_subscriber]
GROUP BY [s_id],
 [s_name]
HAVING COUNT(CASE
 WHEN [sb_is_active] = 'Y' THEN [sb_is_active]
 ELSE NULL
 END) = 0

 SELECT [s_id],
 [s_name]
FROM [subscribers]
WHERE [s_id] NOT IN (SELECT DISTINCT [sb_subscriber]
 FROM [subscriptions]
WHERE [sb_is_active] = 'Y')

SELECT [b_id],
 [b_name]
FROM [books]
 LEFT JOIN [subscriptions]
 ON [b_id] = [sb_book]
GROUP BY [b_id],
 [b_name]
HAVING COUNT(CASE
 WHEN [sb_is_active] = 'Y' THEN [sb_is_active]
 ELSE NULL
 END) = 0

 SELECT [b_id],
 [b_name]
FROM [books]
WHERE [b_id] IN (SELECT DISTINCT [b_id]
 FROM [m2m_books_genres]
WHERE [g_id] IN ( 2, 5 ))
ORDER BY [b_name]

SELECT [b_id],
 [b_name]
FROM [books]
WHERE [b_id] IN (SELECT DISTINCT [b_id]
 FROM [m2m_books_genres]
WHERE [g_id] IN (SELECT [g_id]
 FROM [genres]
WHERE
 [g_name] IN ( N'Программирование',
 N'Классика' )
 ))
ORDER BY [b_name] 

SELECT DISTINCT [books].[b_id],
 [b_name]
FROM [books]
 JOIN [m2m_books_genres]
 ON [books].[b_id] = [m2m_books_genres].[b_id]
WHERE [g_id] IN ( 2, 5 )
ORDER BY [b_name] ASC

SELECT DISTINCT [books].[b_id],
 [b_name]
FROM [books]
 JOIN [m2m_books_genres]
 ON [books].[b_id] = [m2m_books_genres].[b_id]
WHERE [g_id] IN (SELECT [g_id]
 FROM [genres]
WHERE [g_name] IN ( N'Программирование',
 N'Классика' )
 )
ORDER BY [b_name] ASC

SELECT DISTINCT [books].[b_id],
 [b_name]
FROM [books]
 JOIN [m2m_books_authors]
 ON [books].[b_id] = [m2m_books_authors].[b_id]
WHERE [a_id] IN ( 3, 6 )
GROUP BY [books].[b_id],b_name
HAVING COUNT(a_id)>1

SELECT [books].[b_id],
 [books].[b_name],
 COUNT([m2m_books_authors].[a_id]) AS [authors_count]
FROM [books]
 JOIN [m2m_books_authors]
 ON [books].[b_id] = [m2m_books_authors].[b_id]
GROUP BY [books].[b_id],
 [books].[b_name]
HAVING COUNT([m2m_books_authors].[a_id]) > 1

WITH [books_taken]
 AS (SELECT [sb_book] AS [b_id],
 COUNT([sb_book]) AS [taken]
 FROM [subscriptions]
 WHERE [sb_is_active] = 'Y'
 GROUP BY [sb_book])
SELECT * FROM [books_taken]SELECT DISTINCT a_name
FROM authors
 JOIN [m2m_books_authors]
 ON [authors].[a_id] = [m2m_books_authors].[a_id]
GROUP BY a_name
HAVING COUNT(b_id)>1

SELECT DISTINCT b_name
FROM books
 JOIN [m2m_books_genres]
 ON [books].[b_id] = [m2m_books_genres].[b_id]
GROUP BY b_name
HAVING COUNT(g_id)>1

SELECT [s_id],
 [s_name]
FROM [subscribers]
 LEFT OUTER JOIN [subscriptions]
 ON [s_id] = [sb_subscriber]
GROUP BY [s_id],
 [s_name]
HAVING COUNT(CASE
 WHEN [sb_is_active] = 'Y' THEN [sb_is_active]
 ELSE NULL
 END) = 0 and COUNT(sb_book) >1

WITH [books_taken]
 AS (SELECT [sb_book] AS [b_id],
 b_name,
 COUNT([sb_book]) AS [taken]
 FROM [subscriptions]
 join [books]
 on b_id = sb_book
 WHERE [sb_is_active] = 'n'
 GROUP BY [sb_book],[b_name])
SELECT * FROM [books_taken]

SELECT a_name, count(b_quantity) as b_quantity
FROM books
 JOIN [m2m_books_authors]
 ON [books].[b_id] = [m2m_books_authors].[b_id]
 join [authors]
 on m2m_books_authors.a_id=[authors].[a_id]
 GROUP by a_name
 
 select s_name , COUNT(sb_is_active) as ne_vernul
 from subscribers
 join subscriptions
 on subscribers.s_id = subscriptions.sb_subscriber
 group by  s_name,sb_is_active
 having sb_is_active = 'n'

 SELECT [authors].[a_id],
 [authors].[a_name],
 COUNT([sb_book]) AS [books]
FROM [authors]
 JOIN [m2m_books_authors]
 ON [authors].[a_id] = [m2m_books_authors].[a_id]
 LEFT OUTER JOIN [subscriptions]
 ON [m2m_books_authors].[b_id] = [sb_book]
GROUP BY [authors].[a_id],
 [authors].[a_name]
ORDER BY COUNT([sb_book]) DESC

WITH [prepared_data]
 AS (SELECT [authors].[a_id],
 [authors].[a_name],
 COUNT([sb_book]) AS [books]
 FROM [authors]
 JOIN [m2m_books_authors]
 ON [authors].[a_id] = [m2m_books_authors].[a_id]
 LEFT OUTER JOIN [subscriptions]
 ON [m2m_books_authors].[b_id] = [sb_book]
 GROUP BY [authors].[a_id],
 [authors].[a_name])
SELECT [a_id],
 [a_name],
 [books]
FROM [prepared_data]
WHERE [books] = (SELECT MAX([books])
 FROM [prepared_data])

 SELECT AVG(CAST([books] AS FLOAT)) AS [avg_reading]
FROM (SELECT COUNT([sb_book]) AS [books]
 FROM [authors]
 JOIN [m2m_books_authors]
 ON [authors].[a_id] = [m2m_books_authors].[a_id]
 LEFT OUTER JOIN [subscriptions]
 ON [m2m_books_authors].[b_id] = [sb_book]
 GROUP BY [authors].[a_id]) AS [prepared_data]

 WITH [popularity]
 AS (SELECT COUNT([sb_book]) AS [books]
 FROM [authors]
 JOIN [m2m_books_authors]
 ON [authors].[a_id] = [m2m_books_authors].[a_id]
 LEFT OUTER JOIN [subscriptions]
 ON [m2m_books_authors].[b_id] = [sb_book]
 GROUP BY [authors].[a_id]),
 [meadian_preparation]
 AS (SELECT CAST([books] AS FLOAT) AS [books],
 ROW_NUMBER()
 OVER (
 ORDER BY [books]) AS [RowNumber],
 COUNT(*)
 OVER (
 PARTITION BY NULL) AS [RowCount]
 FROM [popularity])
SELECT AVG([books]) AS [med_reading]
FROM [meadian_preparation]
WHERE [RowNumber] IN ( ( [RowCount] + 1 ) / 2, ( [RowCount] + 2 ) / 2 )WITH [books_taken]
 AS (SELECT [sb_book],
 COUNT([sb_book]) AS [taken]
 FROM [subscriptions]
 WHERE [sb_is_active] = 'Y'
 GROUP BY [sb_book])
SELECT TOP 1 CASE
 WHEN EXISTS (SELECT TOP 1 [b_id]
 FROM [books]
 LEFT OUTER JOIN [books_taken]
 ON [b_id] = [sb_book]
 WHERE ([b_quantity] - ISNULL([taken], 0)) < 0)
 THEN 1
 ELSE 0
 END AS [error_exists]
FROM [books_taken]with [aaa]as(select [g_name],count(sb_book) as [sb_bookk]from genresjoin m2m_books_genreson genres.g_id = m2m_books_genres.g_idjoin subscriptionson m2m_books_genres.b_id = subscriptions.sb_bookGROUP BY g_name)select [g_name],[sb_bookk]from [aaa]where [sb_bookk] = (SELECT max(sb_bookk) from [aaa])select g_name,avg(sb_book) as 'средняя читаемость'
from genres
join m2m_books_genres
on genres.g_id = m2m_books_genres.g_id
join subscriptions
on m2m_books_genres.b_id = subscriptions.sb_book
GROUP BY g_name
SELECT AVG(CAST([books] AS FLOAT)) AS [avg_reading]
FROM (SELECT COUNT([sb_book]) AS [books]
 FROM [genres]
 JOIN [m2m_books_genres]
 ON [genres].[g_id] = [m2m_books_genres].[g_id]
 LEFT OUTER JOIN [subscriptions]
 ON [m2m_books_genres].[b_id] = [sb_book]
 GROUP BY [genres].[g_id]) AS [prepared_data]

 WITH [popularity]
 AS (SELECT COUNT([sb_book]) AS [books]
 FROM [genres]
 JOIN [m2m_books_genres]
 ON [genres].[g_id] = [m2m_books_genres].[g_id]
 LEFT OUTER JOIN [subscriptions]
 ON [m2m_books_genres].[b_id] = [sb_book]
 GROUP BY [genres].[g_id]),
 [meadian_preparation]
 AS (SELECT CAST([books] AS FLOAT) AS [books],
 ROW_NUMBER()
 OVER (
 ORDER BY [books]) AS [RowNumber],
 COUNT(*)
 OVER (
 PARTITION BY NULL) AS [RowCount]
 FROM [popularity])
SELECT AVG([books]) AS [med_reading]
FROM [meadian_preparation]
WHERE [RowNumber] IN ( ( [RowCount] + 1 ) / 2, ( [RowCount] + 2 ) / 2 )