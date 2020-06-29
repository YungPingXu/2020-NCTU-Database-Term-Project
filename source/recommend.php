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
    from animeListGenres;
");
mysqli_query($link, "
    set @n = (select workId
    from animeListGenres
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
                from animeListGenres
                where find_in_set((select split(genres, ', ', " . $i . ") as genre
                        from animeListGenres
                        where workId = @n
                        having genre != ''), genres) != 0 or null
                    or find_in_set((select split(genres, ',', " . $i . ") as genre
                            from animeListGenres
                            where workId = @n
                            having genre != ''), genres) != 0 or null
                )as sa
                where ac.workId = sa.workId
            )as an
        );
    ");
}
$result = mysqli_query($link, "
    select G.jpName as jpName, G.engName
    from animecmp A, animeListGenres G
    where A.workId = G.workId
    order by cmppoint desc
    limit 50;
");
echo "<table border='1' align='center'><tr align='center'>";
echo "<tr><td>日文名稱</td><td>英文名稱</td><td></td>";
while ($row = $result->fetch_row()) {
    echo "<tr>";
    echo "<td>" . $row[0] . "</td>";
    echo "<td>" . $row[1] . "</td>";
    echo "</tr>";
}
echo "</table>";
mysqli_query($link, "drop table animecmp;");
mysqli_close($link);
