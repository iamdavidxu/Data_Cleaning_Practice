database
name:
bingsen_db



1.
CREATE temporary TABLE temp
(sac_id VARCHAR
(200), project VARCHAR
(200), artist_first_name VARCHAR
(500), artist_last_name VARCHAR
(500), title VARCHAR
(200), description text, classification VARCHAR
(500), media VARCHAR
(300), measurements VARCHAR
(500), date VARCHAR
(200), location VARCHAR
(200), address VARCHAR
(500), latitude FLOAT, longitude FLOAT, Geolocation VARCHAR
(300));
\copy temp
(sac_id, project, artist_first_name, artist_last_name, title, description, classification, media, measurements, date, location, address, latitude, longitude, Geolocation) FROM 'C:/Users/David Xu/Desktop/Public_Art_Data.csv'
WITH CSV HEADER ENCODING 'UTF8';
CREATE TABLE Public_Art_Data
(
	sac_id VARCHAR(200),
	project VARCHAR(200),
	artist_first_name VARCHAR(500),
	artist_last_name VARCHAR(500),
	title VARCHAR(200),
	description text,
	classification VARCHAR(500),
	media VARCHAR(300),
	measurements VARCHAR(500),
	date VARCHAR(200),
	location VARCHAR(200),
	address VARCHAR(500),
	latitude FLOAT,
	longitude FLOAT,
	Geolocation VARCHAR(300)
);
INSERT INTO Public_Art_Data
SELECT sac_id, project, artist_first_name, artist_last_name, title, description, classification, media, measurements, date, location, address, latitude, longitude, Geolocation
FROM temp;

SELECT *
FROM Public_Art_Data;

2.
--Check sac_id
SELECT sac_id, count (sac_id) as countID
FROM Public_Art_Data
GROUP by sac_id
ORDER BY countID DESC;

--Check title
SELECT title, count (title) as countTitle
FROM Public_Art_Data
GROUP by title
ORDER BY countTitle DESC;

--Check both as key
SELECT sac_id, title, count (sac_id) as countTotal
FROM Public_Art_Data
GROUP by sac_id, title
ORDER BY countTotal DESC;

3.
UPDATE Public_Art_Data
SET description = NULL
WHERE description = '''''';

4.
-- For the media, VARCHAR 200 is not enough to fit all data in so I changed it to 300
CREATE TABLE clean_seattle_public_art
(
	sac_id varchar(200),
	project varchar(200),
	title varchar(200),
	description text,
	media varchar(300),
	date varchar(200),
	location varchar(200),
	PRIMARY KEY(sac_id, title)
)

4a.
INSERT INTO clean_seattle_public_art
SELECT DISTINCT sac_id,
	project,
	title,
	description,
	media,
	date,
	location
FROM Public_Art_Data
WHERE sac_id IS NOT NULL;

5.
CREATE TABLE seattle_public_art_artist
(
	first_name varchar(100),
	last_name varchar(100),
	suffix varchar(10),
	PRIMARY KEY(first_name, last_name)
)

6.
INSERT INTO seattle_public_art_artist
	(first_name, last_name)
SELECT DISTINCT artist_first_name, artist_last_name
FROM Public_Art_Data
WHERE artist_first_name IS NOT NULL
	AND artist_last_name IS NOT NULL

7.
-- I added an extra name to modify cause it also had the same problem.(Pam, Beyette, Michael Davis, Norie Sato and Richard Turner)
DELETE FROM seattle_public_art_artist a
WHERE a.first_name = 'James Jr.'
	OR a.last_name = 'Fels, Donald; Feddersen, Joe; Quick to see Smith, Jaune'
	OR a.last_name = 'Brother and Mark Calderon'
	OR a.last_name = 'D'' Agostino, Fernanda'
	OR a.last_name = 'Beyette, Michael Davis, Norie Sato and Richard Turner';

INSERT INTO seattle_public_art_artist
	(first_name, last_name, suffix)
VALUES
	('James', 'Washington', 'Jr.'),
	('Jaune', 'Quick to see Smith', NULL),
	('Beliz', 'Calderon', NULL),
	('Fernanda', 'D''Agostino', NULL),
	('Michael', 'Davis', NULL),
	('Norie', 'Sato', NULL),
	('Richard', 'Turner', NULL);

8.
CREATE TABLE seattle_public_art_artist_work
(
	sac_id varchar(200),
	title varchar(200),
	artist_first_name varchar(100),
	artist_last_name varchar(100),
	PRIMARY KEY(sac_id, title, artist_first_name, artist_last_name)
)

INSERT INTO seattle_public_art_artist_work
SELECT DISTINCT p.sac_id, p.title, a.first_name, a.last_name
FROM seattle_public_art_artist a, Public_Art_Data p
WHERE a.first_name = p.artist_first_name
	AND a.last_name = p.artist_last_name
	AND sac_id IS NOT NULL;


9.
INSERT INTO seattle_public_art_artist_work
	(sac_id, title, artist_first_name, artist_last_name)
VALUES('ESD00.074.06', 'Coelacanths', 'James', 'Washington'),
	('PR99.043', 'Pavers', 'Donald', 'Fels'),
	('PR99.043', 'Pavers', 'Jaune', 'Quick to see Smith'),
	('PR99.043', 'Pavers', 'Joe', 'Feddersen'),
	('PR99.044', 'Bronze Imbeds', 'Donald', 'Fels'),
	('PR99.044', 'Bronze Imbeds', 'Jaune', 'Quick to see Smith'),
	('PR99.044', 'Bronze Imbeds', 'Joe', 'Feddersen'),
	('PR99.045', 'Bronze Plaques and Medallio', 'Donald', 'Fels'),
	('PR99.045', 'Bronze Plaques and Medallio', 'Jaune', 'Quick to see Smith'),
	('PR99.045', 'Bronze Plaques and Medallio', 'Joe', 'Feddersen'),
	('PR99.046', 'Viewers', 'Donald', 'Fels'),
	('PR99.046', 'Viewers', 'Jaune', 'Quick to see Smith'),
	('PR99.046', 'Viewers', 'Joe', 'Feddersen'),
	('NEA97.024', 'Water Borne', 'Mark', 'Calderon'),
	('NEA97.024', 'Water Borne', 'Beliz', 'Brother'),
	('PR97.022', 'Aureole', 'Mark', 'Calderon'),
	('PR97.022', 'Aureole', 'Beilz', 'Brother'),
	('LIB05.006', 'Into the Green Wood', 'Fernanda', 'D'' Agostino')

10.
SELECT artist_first_name, artist_last_name, count(*)
FROM seattle_public_art_artist_work w, clean_seattle_public_art art
WHERE art.sac_id = w.sac_id
	AND art.title = w.title
GROUP BY artist_first_name, artist_last_name
ORDER BY count(*) DESC;