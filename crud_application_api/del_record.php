<?php

header('Content-Type: application/json');
include("dbconnection.php");
$con=dbconnection();

if(isset($_POST["id"])){
    $id=$_POST["id"];
}



$del_query="DELETE  FROM users_crud_operation WHERE id='$id'";
$exe=mysqli_query($con,$del_query);
$arr=[];
if($exe){
    print(" data deleted succesfully");
    $arr["success"]="true";
}
else{
    $arr["success"]="false";
}
print(json_encode($arr));

?>



?>