create table animeListGenres(
    workId int not null,
    engName varchar(127),
    synonymsName varchar(255) character set utf8 collate utf8_general_ci not null,
    jpName varchar(255) character set utf8 collate utf8_general_ci not null,
    episodes int not null,
    genres varchar(255) not null,
    primary key(workId, engName)
);

load data local infile 'animeListGenres.csv'
into table animeListGenres
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;