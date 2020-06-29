<?php
$mysqli = new mysqli("localhost", "root", "asd0976373843", "finalproject");
if ($mysqli->connect_errno) {
    die("無法建立資料連接: " . $mysqli->connect_error);
}
$mysqli->query("SET NAMES utf8");
$result = $mysqli->query("
    SELECT jpName, engName,workId
	FROM animelistgenres
    where jpName like '%" . $_GET['search'] . "%'
          or engName like '%" . $_GET['search'] . "%'
    LIMIT 100;
");

echo "<table border='1' align='center'><tr align='center'>";
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

$result->free();
$mysqli->close();
