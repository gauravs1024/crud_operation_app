<?php
include("dbconnection.php");
$con = dbconnection();

// Check database connection
if ($con) {
    // Connection established
} else {
    echo json_encode(['success' => false, 'message' => 'Database connectivity issue']);
    exit();
}

// Retrieve POST data
$name = $_POST["name"] ?? null;
$id = $_POST["id"] ?? null;
$email = $_POST["email"] ?? null;
$password = $_POST["password"] ?? null;

// Check if all required fields are set
if ($name === null || $id === null || $email === null || $password === null) {
    echo json_encode(['success' => false, 'message' => 'Missing required parameters']);
    exit();
}

// Prepare the SQL update query using prepared statements
$stmt = $con->prepare("UPDATE `users_crud_operation` SET `name` = ?, `email` = ?, `password` = ? WHERE `id` = ?");
if ($stmt) {
    // Bind parameters
    $stmt->bind_param("sssi", $name, $email, $password, $id);

    // Execute the query
    if ($stmt->execute()) {
        // Check if rows were affected
        if ($stmt->affected_rows > 0) {
            echo json_encode(['success' => true, 'message' => 'Data updated successfully']);
        } else {
            echo json_encode(['success' => false, 'message' => 'No data found with the provided ID']);
        }
    } else {
        echo json_encode(['success' => false, 'message' => 'Failed to execute query']);
    }

    // Close the statement
    $stmt->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Failed to prepare statement']);
}

// Close the database connection
$con->close();
?>
