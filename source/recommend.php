<?php
$mysqli = new mysqli("localhost", "root", "password", "finalproject");
if ($mysqli->connect_errno)
	die("無法建立資料連接: " . $mysqli->connect_error);
$animecmp = $mysqli->query("show tables like '%animecmp%';");
if ($animecmp->num_rows == 1)
	$mysqli->query("drop table animecmp;");
$mysqli->query("
	create table animecmp (
		workId int not null,
		cmppoint int
	);
");
$mysqli->query("
	insert into animecmp(workId, cmppoint)
	select workId, 0
	from animelistgenres;
");
$animetemp = $mysqli->query("show tables like '%animetemp%';");
if ($animetemp->num_rows == 1)
	$mysqli->query("drop table animetemp;");
$mysqli->query("
	create table animetemp (
		workId int not null,
		genres varchar(255) not null
	);
");
$source = $_GET['source'];
if ($source == "Unknown") $source = "";
$animetype = $_GET['animetype'];
if ($animetype == "Unknown") $animetype = "";
$mysqli->query("
	insert into animetemp(workId, genres)
	select animelist.workId, replace(animelistgenres.genres, ' ', '')
	from animelist, animelistgenres
	where animelist.animetype like '%" . $animetype . "%' and
		animelist.source like '%" . $source . "%' and
		animelist.episodes >= " . $_GET['episodes'] . " and 
		animelist.duration >= " . $_GET['duration'] . " and
		animelist.startyear >= " . $_GET['startyear'] . " and
		animelist.workId = animelistgenres.workId;
");
$mysqli->query("
	set @n = (select workId
	from animelistgenres
	where workId = '" . $_GET['id'] . "');
");
for ($i = 1; $i <= 13; $i++){
	$mysqli->query("
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
						select split(genres, ', ', " . $i . ") as genre
						from animelistgenres
						where workId = @n
						having genre != ''), genres
					) != 0 or null
					or find_in_set ((
						select split(genres, ',', " . $i . ") as genre
						from animelistgenres
						where workId = @n
						having genre != ''), genres) != 0 or null
				) as sa
				where ac.workId = sa.workId
			) as an
		);
	");
}
$result = $mysqli->query("
	select al.jpName, if(al.engName = null, '無資料', al.engName),
		if(al.animetype = 'Unknown', '無資料', al.animetype),
		if(al.source = 'Unknown', '無資料', al.source), al.episodes,
		concat(al.duration, ' 分'), if(al.startyear = 0, '無資料', al.startyear),
		al.good, al.bad, al.workId
	from (
		select ac.workId as workId, ac.cmppoint * 3 + ar.rating as point
		from animecmp as ac
		inner join animerating as ar
		on ac.workId = ar.workId
		order by point desc
		limit " . $_GET['num'] . "
	) as fac, animelist as al
	where fac.workId = al.workId
	order by al.good desc;
");
echo "<table align='center' border='1'><tr>";
echo "<tr>
	<th style='width: 400px;'>日文名稱</th>
	<th style='width: 400px;'>英文名稱</th>
	<th>種類</th>
	<th>原作</th>
	<th>集數</th>
	<th>時間</th>
	<th>年份</th>
	<th>按讚</th>
</tr>";
while ($row = $result->fetch_row()){
	echo "<tr>";
	echo "<td>" . $row[0] . "</td>";
	echo "<td>" . $row[1] . "</td>";
	echo "<td>" . $row[2] . "</td>";
	echo "<td>" . $row[3] . "</td>";
	echo "<td>" . $row[4] . "</td>";
	echo "<td>" . $row[5] . "</td>";
	echo "<td>" . $row[6] . "</td>";
	echo "<td><input id='good" . $row[9] . "' class='img' type='image' img='' src='/img/like.PNG' onclick='like(" . $row[9] . ")'><span id='like" . $row[9] . "'>" . $row[7] . "</span><input id='bad" . $row[9] . "' class='img' type='image' img='' src='/img/dislike.PNG' onclick='unlike(" . $row[9] . ")'><span id='unlike" . $row[9] . "'>" . $row[8] . "</span></td>";
	echo "</tr>";
}
echo "</table>";
$mysqli->query("drop table animecmp;");
$mysqli->query("drop table animetemp;");
$result->free();
$mysqli->close();
?>