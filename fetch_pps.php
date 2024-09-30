<?php
header('Content-Type: application/json');
session_start();
// Connect to the database
$conn = mysqli_connect("localhost", "id22257398_fliec", "Qwerty123!", "id22257398_fliec_flood");
if (!$conn) {
    error_log("Connection failed: " . mysqli_connect_error());
    echo json_encode(["error" => "Connection failed"]);
    exit();
}

if (isset($_POST['pps_district'])) {
    $pps_district = $_POST['pps_district'];

    // Prepare and execute the query to fetch cities based on the district
    $sql = "SELECT pps_name, pps_id FROM pps_detail WHERE pps_district = ?";
    $stmt = $conn->prepare($sql);
    if ($stmt === false) {
        error_log("Prepare failed: " . $conn->error);
        echo json_encode(["error" => "Prepare failed"]);
        exit();
    }
    $stmt->bind_param("i", $pps_district);
    if ($stmt->execute() === false) {
        error_log("Execute failed: " . $stmt->error);
        echo json_encode(["error" => "Execute failed"]);
        exit();
    }
    $result = $stmt->get_result();
    if ($result === false) {
        error_log("Get result failed: " . $stmt->error);
        echo json_encode(["error" => "Get result failed"]);
        exit();
    }

    $cities = array();
    while ($row = $result->fetch_assoc()) {
        $cities[] = $row;
    }

    // Close the statement and connection
    $stmt->close();
    mysqli_close($conn);

    // Return the cities as JSON
    echo json_encode($cities);
    exit();
} else {
    error_log("pps_district not set in POST request");
    echo json_encode(["error" => "pps_district not set in POST request"]);
    exit();
}
?>
