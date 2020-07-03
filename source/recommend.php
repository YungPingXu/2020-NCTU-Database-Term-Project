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
    set @n = (select workId
    from animelistgenres
    where workId = '" . $_GET['id'] . "');
");
for ($i = 1; $i <= 12; $i++){
    $mysqli->query("
        update animecmp
        set cmppoint = cmppoint + 1
        where workId in
            (select an.workId
            from (select ac.workId
                from animecmp ac,
                (select workId
                from animelistgenres
                where find_in_set((select split(genres, ', ', " . $i . ") as genre
                        from animelistgenres
                        where workId = @n
                        having genre != ''), genres) != 0 or null
                    or find_in_set((select split(genres, ',', " . $i . ") as genre
                            from animelistgenres
                            where workId = @n
                            having genre != ''), genres) != 0 or null
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
         limit 20)as fac, animelistgenres as al
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
$result->free();
$mysqli->close();
?>