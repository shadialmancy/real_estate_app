<?php
    $servername = "127.0.0.1";
    $username = "root";
    $passeword = "";
    $dbname = "real_estate";
    
    header('Conrent-Type: application/json');
    header("Access-Control-Allow-Headers: Access-Control-Allow-Origin, Accept");
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Methods: POST, OPTIONS");
    
    // create connection
    $conn = mysqli_connect($servername, $username, $passeword, $dbname);

    // get sql command and fire sql query
    $sql = $_POST['command'];
    // $sql = "SELECT * FROM property";
    $queryResult = mysqli_query($conn,$sql);
    // echo $queryResult;
    // assigne the result to an array then return it
    $result = array();
    while($row = mysqli_fetch_assoc($queryResult)){
        array_push($result, $row);
    }
    
    // $count = mysqli_num_rows($queryResult);
    // if($count>0){
    //     echo json_encode("success"); 
    // }else{
    //     echo json_encode("error");
    // }
    // print_r($result); 
    echo json_encode($result);
    //print_r($result);
?> 