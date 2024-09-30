<?php
session_start();
header('Content-Type: application/json');

$servername = "localhost";
$username = "id22257398_fliec";
$password = "Qwerty123!";
$dbname = "id22257398_fliec_flood";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die(json_encode(['success' => false, 'message' => 'Connection failed: ' . $conn->connect_error]));
}

// Prepare SQL statement for inserting data
$sql = "INSERT INTO staff_info (staff_name, staff_position, staff_tasks, staff_phone_no, pps_id, staff_agency, staff_shift_start, staff_shift_end, staff_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
$stmt = $conn->prepare($sql);

if ($stmt === false) {
    die(json_encode(['success' => false, 'message' => 'Prepare failed: ' . $conn->error]));
}

// Bind parameters
$stmt->bind_param('ssssissss', $staff_name, $staff_position, $staff_tasks, $staff_phone_no, $pps_id, $staff_agency, $staff_shift_start, $staff_shift_end, $staff_date);

// Loop through the submitted data arrays
$staff_names = $_POST['staff_name'];
$staff_positions = $_POST['staff_position'];
$staff_tasks = $_POST['staff_tasks'];
$staff_phone_nos = $_POST['staff_phone_no'];
$district_ids = $_POST['district_id'];
$city_ids = $_POST['city_id'];
$time_from = $_POST['time_from'];
$time_to = $_POST['time_to'];
$dates = $_POST['date'];

for ($i = 0; $i < count($staff_names); $i++) {
    $staff_name = strtoupper($staff_names[$i]); // Convert to uppercase
    $staff_position = $staff_positions[$i];
    $staff_tasks = $staff_tasks[$i];
    $staff_phone_no = $staff_phone_nos[$i];
    $pps_id = $city_ids[$i]; // Assuming pps_id corresponds to city_id
    $staff_agency = "KKM";
    $staff_shift_start = $time_from[$i];
    $staff_shift_end = $time_to[$i];
    $staff_date = $dates[$i];

    if (!$stmt->execute()) {
        echo json_encode(['success' => false, 'message' => 'Execute failed: ' . $stmt->error]);
        $stmt->close();
        $conn->close();
        exit;
    }
}

$stmt->close();
$conn->close();

echo json_encode(['success' => true]);
?>
