create table if not exists Genre (
	ID SERIAL primary key,
	name VARCHAR(60) not NULL
);

create table if not exists Author (
	ID SERIAL primary key,
	nickname VARCHAR(60) not NULL
);

create table if not exists Author_genre (
	ID SERIAL primary key,
	genre_id INTEGER not NULL references Genre(ID),
	author_id INTEGER not null references Author(ID)
);

create table if not exists Album (
	ID SERIAL primary key,
	name VARCHAR(60) not null,
	release_date DATE not null
);

create table if not exists Album_author (
	ID SERIAL primary key,
	author_id INTEGER not NULL references Author(ID),
	album_id INTEGER not NULL references Album(ID)
);

create table if not exists Track (
	ID SERIAL primary key,
	name VARCHAR(60) not null,
	duration INTEGER not NULL,
	album_id INTEGER not NULL references Album(ID)
);

create table if not exists Collection (
	ID SERIAL primary key,
	name VARCHAR(60) not null,
	release_date DATE not null,
	track_id INTEGER not null references Track(ID)
);

create table if not exists Collection_track (
	ID SERIAL primary key,
	track_id INTEGER references Track(ID),
	collection_id INTEGER not NULL references Collection(ID)
);

