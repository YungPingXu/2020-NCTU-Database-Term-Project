<?php
    $mysqli = new mysqli("localhost", "root", "password", "finalproject");
    if ($mysqli->connect_errno) {
        die("無法建立資料連接: " . $mysqli->connect_error);
    }
    $ip = "";
    if (!empty($_SERVER['HTTP_CLIENT_IP']))
    {
      $ip=$_SERVER['HTTP_CLIENT_IP'];
    }
    elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR']))
    {
      $ip=$_SERVER['HTTP_X_FORWARDED_FOR'];
    }
    else
    {
      $ip=$_SERVER['REMOTE_ADDR'];
    }
    $good = $mysqli->query("
        select id
        from visitedip
        where ip = '" . $ip . "' and id = " . $_GET['id'] . " and good = 1 and bad = 0;
    ");
    if($good->num_rows == 1) {
        $mysqli->query("
            delete from visitedip
            where id = " . $_GET['id'] . " and ip='" . $ip . "' and good = 1 and bad = 0;
        ");
        $mysqli->query("
            update animelist
            set good = good - 1
            where workId = " . $_GET['id'] . ";
        ");
        echo "cancel";
    }else {
        $mysqli->query("
            insert into visitedip value('" . $ip . "', " . $_GET['id'] . ", 1, 0);
        ");
        $mysqli->query("
            update animelist
            set good = good + 1
            where workId = " . $_GET['id'] . ";
        ");
        echo "success";
    }
?>