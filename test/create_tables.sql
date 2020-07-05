create table animelistgenresraw(
	workId int not null,
	engName varchar(127),
	synonymsName varchar(255) character set utf8 collate utf8_general_ci 		not null,
	jpName varchar(255) character set utf8 collate utf8_general_ci not null,
	episodes int not null,
	genres varchar(255) not null,
	primary key(workId)
);

create table animereviewsorderbyduration(
	id int not null,
        workId int not null,
	reviewId int not null,
	workName varchar(255),
	postduration varchar(255),
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

create table animelistraw(
        workId int not null,
	engName varchar(127),
	sName varchar(255),
	jpName varchar(255) character set utf8 collate utf8_general_ci not null,
	synonymsName varchar(255) character set utf8 collate utf8_general_ci 		not null,
	imageurl varchar(1023),
	animetype varchar(127),
	source varchar(127),
	episodes int not null,
	astatus varchar(127),
	airing varchar(63),
	airedstring varchar(511),
	aired varchar(511),
	duration varchar(255),
	primary key(workId)
);

load data local infile './animeListGenres.csv'
into table animelistgenresraw
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

load data local infile './animeReviewsOrderByduration.csv'
into table animereviewsorderbyduration
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

load data local infile './AnimeList.csv'
into table animelistraw
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

create table animelistgenres(
	workId int not null,
	genres varchar(255) not null,
	primary key(workId)
);

insert into animelistgenres(workId, genres)
select workId, replace(genres, ' ', '')
from animelistgenresraw;

create table animename(
	workId int not null,
	engName varchar(127),
	jpName varchar(255) character set utf8 collate utf8_general_ci not null,
	primary key(workId)
);

insert into animename(workId, engName, jpName)
select workId, engName, jpName
from animelistgenresraw;

create table animerating(
	workId int not null,
	rating int not null,
	primary key(workId)
);

insert into animerating(workId, rating)
select al.workId, ifnull(ar.rating, 0) 
from animelistgenres as al left join (
	select workId, round(avg(overallRating + 
		      storyRating + 
                      animationRating +
		      soundRating +
		      characterRating +
		      enjoymentRating)/6) as rating
	from animereviewsorderbyduration 
	group by workId) as ar 
     on al.workId = ar.workId;

create table animelist(
	workId int not null,
	jpName varchar(255) character set utf8 collate utf8_general_ci not null,
	engName varchar(127),
	animetype varchar(127),
	source varchar(255),
	episodes int,
	duration int,
	startyear int,
	good int,
	bad int,
	primary key(workId)
);

insert into animelist(workId, jpName, engName, animetype, source, episodes, duration, startyear, good, bad)
select aml.workId, aml.jpName, aml.engName, aml.animetype, aml.source, aml.episodes, 
       convert(temp3.duration, unsigned), 
       convert(temp4.startyear, unsigned), 0, 0
from(select temp2.workId as workId, substring_index(temp2.duration, ' ', 1) * 60 + 
	substring_index(temp2.duration, ' ', -1) as duration
     from(select temp5.workId as workId, if(temp5.duration like '%per', 
                    replace(temp5.duration, ' per', ''),
                    temp5.duration) as duration
          from(select temp1.workId as workId, if(temp1.duration like '%min.%', 
                    concat('0 ', replace(temp1.duration, ' min.', '')),
                    temp1.duration) as duration
               from(select workId, replace(substring_index(duration, ' ', 3), 
                      ' hr. ', ' ')as duration
                    from animelistraw
                    where episodes != 0 and duration like '%min.%')
                    as temp1)
               as temp5)
           as temp2)
     as temp3, 
     (select workId, if(split(airedstring, ' ', 3) REGEXP '^-?[0-9]+$',
          split(airedstring, ' ', 3), '0') as startyear
      from animelistraw)as temp4, animelistraw as aml
where aml.episodes != 0 and temp3.workId = aml.workId and
      temp4.workId = temp3.workId;

create table visitedip(
	ip varchar(255),
	id int,
	good int,
	bad int
);