<?php
include("dbconnection.php");
$con=dbconnection();
if(isset($_POST["name"])){
    $name=$_POST["name"];
}
else return;
if(isset($_POST["email"])){
    $email=$_POST["email"];
}
else return;
if(isset($_POST["password"])){
    $password=$_POST["password"];
}
else return;

$query="insert into  users_crud_operation(name,email,password) values('$name','$email','$password')";
$exe=mysqli_query($con,$query);

if($exe){
    echo 'data inserted succesfully';
}
else{
    echo 'some issue';
}
$arr=[];
if($exe){
    $arr["success"]="true";

}
else{
    $arr["success"]="false";
}

print(json_encode($arr));
?>