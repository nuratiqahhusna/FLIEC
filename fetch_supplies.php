<?php
$servername = "localhost";
$username = "id22257398_fliec";
$password = "Qwerty123!";
$dbname = "id22257398_fliec_flood";

session_start();

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$pps_id = isset($_POST['pps_id']) ? $_POST['pps_id'] : '';

if ($pps_id) {
    $stmt = $conn->prepare("SELECT supply_id, supply_name, status, stock, supply_type FROM flood_supply WHERE pps_id = ?");
    $stmt->bind_param("i", $pps_id);
} else {
    $stmt = $conn->prepare("SELECT supply_id, supply_name, status, stock, supply_type FROM flood_supply");
}

$stmt->execute();
$result = $stmt->get_result();

$supplies = array();
while($row = $result->fetch_assoc()) {
    $supplies[] = $row;
}

echo json_encode($supplies);

$stmt->close();
$conn->close();
?>