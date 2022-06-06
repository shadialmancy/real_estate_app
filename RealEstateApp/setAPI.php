<?php

    // API file to send data from the application to the Database server
    $servername = "127.0.0.1";
    $username = "root";
    $passeword = "";
    $dbname = "real_estate";
    
    // create connection
    $conn = new mysqli($servername, $username, $passeword, $dbname);

    // get sql command and fire sql query
    $sql = $_POST["command"];
    $result = mysqli_query($conn,$sql);

    // test connection
    if(!$conn){
        echo  "connection error";
    }
    else{
        echo  "connection succesful ";
    }

    // test query
    if($result){
        echo  "done";
    }
    else{
        echo  "error";
    }
?>  