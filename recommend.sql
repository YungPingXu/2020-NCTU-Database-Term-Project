set names utf8;

create table animecmp (
	workId int not null,
	cmppoint int
);

insert into animecmp(workId, cmppoint)
select workId, 0
from animelistgenres;

set @n = (
	select workId
	from animelistgenres
	where engName = '要搜尋的字串'
);

create table animetemp (
	workId int not null,
	genres varchar(255) not null
);

insert into animetemp(workId, genres)
select animelist.workId, animelistgenres.genres
from animelist, animelistgenres
where animelist.type like '%%' and
	  animelist.source like '%%' and
	  animelist.episodes >= 10 and
	  animelist.duration >= 20 and
	  animelist.year >= 2000 and
	  animelist.workId = animelistgenres.workId;

update animecmp
set cmppoint = cmppoint + 1
where workId in (
	select an.workId 
	from (
		select ac.workId
		from animecmp ac, (
			select workId
			from animetemp
			where find_in_set ((
				select split(genres, ', ', 1) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres
			) != 0 or null
			or find_in_set ((
				select split(genres, ',', 1) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres) != 0 or null
		) as sa
		where ac.workId = sa.workId
	) as an
);

update animecmp
set cmppoint = cmppoint + 1
where workId in (
	select an.workId 
	from (
		select ac.workId
		from animecmp ac, (
			select workId
			from animetemp
			where find_in_set ((
				select split(genres, ', ', 2) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres
			) != 0 or null
			or find_in_set ((
				select split(genres, ',', 2) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres) != 0 or null
		) as sa
		where ac.workId = sa.workId
	) as an
);

update animecmp
set cmppoint = cmppoint + 1
where workId in (
	select an.workId 
	from (
		select ac.workId
		from animecmp ac, (
			select workId
			from animetemp
			where find_in_set ((
				select split(genres, ', ', 3) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres
			) != 0 or null
			or find_in_set ((
				select split(genres, ',', 3) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres) != 0 or null
		) as sa
		where ac.workId = sa.workId
	) as an
);

update animecmp
set cmppoint = cmppoint + 1
where workId in (
	select an.workId 
	from (
		select ac.workId
		from animecmp ac, (
			select workId
			from animetemp
			where find_in_set ((
				select split(genres, ', ', 4) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres
			) != 0 or null
			or find_in_set ((
				select split(genres, ',', 4) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres) != 0 or null
		) as sa
		where ac.workId = sa.workId
	) as an
);

update animecmp
set cmppoint = cmppoint + 1
where workId in (
	select an.workId 
	from (
		select ac.workId
		from animecmp ac, (
			select workId
			from animetemp
			where find_in_set ((
				select split(genres, ', ', 5) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres
			) != 0 or null
			or find_in_set ((
				select split(genres, ',', 5) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres) != 0 or null
		) as sa
		where ac.workId = sa.workId
	) as an
);

update animecmp
set cmppoint = cmppoint + 1
where workId in (
	select an.workId 
	from (
		select ac.workId
		from animecmp ac, (
			select workId
			from animetemp
			where find_in_set ((
				select split(genres, ', ', 6) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres
			) != 0 or null
			or find_in_set ((
				select split(genres, ',', 6) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres) != 0 or null
		) as sa
		where ac.workId = sa.workId
	) as an
);

update animecmp
set cmppoint = cmppoint + 1
where workId in (
	select an.workId 
	from (
		select ac.workId
		from animecmp ac, (
			select workId
			from animetemp
			where find_in_set ((
				select split(genres, ', ', 7) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres
			) != 0 or null
			or find_in_set ((
				select split(genres, ',', 7) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres) != 0 or null
		) as sa
		where ac.workId = sa.workId
	) as an
);

update animecmp
set cmppoint = cmppoint + 1
where workId in (
	select an.workId 
	from (
		select ac.workId
		from animecmp ac, (
			select workId
			from animetemp
			where find_in_set ((
				select split(genres, ', ', 8) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres
			) != 0 or null
			or find_in_set ((
				select split(genres, ',', 8) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres) != 0 or null
		) as sa
		where ac.workId = sa.workId
	) as an
);

update animecmp
set cmppoint = cmppoint + 1
where workId in (
	select an.workId 
	from (
		select ac.workId
		from animecmp ac, (
			select workId
			from animetemp
			where find_in_set ((
				select split(genres, ', ', 9) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres
			) != 0 or null
			or find_in_set ((
				select split(genres, ',', 9) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres) != 0 or null
		) as sa
		where ac.workId = sa.workId
	) as an
);

update animecmp
set cmppoint = cmppoint + 1
where workId in (
	select an.workId 
	from (
		select ac.workId
		from animecmp ac, (
			select workId
			from animetemp
			where find_in_set ((
				select split(genres, ', ', 10) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres
			) != 0 or null
			or find_in_set ((
				select split(genres, ',', 10) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres) != 0 or null
		) as sa
		where ac.workId = sa.workId
	) as an
);

update animecmp
set cmppoint = cmppoint + 1
where workId in (
	select an.workId 
	from (
		select ac.workId
		from animecmp ac, (
			select workId
			from animetemp
			where find_in_set ((
				select split(genres, ', ', 11) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres
			) != 0 or null
			or find_in_set ((
				select split(genres, ',', 11) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres) != 0 or null
		) as sa
		where ac.workId = sa.workId
	) as an
);

update animecmp
set cmppoint = cmppoint + 1
where workId in (
	select an.workId 
	from (
		select ac.workId
		from animecmp ac, (
			select workId
			from animetemp
			where find_in_set ((
				select split(genres, ', ', 12) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres
			) != 0 or null
			or find_in_set ((
				select split(genres, ',', 12) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres) != 0 or null
		) as sa
		where ac.workId = sa.workId
	) as an
);

update animecmp
set cmppoint = cmppoint + 1
where workId in (
	select an.workId 
	from (
		select ac.workId
		from animecmp ac, (
			select workId
			from animetemp
			where find_in_set ((
				select split(genres, ', ', 13) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres
			) != 0 or null
			or find_in_set ((
				select split(genres, ',', 13) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres) != 0 or null
		) as sa
		where ac.workId = sa.workId
	) as an
);

select al.jpName as jpName, al.engName as engName
from (
	select ac.workId as workId, ac.cmppoint * 3 + ar.rating as point
	from animecmp as ac inner join animeRating as ar
	on ac.workId = ar.workId
	order by point desc
	limit 50
) as fac, animename as al
where fac.workId = al.workId;

drop table animecmp;
drop table animetemp;