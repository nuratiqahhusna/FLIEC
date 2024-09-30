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

// Get the search query if provided
$query = isset($_POST['query']) ? $_POST['query'] : '';

// Prepare and execute the query to fetch data from staff_info table with staff_agency 'JKM'
if ($query) {
    $stmt = $conn->prepare("SELECT si.staff_id, si.staff_agency, si.staff_name, si.staff_phone_no, si.staff_position, si.pps_id, si.staff_tasks, si.staff_shift_start, si.staff_shift_end, si.staff_date, pd.pps_name
                            FROM staff_info si
                            LEFT JOIN pps_detail pd ON si.pps_id = pd.pps_id
                            WHERE si.staff_name LIKE ? AND si.staff_agency = 'JKM'");
    $likeQuery = '%' . $query . '%';
    $stmt->bind_param('s', $likeQuery);
} else {
    $stmt = $conn->prepare("SELECT si.staff_id, si.staff_name, si.staff_agency, si.staff_phone_no, si.staff_position, si.pps_id, si.staff_tasks, si.staff_shift_start, si.staff_shift_end, si.staff_date, pd.pps_name
                            FROM staff_info si
                            LEFT JOIN pps_detail pd ON si.pps_id = pd.pps_id
                            WHERE si.staff_agency = 'JKM'");
}

$stmt->execute();
$result = $stmt->get_result();
if ($result === false) {
    error_log("Query failed: " . $stmt->error);
    echo json_encode(["error" => "Query failed"]);
    exit();
}

$data = array();
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

// Close the database connection
$stmt->close();
$conn->close();

// Return the data as JSON
echo json_encode($data);
exit();
?>
