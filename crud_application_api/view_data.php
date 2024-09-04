<?php
include("dbconnection.php");
$con=dbconnection();
$select_query="SELECT * FROM `users_crud_operation`;";
$exe=mysqli_query($con,$select_query);
$arr=[];
while($row=mysqli_fetch_array($exe)){
    $arr[]=$row;
}

print(json_encode($arr));



?>
