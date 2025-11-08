--Task 1


INSERT INTO Author(name) 
VALUES 
('Bob'),
('Michael Jackson'),
('Chris Isaak'),
('Olivia Rodrigo');


INSERT INTO Genres(name) 
VALUES 
('Pop'),
('Rock'),
('Electro');


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
(4, 3);


INSERT INTO album(name, released_date)
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
('I am a Fire', '01.01.2020');


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
(4,13);



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
('I am a Fire', 222, 13);



INSERT INTO Collection(name, released_date)
VALUES 
('Final_Word', '01.02.2018'),
('New_Era', '01.02.2000'),
('Mixing_Lifes', '01.02.2010'),
('This_is_1/4', '01.02.2025');


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
(20, 4);

