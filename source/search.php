<?php
$mysqli = new mysqli("localhost", "root", "asd0976373843", "finalproject");
if ($mysqli->connect_errno) {
    die("無法建立資料連接: " . $mysqli->connect_error);
}
$mysqli->query("SET NAMES utf8");
$source=$_GET['source'];
if($source=="Unknown")$source="";
$animetype=$_GET['animetype'];
if($animetype=="Unknown")$animetype="";
$result = $mysqli->query("
    SELECT animename.jpName, animename.engName,animename.workId
	FROM animename, animelist
    where (animename.jpName like '%" . $_GET['search'] . "%'
          or animename.engName like '%" . $_GET['search'] . "%')
          and animelist.animetype like '%" . $animetype . "%' and
        animelist.source like '%" . $source . "%' and
        animelist.episodes >= " . $_GET['episodes'] . " and 
        animelist.duration >= " . $_GET['duration'] . " and
        animelist.startyear >= " . $_GET['startyear'] . " and
        animelist.workId = animename.workId
    LIMIT 100;
");
if ($result->num_rows == 0) {
    echo "查無結果";
} else {
    echo "<table border='1'><tr align='center'>";
    echo "<tr><td>日文名稱</td><td>英文名稱</td>";
    $cnt = 0;
    while ($row = $result->fetch_row()) {
        echo "<tr>";
        echo "<td>" . $row[0] . "</td>";
        echo "<td>" . $row[1] . "</td>";
        echo "<input id='recommend-id" . $cnt . "' type='hidden' value='" . $row[2] . "'>";
        echo "<td>
            <button class='recommend-button' id='recommend-button" . $cnt . "' onclick='recommend(" . $cnt++ . ")'>
              <!--<i class='fa fa-circle-o-notch fa-spin'></i>-->開始推薦
            </button>
          </td>";
        echo "</tr>";
    }

    echo "</table>";
}
$result->free();
$mysqli->close();
?>