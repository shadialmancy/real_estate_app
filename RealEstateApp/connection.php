<?php
    $db = mysqli_connect('localhost','root','','real_estate');
    if(!$db){
        echo "error";
    }

$sql = "SELECT * FROM real_estate";
$result = mysqli_query($db,$sql);
$count = mysqli_num_rows($result);
?>