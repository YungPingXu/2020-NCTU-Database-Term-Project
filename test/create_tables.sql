create table animeListGenres(
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

load data local infile './animeListGenres.csv'
into table animeListGenres
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
		      enjoymentRating)) as rating
	from animeReviewsOrderByTime 
	group by workId) as ar 
     on al.workId = ar.workId;
