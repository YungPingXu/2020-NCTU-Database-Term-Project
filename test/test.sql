set names utf8;

create table animecmp(
	workId int not null,
	cmppoint int
);

insert into animecmp(workId, cmppoint)
select workId, 0
from animeListGenres;

set @n = (select workId
	  from animeListGenres
	  where engName = 'Fullmetal Alchemist: Brotherhood');

update animecmp
set cmppoint = cmppoint + 1
where workId in
      (select an.workId 
       from (select ac.workId
	     from animecmp ac, 
	     (select workId
	      from animeListGenres
	      where find_in_set((select split(genres, ', ', 1) as genre
				 from animeListGenres
				 where workId = @n
				 having genre != ''), genres) != 0 or null
		    or find_in_set((select split(genres, ',', 1) as genre
				    from animeListGenres
				    where workId = @n
				    having genre != ''), genres) != 0 or null
	     )as sa
	     where ac.workId = sa.workId
            )as an
      );

update animecmp
set cmppoint = cmppoint + 1
where workId in
      (select an.workId 
       from (select ac.workId
	     from animecmp ac, 
	     (select workId
	      from animeListGenres
	      where find_in_set((select split(genres, ', ', 2) as genre
				 from animeListGenres
				 where workId = @n
				 having genre != ''), genres) != 0 or null
		    or find_in_set((select split(genres, ',', 2) as genre
				    from animeListGenres
				    where workId = @n
				    having genre != ''), genres) != 0 or null
	     )as sa
	     where ac.workId = sa.workId
            )as an
      );

update animecmp
set cmppoint = cmppoint + 1
where workId in
      (select an.workId 
       from (select ac.workId
	     from animecmp ac, 
	     (select workId
	      from animeListGenres
	      where find_in_set((select split(genres, ', ', 3) as genre
				 from animeListGenres
				 where workId = @n
				 having genre != ''), genres) != 0 or null
		    or find_in_set((select split(genres, ',', 3) as genre
				    from animeListGenres
				    where workId = @n
				    having genre != ''), genres) != 0 or null
	     )as sa
	     where ac.workId = sa.workId
            )as an
      );

update animecmp
set cmppoint = cmppoint + 1
where workId in
      (select an.workId 
       from (select ac.workId
	     from animecmp ac, 
	     (select workId
	      from animeListGenres
	      where find_in_set((select split(genres, ', ', 4) as genre
				 from animeListGenres
				 where workId = @n
				 having genre != ''), genres) != 0 or null
		    or find_in_set((select split(genres, ',', 4) as genre
				    from animeListGenres
				    where workId = @n
				    having genre != ''), genres) != 0 or null
	     )as sa
	     where ac.workId = sa.workId
            )as an
      );

update animecmp
set cmppoint = cmppoint + 1
where workId in
      (select an.workId 
       from (select ac.workId
	     from animecmp ac, 
	     (select workId
	      from animeListGenres
	      where find_in_set((select split(genres, ', ', 5) as genre
				 from animeListGenres
				 where workId = @n
				 having genre != ''), genres) != 0 or null
		    or find_in_set((select split(genres, ',', 5) as genre
				    from animeListGenres
				    where workId = @n
				    having genre != ''), genres) != 0 or null
	     )as sa
	     where ac.workId = sa.workId
            )as an
      );

update animecmp
set cmppoint = cmppoint + 1
where workId in
      (select an.workId 
       from (select ac.workId
	     from animecmp ac, 
	     (select workId
	      from animeListGenres
	      where find_in_set((select split(genres, ', ', 6) as genre
				 from animeListGenres
				 where workId = @n
				 having genre != ''), genres) != 0 or null
		    or find_in_set((select split(genres, ',', 6) as genre
				    from animeListGenres
				    where workId = @n
				    having genre != ''), genres) != 0 or null
	     )as sa
	     where ac.workId = sa.workId
            )as an
      );

update animecmp
set cmppoint = cmppoint + 1
where workId in
      (select an.workId 
       from (select ac.workId
	     from animecmp ac, 
	     (select workId
	      from animeListGenres
	      where find_in_set((select split(genres, ', ', 7) as genre
				 from animeListGenres
				 where workId = @n
				 having genre != ''), genres) != 0 or null
		    or find_in_set((select split(genres, ',', 7) as genre
				    from animeListGenres
				    where workId = @n
				    having genre != ''), genres) != 0 or null
	     )as sa
	     where ac.workId = sa.workId
            )as an
      );

update animecmp
set cmppoint = cmppoint + 1
where workId in
      (select an.workId 
       from (select ac.workId
	     from animecmp ac, 
	     (select workId
	      from animeListGenres
	      where find_in_set((select split(genres, ', ', 8) as genre
				 from animeListGenres
				 where workId = @n
				 having genre != ''), genres) != 0 or null
		    or find_in_set((select split(genres, ',', 8) as genre
				    from animeListGenres
				    where workId = @n
				    having genre != ''), genres) != 0 or null
	     )as sa
	     where ac.workId = sa.workId
            )as an
      );

update animecmp
set cmppoint = cmppoint + 1
where workId in
      (select an.workId 
       from (select ac.workId
	     from animecmp ac, 
	     (select workId
	      from animeListGenres
	      where find_in_set((select split(genres, ', ', 9) as genre
				 from animeListGenres
				 where workId = @n
				 having genre != ''), genres) != 0 or null
		    or find_in_set((select split(genres, ',', 9) as genre
				    from animeListGenres
				    where workId = @n
				    having genre != ''), genres) != 0 or null
	     )as sa
	     where ac.workId = sa.workId
            )as an
      );

update animecmp
set cmppoint = cmppoint + 1
where workId in
      (select an.workId 
       from (select ac.workId
	     from animecmp ac, 
	     (select workId
	      from animeListGenres
	      where find_in_set((select split(genres, ', ', 10) as genre
				 from animeListGenres
				 where workId = @n
				 having genre != ''), genres) != 0 or null
		    or find_in_set((select split(genres, ',', 10) as genre
				    from animeListGenres
				    where workId = @n
				    having genre != ''), genres) != 0 or null
	     )as sa
	     where ac.workId = sa.workId
            )as an
      );

update animecmp
set cmppoint = cmppoint + 1
where workId in
      (select an.workId 
       from (select ac.workId
	     from animecmp ac, 
	     (select workId
	      from animeListGenres
	      where find_in_set((select split(genres, ', ', 11) as genre
				 from animeListGenres
				 where workId = @n
				 having genre != ''), genres) != 0 or null
		    or find_in_set((select split(genres, ',', 11) as genre
				    from animeListGenres
				    where workId = @n
				    having genre != ''), genres) != 0 or null
	     )as sa
	     where ac.workId = sa.workId
            )as an
      );

update animecmp
set cmppoint = cmppoint + 1
where workId in
      (select an.workId 
       from (select ac.workId
	     from animecmp ac, 
	     (select workId
	      from animeListGenres
	      where find_in_set((select split(genres, ', ', 12) as genre
				 from animeListGenres
				 where workId = @n
				 having genre != ''), genres) != 0 or null
		    or find_in_set((select split(genres, ',', 12) as genre
				    from animeListGenres
				    where workId = @n
				    having genre != ''), genres) != 0 or null
	     )as sa
	     where ac.workId = sa.workId
            )as an
      );

select al.jpName as jpName, al.engName as engName
from(select ac.workId as workId, ac.cmppoint + ar.rating as point
     from animecmp as ac inner join animeRating as ar
     on ac.workId = ar.workId
     order by point desc
     limit 10)as fac, animeListGenres as al
where fac.workId = al.workId;

drop table animecmp;

