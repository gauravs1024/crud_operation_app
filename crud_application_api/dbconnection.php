<?php
function dbconnection(){
$con=mysqli_connect("localhost","root","","crud_operation","3306");
return $con;
}

?>