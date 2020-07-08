# generate html select tag code
with open("out", "w") as f:
    for i in range(10, 201, 10):
        print("<option value=\"" + str(i) + "\">" + str(i) + "</option>", file=f)

# generate SQL code
with open("out", "w") as f:
    for i in range(1, 14):
        print("""update animecmp
set cmppoint = cmppoint + 1
where workId in (
	select an.workId 
	from (
		select ac.workId
		from animecmp ac, (
			select workId
			from animetemp
			where find_in_set ((
				select split(genres, ', ', """ + str(i) + """) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres
			) != 0 or null
			or find_in_set ((
				select split(genres, ',', """ + str(i) + """) as genre
				from animelistgenres
				where workId = @n
				having genre != ''), genres) != 0 or null
		) as sa
		where ac.workId = sa.workId
	) as an
);
""", file=f)
