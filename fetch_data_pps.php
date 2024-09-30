<?php
session_start();
header('Content-Type: application/json');

// Connect to the database
$conn = mysqli_connect("localhost", "id22257398_fliec", "Qwerty123!", "id22257398_fliec_flood");
if (!$conn) {
    error_log("Connection failed: " . mysqli_connect_error());
    echo json_encode(["error" => "Connection failed"]);
    exit();
}

// Get the input data from POST or GET
$input = file_get_contents('php://input');
$data = json_decode($input, true);

// Check if districtId is set in POST data or GET parameters
if (isset($data['districtId'])) {
    $districtId = $data['districtId'];
} elseif (isset($_GET['districtId'])) {
    $districtId = $_GET['districtId'];
} else {
    echo json_encode(["error" => "Invalid input"]);
    exit();
}

// Fetch the data from the database
$sql = "SELECT pps_name, pps_capacity, pps_open_date, pps_close_date, pps_status, pps_address, pps_id, pps_status FROM pps_detail WHERE pps_district = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $districtId);
$stmt->execute();
$result = $stmt->get_result();

$ppsData = [];
while ($row = $result->fetch_assoc()) {
    $ppsData[] = $row;
}

$stmt->close();
$conn->close();

echo json_encode($ppsData);
?>
