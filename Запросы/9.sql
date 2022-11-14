--insert into subscribers values
--	('Орлов О.О.'),
--	('Соколов С.С.'),
--	('«Беркутов Б.Б.')
 
--	insert into subscriptions values
--	(5,6,'2012-01-20','2012-02-20','n'),
--	(6,6,'2012-01-20','2012-02-20','n'),
--	(7,6,'2012-01-20','2012-02-20','n')

--	insert into authors values
--	('М.Горький'),
--	('Ф.М.Достоевский'),
--	('И.С.Тургенев'),
--	('А.А.Блок'),
--	('Н.В.Гоголь')

--	insert into books values
--	('На дне',1929,2),
--	('Старуха Изергиль',1912,4),
--	('Идиот',1921,2),
--	('Белые ночи',1932,1),
--	('Андрей Колосов',1923,8),
--	('Ася',1931,1),
--	('Балаганчик',1913,5),
--	('«Бегут неверные дневные тени...»',1941,2),
--	('Мертвые души',1941,7),
--	('Ревизор',1911,4)

--	insert into m2m_books_authors values
--(8,8),
--(9,8),
--(10,9),
--(11,9),
--(12,10),
--(13,10),
--(14,11),
--(15,11),
--(16,12),
--(17,12)

--insert into m2m_books_genres values
--(8,5),
--(9,5),
--(10,5),
--(11,5),
--(12,5),
--(13,5),
--(14,5),
--(15,5),
--(16,5),
--(17,5)

UPDATE [subscriptions] 
SET [sb_is_active] = 'N' 
WHERE [sb_id] <= 50

UPDATE [subscriptions] 
SET [sb_start] = DATEADD(day, -3, [sb_start]) 
WHERE [sb_start] < CONVERT(date, '2012-01-01')

UPDATE [subscriptions] 
SET [sb_is_active] = 'y' 
WHERE sb_subscriber = 2

DELETE FROM [subscriptions] 
WHERE [sb_book] = 3

delete from books
where b_id in (select b_id 
 from m2m_books_genres
 where g_id = 5)

 delete from subscriptions
where day([sb_start]) between 21 and 31

MERGE INTO [genres] 
USING ( VALUES (N'Политика'), (N'Психология'), (N'История') ) AS [new_genres]([g_name]) ON [genres].[g_name] = [new_genres].[g_name] 
WHEN NOT MATCHED BY TARGET THEN 
INSERT ([g_name]) 
VALUES ([new_genres].[g_name]);