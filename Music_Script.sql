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
	released_date date CHECK (1920-01-01 <= released_date)
);


CREATE TABLE IF NOT EXISTS AuthorAlbum(
	author_id INTEGER REFERENCES Author(id),
	album_id INTEGER REFERENCES Album(id),
	CONSTRAINT gk PRIMARY KEY (author_id, album_id)
);


CREATE TABLE IF NOT EXISTS Track(
id SERIAL PRIMARY KEY,
name VARCHAR(60) NOT NULL,
duration INTEGER NOT NULL CHECK (duration <= 600)
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

