<?php
$mysqli = new mysqli("localhost", "root", "password", "finalproject");
if ($mysqli->connect_errno)
	die("無法建立資料連接: " . $mysqli->connect_error);
$ip = "";
if (!empty($_SERVER['HTTP_CLIENT_IP']))
	$ip = $_SERVER['HTTP_CLIENT_IP'];
elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR']))
	$ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
else
	$ip = $_SERVER['REMOTE_ADDR'];
$bad = $mysqli->query("
	select animeID
	from userlike
	where userIP = '" . $ip . "' and animeID = " . $_GET['id'] . " and good = 0 and bad = 1;
");
if ($bad->num_rows == 0) {
	$mysqli->query("
		insert into userlike value('" . $ip . "', " . $_GET['id'] . ", 0, 1);
	");
	$mysqli->query("
		update animelist
		set bad = bad + 1
		where workId = " . $_GET['id'] . ";
	");
	echo "success";
} else {
	$mysqli->query("
		delete from userlike
		where userIP = '" . $ip . "' and animeID = " . $_GET['id'] . " and good = 0 and bad = 1;
	");
	$mysqli->query("
		update animelist
		set bad = bad - 1
		where workId = " . $_GET['id'] . ";
	");
	echo "cancel";
}
?>