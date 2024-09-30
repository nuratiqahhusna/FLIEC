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

if (isset($_GET['pps_district'])) {
    $pps_district = $_GET['pps_district'];

    // Prepare and execute the query to fetch data from victim_profile and disease_detail tables
    $sql = "SELECT disease_name, after_checkup
            FROM disease_detail
            WHERE pps_id = ?";
    
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

    $data = array();
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }

    // Close the statement
    $stmt->close();

    // Return the data as JSON
    echo json_encode($data);
    exit();
} else {
    // If no pps_district is set, fetch the count of records grouped by pps_id
    $sql = "SELECT pps_id, COUNT(*) as total FROM victim_profile GROUP BY pps_id";
    $result = $conn->query($sql);

    if ($result === false) {
        error_log("Query failed: " . $conn->error);
        echo json_encode(["error" => "Query failed"]);
        exit();
    }

    $data = array();
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }

    // Return the data as JSON
    echo json_encode($data);
    exit();
}

// Close the database connection
mysqli_close($conn);
?>
