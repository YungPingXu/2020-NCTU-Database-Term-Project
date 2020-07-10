<?php
$mysqli = new mysqli("localhost", "root", "password", "finalproject");
if ($mysqli->connect_errno)
	die("無法建立資料連接: " . $mysqli->connect_error);
$mysqli->query("SET NAMES utf8");
$source = $_GET['source'];
if ($source == "Unknown") $source = "";
$animetype = $_GET['animetype'];
if ($animetype == "Unknown") $animetype = "";
$result = $mysqli->query("
	SELECT animelist.jpName, if(animelist.engName = null, '無資料', animelist.engName), animelist.workId,
		if(animelist.animetype = 'Unknown', '無資料', animelist.animetype), if(animelist.source = 'Unknown', '無資料', animelist.source), animelist.episodes, concat(animelist.duration,' 分'), if(animelist.startyear = 0, '無資料', animelist.startyear), animelist.good, animelist.bad, animelist.workId
	FROM animelist
	where (animelist.jpName like '%" . $_GET['search'] . "%'
			or animelist.engName like '%" . $_GET['search'] . "%')
			and animelist.animetype like '%" . $animetype . "%' and
		animelist.source like '%" . $source . "%' and
		animelist.episodes >= " . $_GET['episodes'] . " and 
		animelist.duration >= " . $_GET['duration'] . " and
		animelist.startyear >= " . $_GET['startyear'] . "
	order by animelist.good desc
	LIMIT " . $_GET['num'] . ";
");
if ($result->num_rows == 0)
	echo "<span style='text-align: center;'>查無結果</span>";
else {
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
	$cnt = 0;
	while ($row = $result->fetch_row()) {
		echo "<tr>";
		echo "<td>" . $row[0] . "</td>";
		echo "<td>" . $row[1] . "</td>";
		echo "<td>" . $row[3] . "</td>";
		echo "<td>" . $row[4] . "</td>";
		echo "<td>" . $row[5] . "</td>";
		echo "<td>" . $row[6] . "</td>";
		echo "<td>" . $row[7] . "</td>";
		echo "<input id='recommend-id" . $cnt . "' type='hidden' value='" . $row[2] . "'>";
		echo "<td><input id='good" . $row[10] . "' class='img' type='image' img='' src='/img/like.PNG' onclick='like(" . $row[10] . ")'><span id='like" . $row[10] . "'>" . $row[8] . "</span><input id='bad" . $row[10] . "' class='img' type='image' img='' src='/img/dislike.PNG' onclick='unlike(" . $row[10] . ")'><span id='unlike" . $row[10] . "'>" . $row[9] . "</span></td>";
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