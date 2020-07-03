<?php
$mysqli = new mysqli("localhost", "root", "asd0976373843", "finalproject");
if ($mysqli->connect_errno) {
    die("無法建立資料連接: " . $mysqli->connect_error);
}
$mysqli->query("
    create table animecmp(
        workId int not null,
        cmppoint int
    );
");
$mysqli->query("
    insert into animecmp(workId, cmppoint)
    select workId, 0
    from animelistgenres;
");
$mysqli->query("
    create table animetemp(
	workId int not null,
	genres varchar(255) not null
);
");
$source=$_GET['source'];
if($source=="Unknown")$source="";
$animetype=$_GET['animetype'];
if($animetype=="Unknown")$animetype="";
$mysqli->query("
    insert into animetemp(workId, genres)
select animelist.workId, replace(animelistgenres.genres, ' ', '')
from animelist, animelistgenres
where animelist.animetype like '%" . $animetype . "%' and
        animelist.source like '%" . $source . "%' and
        animelist.episodes >= " . $_GET['episodes'] . " and 
        animelist.duration >= " . $_GET['duration'] . " and
        animelist.startyear >= " . $_GET['startyear'] . "  and
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
        where workId in
            (select an.workId
            from (select ac.workId
                from animecmp ac,
                (select workId
                from animetemp
                where (find_in_set((select split(genres, ',', " . $i . ") as genre
                            from animelistgenres
                            where workId = @n
                            having genre != ''), genres) != 0 or null)
                      and workId != @n
                )as sa
                where ac.workId = sa.workId
            )as an
        );
    ");
}
$result = $mysqli->query("
    select al.jpName as jpName, al.engName as engName, al.genres as genres
    from(select ac.workId as workId, ac.cmppoint * 3 + ar.rating as point
         from animecmp as ac inner join animerating as ar
              on ac.workId = ar.workId
         order by point desc
         limit 20)as fac, animelistgenresraw as al
    where fac.workId = al.workId;
");
echo "<table border='1' align='center'><tr align='center'>";
echo "<tr><td>日文名稱</td><td>英文名稱</td><td>屬性</td>";
while ($row = $result->fetch_row()){
    echo "<tr>";
    echo "<td>" . $row[0] . "</td>";
    echo "<td>" . $row[1] . "</td>";
    echo "<td>" . $row[2] . "</td>";
    echo "</tr>";
}
echo "</table>";
$mysqli->query("drop table animecmp;");
$mysqli->query("drop table animetemp;");
$result->free();
$mysqli->close();
?>