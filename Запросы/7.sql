select * from authors

select * from subscribers

select * from genres

select Distinct sb_subscriber from subscriptions

select s_name,COUNT(*) as people_count 
from subscribers
GROUP BY s_name

select Distinct sb_Book from subscriptions

select sb_book, Count(*) as sb_subscriber
from subscriptions
GROUP BY sb_book

select Count(*) as total_books
from books

select Count(*) as s_id
from subscribers

select Count(sb_book) as in_use
from subscriptions
where sb_is_active = 'y'

select Count(DISTINCT sb_book) as in_use
from subscriptions
where sb_is_active = 'y'

select Count(DISTINCT sb_subscriber) as aaa
from subscriptions

select sum(b_quantity) as "sum",
	min(b_quantity) as "min",
	max(b_quantity) as "max",
	avg(cast(b_quantity as FLOAT)) as "avg"
from books

select
	min(sb_start) as "min",
	max(sb_start) as "max"
from subscriptions

select b_name,b_year FROM books
order by b_year asc

select b_name,b_year FROM books
order by b_year desc

select a_name FROM authors
order by a_name desc

select b_name,
	b_year,
	b_quantity
	FROM books
WHERE b_year BETWEEN 1990 and 2000
and b_quantity>=3

select sb_id,
	sb_start
from subscriptions
where sb_start>='2012-06-01'
	and sb_start<'2012-09-01'

select b_id,b_name,b_quantity from books
where b_quantity < 4.7

select sb_id,
	sb_start
from subscriptions
where sb_start>='2011-01-12'
	and sb_start<'2011-12-31'

SELECT TOP 1 [b_name],
 [b_quantity]
FROM [books]
ORDER BY [b_quantity] DESC

SELECT [b_name],
 [b_quantity]
FROM [books]
WHERE [b_quantity] = (SELECT MAX([b_quantity])
 FROM [books])SELECT [b_name],
 [b_quantity]
FROM [books] AS [ext]
WHERE [b_quantity] > ALL (SELECT [b_quantity]
 FROM [books] AS [int]
 WHERE [ext].[b_id] != [int].[b_id]) select TOP 1 sb_subscriber  from subscriptions order by sb_subscriber desc
select sb_subscriber
from (select sb_subscriber, count(sb_subscriber) as count_sb		
	from subscriptions			
	group by sb_subscriber) as a
where a.count_sb = (select max(count_sb) as max_count_sb
from (select sb_subscriber, count(sb_subscriber) as count_sb							
from subscriptions			
group by sb_subscriber) as b)

WITH ranked 
AS (select sb_subscriber, count(sb_subscriber) as count_sb
		from subscriptions
		group by sb_subscriber)
SELECT sb_subscriber
FROM ranked AS ext 
WHERE count_sb > ALL (SELECT count_sb
FROM ranked AS int 
WHERE ext.sb_subscriber <> int.sb_subscriber)

WITH ranked
	AS (SELECT b_id, b_name, b_quantity
		FROM books)
SELECT b_name, b_quantity 
FROM books AS ext 
WHERE b_quantity > ALL (SELECT b_quantity
			FROM ranked
			WHERE ext.b_id != ranked.b_id)

SELECT AVG(CAST([books_per_subscriber] AS FLOAT)) AS [avg_books]
FROM (SELECT COUNT([sb_book]) AS [books_per_subscriber]
 FROM [subscriptions]
 WHERE [sb_is_active] = 'Y'
 GROUP BY [sb_subscriber]) AS [count_subquery] SELECT AVG(CAST([books_per_subscriber] AS FLOAT)) AS [avg_books]
FROM (SELECT COUNT(DISTINCT [sb_book]) AS [books_per_subscriber]
 FROM [subscriptions]
 WHERE [sb_is_active] = 'Y'
 GROUP BY [sb_subscriber]) AS [count_subquery] SELECT AVG(CAST (DATEDIFF(day, [sb_start], [sb_finish]) AS FLOAT))
 AS [avg_days]
FROM [subscriptions]
WHERE [sb_is_active] = 'N'SELECT AVG(CAST([diff] AS FLOAT)) AS [avg_days]
FROM (
 SELECT DATEDIFF(day, [sb_start], [sb_finish]) AS [diff]
 FROM [subscriptions]
 WHERE ( [sb_finish] <= CONVERT(date, GETDATE())
 AND [sb_is_active] = 'N' )
 OR ( [sb_finish] > CONVERT(date, GETDATE())
 AND [sb_is_active] = 'Y' )
 UNION ALL
 SELECT DATEDIFF(day, [sb_start], CONVERT(date, GETDATE())) AS [diff]
 FROM [subscriptions]
 WHERE ( [sb_finish] <= CONVERT(date, GETDATE())
 AND [sb_is_active] = 'Y' )
 OR ( [sb_finish] > CONVERT(date, GETDATE())
 AND [sb_is_active] = 'N' )
 ) AS [diffs] SELECT AVG(b_quantity) from books

 select avg(DATEDIFF(day, sb_start, '2022-10-31')) as 'avg' from subscriptions SELECT YEAR([sb_start]) AS [year],
 COUNT([sb_id]) AS [books_taken]
FROM [subscriptions]
GROUP BY YEAR([sb_start])
ORDER BY [year]

SELECT YEAR([sb_start]) AS [year],
 COUNT(DISTINCT [sb_subscriber]) AS [subscribers]
FROM [subscriptions]
GROUP BY YEAR([sb_start])
ORDER BY [year]SELECT (CASE
 WHEN [sb_is_active] = 'Y'
 THEN 'Not returned'
 ELSE 'Returned'
 END) AS [status],
 COUNT([sb_id]) AS [books]
FROM [subscriptions]
GROUP BY (CASE
 WHEN [sb_is_active] = 'Y'
 THEN 'Not returned'
 ELSE 'Returned'
 END)
ORDER BY [status] DESCSELECT (CASE
 WHEN [sb_is_active] = 'Y'
 THEN 'Not returned'
 ELSE 'Returned'
 END) AS [status],books
FROM (select sb_is_active, Count(*) as books
from subscriptions
group by sb_is_active) as aaa