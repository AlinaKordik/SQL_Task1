CREATE TABLE IF NOT EXISTS Author(
	id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL 
);

CREATE TABLE IF NOT EXISTS Genres(
	id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS GenresAuthor (
	author_id INTEGER REFERENCES Author(id),
	genre_id INTEGER REFERENCES Genres(id),
	CONSTRAINT pk PRIMARY KEY (author_id, genre_id)
);

CREATE TABLE IF NOT EXISTS Album(
	id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL,
	released_date date CHECK ('1920-01-01' <= released_date)
);


CREATE TABLE IF NOT EXISTS AuthorAlbum(
	author_id INTEGER REFERENCES Author(id),
	album_id INTEGER REFERENCES Album(id),
	CONSTRAINT gk PRIMARY KEY (author_id, album_id)
);


CREATE TABLE IF NOT EXISTS Track(
id SERIAL PRIMARY KEY,
name VARCHAR(60) NOT NULL,
duration INTEGER NOT NULL CHECK (duration <= 600),
album_id INTEGER NOT NULL REFERENCES Album(id)
);


CREATE TABLE IF NOT EXISTS Collection(
id SERIAL PRIMARY KEY,
name VARCHAR(40) NOT NULL,
released_date date CHECK (1920-01-01 <= released_date)
);

CREATE TABLE IF NOT EXISTS TrackCollection(
	collection_id INTEGER REFERENCES Collection(id),
	track_id INTEGER REFERENCES Track(id),
	CONSTRAINT jj PRIMARY KEY (collection_id, track_id)
);

--Task 1


INSERT INTO Author(name) 
VALUES 
('Bob'),
('Michael Jackson'),
('Chris Isaak'),
('Olivia Rodrigo')


INSERT INTO Genres(name) 
VALUES 
('Pop'),
('Rock'),
('Electro')


INSERT INTO GenresAuthor(author_id, genre_id) 
VALUES 
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 3),
(3, 1),
(3, 2),
(4, 1),
(4, 2),
(4, 3)


INSERT INTO Album(name, released_date)
VALUES
('Fridays For Future', '01.06.2020'),
('Live!', '01.06.1977'),
('Uprising', '01.06.1980'),
('Dangerous', '01.01.1991'), 
('Bad', '01.02.1986'),
('Go To Be There', '24.06.1972'),
('Always Got Tonight', '12.02.2002'),
('Beyond The Sun', '02.02.2012'),
('Forever Blue', '01.01.1993'),
('Sour', '01.01.2021'),
('Guts', '01.01.2023'),
('Guts(spilled)', '01.01.2024'), 
('I am a Fire', '01.01.2020')


INSERT INTO  AuthorAlbum(author_id, album_id)
VALUES 
(1, 1),
(1,2),
(1,3),
(2,4),
(2,5),
(2,6),
(3,7),
(3,8),
(3,9),
(4,10),
(4,11),
(4,12),
(4,13)



INSERT INTO Track(name, duration, album_id)
VALUES
('So Much My Trouble In The World', 240, 1), 
('One Love', 175, 1),
('Revolution', 264, 1),
('Them Belly Full', 263, 2),
('Lovely Up Yourself', 273, 2),
('Coming In From The Gold', 271, 3),
('Bad Card', 168, 3),
('Jam', 339, 4),
('Why You Wanna Trip On Me', 324, 4),
('Bad', 248, 5),
('Speed Demon', 248, 5),
('Go To Be There', 204, 6),
('One Day', 267, 7),
('Let Me Down Easy', 246, 7),
('Right Of Fire', 140, 8), 
('Graduation Day', 191, 9),
('Go Walking Down There', 170, 9),
('Brutal', 143, 10),
('All American Bitch', 165, 11),
('Vampire', 219, 12),
('I am a Fire', 222, 13)



INSERT INTO Collection(name, released_date)
VALUES 
('Final_Word', '01.02.2018'),
('New_Era', '01.02.2000'),
('Mixing_Lifes', '01.02.2010'),
('This_is_1/4', '01.02.2025')


INSERT INTO trackcollection(track_id, collection_id)
VALUES
(2, 1),
(4, 1),
(6, 1),
(8, 1),
(1, 2),
(3, 2),
(5, 2),
(7, 2),
(9, 3),
(11, 3),
(12, 3),
(13, 3),
(14, 3),
(15, 4),
(16, 4),
(17, 4),
(18, 4),
(19, 4),
(20, 4)

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
WHERE released_date BETWEEN '2018.01.01 00:00:00' AND '2020.12.31 00:00:00'

--4
SELECT name
FROM author  
WHERE name NOT LIKE '% %'

5
SELECT name FROM track 
WHERE name LIKE '% My %'

--Task 3

--1
SELECT genre_id, COUNT(author_id) FROM genresauthor
GROUP BY genre_id 

--2
SELECT COUNT(T."name") count_tracks
FROM album a INNER JOIN track t  
ON a.id = t.id 
WHERE a.released_date BETWEEN '2019.01.01 00:00:00' AND '2020.12.31 00:00:00'

--3
SELECT a."name" , AVG(t.duration) avg_tracks
FROM album a INNER JOIN track t  
ON a.id = t.id
GROUP BY a."name" 

--4
SELECT a2."name" author 
FROM album a INNER JOIN author a2 
ON a.id = a2.id 
WHERE a.released_date <= '2020.01.01 00:00:00'

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
SELECT a."name"  album_name, COUNT(t.album_id) as counted 
FROM album a INNER JOIN track t 
ON a.id = t.album_id
GROUP BY a."name"
HAVING COUNT(t.album_id) <= 1

