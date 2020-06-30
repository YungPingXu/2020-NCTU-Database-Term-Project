<?php
$link = mysqli_connect("localhost", "root", "asd0976373843")
or die("無法建立資料連接: " . mysqli_connect_error());

mysqli_select_db($link, "finalproject")
or die("無法開啟 finalproject 資料庫<br>" . mysqli_error($link));

mysqli_query($link, "
    create table animecmp(
        workId int not null,
        cmppoint int
    );
");

mysqli_query($link, "
    insert into animecmp(workId, cmppoint)
    select workId, 0
    from animelistgenres;
");
mysqli_query($link, "
    set @n = (select workId
    from animelistgenres
    where workId = '" . $_GET['id'] . "');
");
for ($i = 1; $i <= 12; $i++) {
    mysqli_query($link, "
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
$result = mysqli_query($link, "
    select al.jpName as jpName, al.engName as engName, al.genres as genres
    from(select ac.workId as workId, ac.cmppoint * 3 + ar.rating as point
         from animecmp as ac inner join animerating as ar
              on ac.workId = ar.workId
         order by point desc
         limit 10)as fac, animelistgenres as al
    where fac.workId = al.workId;
");

echo "<table border='1' align='center'><tr align='center'>";
echo "<tr><td>日文名稱</td><td>英文名稱</td><td>屬性</td>";
while ($row = $result->fetch_row()) {
    echo "<tr>";
    echo "<td>" . $row[0] . "</td>";
    echo "<td>" . $row[1] . "</td>";
    echo "<td>" . $row[2] . "</td>";
    echo "</tr>";
}
echo "</table>";
mysqli_query($link, "drop table animecmp;");
mysqli_close($link);
