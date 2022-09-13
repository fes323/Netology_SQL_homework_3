select name from album
where release_date >= '2018-01-01'
and release_date <= '2018-12-31';

select name, duration from track
where duration =(select MAX(duration) from track);

select name, duration from track
where duration >= 210;

select name from collection
where release_date between '2018-01-01' and '2020-12-31';

select nickname from author
where nickname not like '% %';

select name from track
where position('Мой' in name) = 1
or position('My' in name) = 1;

--1) количество исполнителей в каждом жанре;
select genre_id as Жанр, count(*) as Колличество_песен from author_genre
group by genre_id 
order by count(*) desc;

--2) количество треков, вошедших в альбомы 2019-2020 годов;
select count(*) as колличество_треков_в_диапазоне from track inner join album
on track.album_id = album.id
where album.release_date between '2019-01-01' and '2020-01-01';

--3) средняя продолжительность треков по каждому альбому;
select album_id, AVG(track.duration) as AVG_Duration from track
group by track.album_id;

--4) все исполнители, которые не выпустили альбомы в 2020 году. Методом проб и ошибок решил, ибо документации нормальной на эту тему нет! Имею ввиду с корректными примераим.
select author.nickname from author 
inner join album_author on author.id = album_author.author_id
inner join album on album.id = album_author.album_id
where extract ( year from album.release_date ) != 2020;


--5) названия сборников, в которых присутствует конкретный исполнитель (выберите сами);
select collection."name" from collection
inner join track on collection.id = track.id
inner join album on track.album_id = album.id
inner join author on album.id = author.id
where author.nickname like 'Markul';

--6) название альбомов, в которых присутствуют исполнители более 1 жанра;
select album."name" from album
inner join album_author on album.id = album_author.album_id
inner join author_genre on album_author.author_id = author_genre.author_id
group by album."name"
having count(author_genre.genre_id) > 1;

--7) наименование треков, которые не входят в сборники;
select track."name" from track
left join collection_track on track.id = collection_track.track_id
where collection_track.collection_id is null;

--8) исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько);
select author.nickname from author
inner join album_author on author.id = album_author.author_id
inner join track on album_author.album_id = track.album_id
where track.duration  <= (
	select min(track.duration) from track
	);

--9) название альбомов, содержащих наименьшее количество треков.
select album."name" from album
join track on track.album_id = album.id
group by album."name"
having count(track.id) <= (
	select count(track.id) from album
	join track on album.id = track.album_id
	group by album."name"
	order by count(track.id)
	limit 1
);



