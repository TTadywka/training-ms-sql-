SELECT [b_name], 
[a_name], 
[g_name] 
FROM [books] 
JOIN [m2m_books_authors] 
ON [books].[b_id] = [m2m_books_authors].[b_id] 
JOIN [authors] 
ON [m2m_books_authors].[a_id] = [authors].[a_id] 
JOIN [m2m_books_genres] 
ON [books].[b_id] = [m2m_books_genres].[b_id]
JOIN [genres] 
ON [m2m_books_genres].[g_id] = [genres].[g_id]

SELECT [b_name], 
[s_id], 
[s_name], 
[sb_start], 
[sb_finish] 
FROM [books] 
JOIN [subscriptions] 
ON [b_id] = [sb_book] 
JOIN [subscribers] 
ON [sb_subscriber] = [s_id] 

SELECT [b_name],
Count(a_id) as 'Кол-во авторов'
FROM [books] 
JOIN [m2m_books_authors] 
ON [books].[b_id] = [m2m_books_authors].[b_id] 
GROUP by [b_name]
Having COUNT(a_id)>1
/*не работает*/
SELECT b_name,g_name
FROM books
JOIN m2m_books_genres 
ON books.b_id = m2m_books_genres.b_id
JOIN genres
ON m2m_books_genres.g_id = genres.g_id
group by [b_name]
having count([g_id]) = 1
/*работает*/
SELECT b_name
FROM books
JOIN m2m_books_genres 
ON books.b_id = m2m_books_genres.b_id
group by [b_name]
having count([g_id]) = 1

		
	
WITH prepared_data
AS (SELECT books.[b_id], [authors].[a_id], [b_name], [a_name], [g_name] 
FROM [books] 
JOIN [m2m_books_genres] 
ON [books].[b_id] = [m2m_books_genres].[b_id] 
JOIN [genres] 
ON [m2m_books_genres].[g_id] = [genres].[g_id] 
JOIN [m2m_books_authors]
ON [books].[b_id] = [m2m_books_authors].[b_id] 
JOIN [authors] 
ON [m2m_books_authors].[a_id] = [authors].[a_id]) 
SELECT [outer].[a_name] 
AS [author], 
STUFF ((SELECT DISTINCT ', ' + [inner].[b_name] 
FROM [prepared_data] AS [inner] 
WHERE [outer].a_id = [inner].[a_id] 
ORDER BY ', ' + [inner].[b_name] 
FOR XML PATH(''), TYPE).value('.', 'nvarchar(max)'), 1, 2, '') 
AS [books], 
STUFF ((SELECT DISTINCT ', ' + [inner].[g_name] 
FROM [prepared_data] AS [inner] 
WHERE [outer].[a_id] = [inner].[a_id] 
ORDER BY ', ' + [inner].[g_name] 
FOR XML PATH(''), TYPE).value('.', 'nvarchar(max)'), 1, 2, '') 
AS [genres] 
FROM [prepared_data] AS [outer] 
GROUP BY [outer].[a_id], 
[outer].[a_name]
