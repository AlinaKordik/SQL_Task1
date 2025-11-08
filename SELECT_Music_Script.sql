
--Task 2

--1
SELECT name, duration as duration
FROM track
WHERE duration = (SELECT MAX(duration) FROM track)

--2
SELECT name, duration
FROM track 
WHERE duration >= 210

--3
SELECT name
FROM collection  
WHERE released_date BETWEEN '2018.01.01 00:00:00' AND '2020.12.31 23:59:59'

--4
SELECT name
FROM author  
WHERE name NOT LIKE '% %'

--5
SELECT name
FROM track
WHERE (SELECT string_to_array(LOWER("name"), (' ')) && ARRAY['my'])


--Task 3

--1
SELECT genre_id, COUNT(author_id) FROM genresauthor
GROUP BY genre_id 

--2
SELECT COUNT(T."name") count_tracks
FROM album a INNER JOIN track t  
ON a.id = t.id 
WHERE a.released_date BETWEEN '2019.01.01 00:00:00' AND '2020.12.31 23:59:59'

--3
SELECT a."name" , AVG(t.duration) avg_tracks
FROM album a INNER JOIN track t  
ON a.id = t.id
GROUP BY a."name" 

--4
SELECT a2."name"
FROM album a INNER JOIN author a2 
ON a.id = a2.id 
WHERE a2."name" NOT IN (  
	SELECT a2."name"
	FROM album a INNER JOIN author a2 
	ON a.id = a2.id 
	WHERE a.released_date BETWEEN '2020-01-01 00:00:00' AND '2020-12-31 23:59:59'
);


--5
SELECT c."name"  
FROM collection c INNER JOIN trackcollection t    
ON c.id  = t.collection_id 
INNER JOIN track t2  
ON track_id = t2.id 
INNER JOIN authoralbum a3
ON t2.album_id  = a3.album_id
INNER JOIN author a 
ON a.id = a3.author_id 
WHERE a."name" LIKE 'Bob' 


--Task 4

--1 Названия альбомов, в которых присутствуют исполнители более чем одного жанра.
SELECT a."name"
FROM album a INNER JOIN authoralbum a2 
ON a.id = a2.album_id
INNER JOIN genresauthor g 
ON a2.author_id = g.author_id
INNER JOIN author a3 
on g.author_id = a3.id
GROUP BY a."name" 
HAVING count(g.author_id) > 1

--2 Наименования треков, которые не входят в сборники.
SELECT t."name"  
FROM track t LEFT JOIN trackcollection t2
ON t.id = t2.track_id
WHERE t2.collection_id IS NULL 


--3 Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько.
SELECT a."name" 
FROM author a INNER JOIN authoralbum a2 
ON a2.author_id = a.id 
INNER JOIN track t 
ON a2.album_id = t.album_id 
WHERE t.duration = (SELECT MIN(duration) FROM track)


--4 Названия альбомов, содержащих наименьшее количество треков.
SELECT a."name"  album_name, COUNT(t.id) AS counted
FROM album a INNER JOIN track t 
ON a.id = t.album_id
GROUP BY a.id 
HAVING COUNT(t.id) IN (
	SELECT COUNT(t.id) 
	FROM album a INNER JOIN track t 
	ON a.id = t.album_id
	GROUP BY a.id  
	ORDER BY 1
	LIMIT 1
);
