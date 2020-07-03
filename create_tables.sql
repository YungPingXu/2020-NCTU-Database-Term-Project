create table animeListGenresRaw(
	workId int not null,
	engName varchar(127),
	synonymsName varchar(255) character set utf8 collate utf8_general_ci 		not null,
	jpName varchar(255) character set utf8 collate utf8_general_ci not null,
	episodes int not null,
	genres varchar(255) not null,
	primary key(workId)
);

create table animeReviewsOrderByTime(
	id int not null,
        workId int not null,
	reviewId int not null,
	workName varchar(255),
	postTime varchar(255),
	episodesSeen varchar(255),
	author varchar(127),
	peopleFoundUseful int not null,
	overallRating int not null,
	storyRating int not null,
	animationRating int not null,
	soundRating int not null,
	characterRating int not null,
	enjoymentRating int not null,
	primary key(workId)
);

create table AnimeList(
        workId int not null,
	engName varchar(127),
	Name varchar(255),
	jpName varchar(255) character set utf8 collate utf8_general_ci not null,
	synonymsName varchar(255) character set utf8 collate utf8_general_ci 		not null,
	imageurl varchar(1023),
	type varchar(127),
	source varchar(127),
	episodes int not null,
	status varchar(127),
	airing varchar(63),
	airedstring varchar(511),
	aired varchar(511),
	duration varchar(255),
	primary key(workId)
);

load data local infile './animeListGenres.csv'
into table animeListGenresRaw
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

load data local infile './animeReviewsOrderByTime.csv'
into table animeReviewsOrderByTime
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

load data local infile './AnimeList.csv'
into table AnimeList
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

create table animeListGenres(
	workId int not null,
	genres varchar(255) not null,
	primary key(workId)
);

insert into animeListGenres(workId, genres)
select workId, genres
from animeListGenresRaw;

create table animename(
	workId int not null,
	engName varchar(127),
	jpName varchar(255) character set utf8 collate utf8_general_ci not null,
	primary key(workId)
);

insert into animename(workId, engName, jpName)
select workId, engName, jpName
from animeListGenresRaw;

create table animeRating(
	workId int not null,
	rating int not null,
	primary key(workId)
);

insert into animeRating(workId, rating)
select al.workId, ifnull(ar.rating, 0) 
from animeListGenres as al left join (
	select workId, round(avg(overallRating + 
		      storyRating + 
                      animationRating +
		      soundRating +
		      characterRating +
		      enjoymentRating)/6) as rating
	from animeReviewsOrderByTime 
	group by workId) as ar 
     on al.workId = ar.workId;

create table animelist(
	workId int not null,
	type varchar(127),
	source varchar(255),
	episodes int,
	duration int,
	year int,
	primary key(workId)
);

insert into animelist(workId, type, source, episodes, duration, year)
select aml.workId,aml.type, aml.source, aml.episodes, 
       convert(temp3.duration, unsigned), 
       convert(if(temp4.year = '0', '1917', temp4.year), unsigned)
from(select temp2.workId as workId, substring_index(temp2.time, ' ', 2) * 60 + 
	substring_index(temp2.time, ' ', -1) as duration
     from(select temp5.workId as workId, if(temp5.duration like '%per', 
                    replace(temp5.duration, ' per', ''),
                    temp5.duration) as time
          from(select temp1.workId as workId, if(temp1.duration like '%min.%', 
                    concat('0 ', replace(temp1.duration, ' min.', '')),
                    temp1.duration) as duration
               from(select workId, replace(substring_index(duration, ' ', 3), 
                      ' hr. ', ' ')as duration
                    from AnimeList
                    where episodes != 0 and duration like '%min.%')
                    as temp1)
               as temp5)
           as temp2)
     as temp3, 
     (select workId, if(split(airedstring, ' ', 3) REGEXP '^-?[0-9]+$',
          split(airedstring, ' ', 3), '0') as year
      from AnimeList)as temp4, AnimeList as aml
where aml.episodes != 0 and temp3.workId = aml.workId and
      temp4.workId = temp3.workId;
