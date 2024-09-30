<?php
session_start();
$servername = "localhost";
$username = "id22257398_fliec";
$password = "Qwerty123!";
$dbname = "id22257398_fliec_flood";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $supply_id = $_POST['supply_id'];
    $new_quantity = $_POST['new_quantity'];

    $stmt = $conn->prepare("UPDATE flood_supply SET stock = ? WHERE supply_id = ?");
    $stmt->bind_param("ii", $new_quantity, $supply_id);

    if ($stmt->execute()) {
        echo "Success";
    } else {
        echo "Error: " . $stmt->error;
    }

    $stmt->close();
}

$conn->close();
?>
