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


// Check for the presence of pps_id parameter
if (isset($_GET['pps_id'])) {
    // Handle pps_id parameter
    $pps_id = $_GET['pps_id'];

    // Fetch the count of records for the specified pps_id
    $sql = "SELECT COUNT(*) as total, COUNT(DISTINCT family_id) as total_fam FROM victim_profile vp
            INNER JOIN victim_pps vpps ON vp.victim_ic_no = vpps.victim_ic_no
            WHERE vpps.pps_id = ?";
    $stmt = $conn->prepare($sql);
    if ($stmt === false) {
        error_log("Prepare failed: " . $conn->error);
        echo json_encode(["error" => "Prepare failed"]);
        exit();
    }
    $stmt->bind_param("i", $pps_id);
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
    $row = $result->fetch_assoc();
    $total_records = $row['total'];
    $total_records_fam = $row['total_fam'];

    // Fetch the capacity of the specified PPS
    $sql_capacity = "SELECT pps_capacity FROM pps_detail WHERE pps_id = ?";
    $stmt_capacity = $conn->prepare($sql_capacity);
    if ($stmt_capacity === false) {
        error_log("Prepare failed: " . $conn->error);
        echo json_encode(["error" => "Prepare failed"]);
        exit();
    }
    $stmt_capacity->bind_param("i", $pps_id);
    if ($stmt_capacity->execute() === false) {
        error_log("Execute failed: " . $stmt_capacity->error);
        echo json_encode(["error" => "Execute failed"]);
        exit();
    }
    $result_capacity = $stmt_capacity->get_result();
    if ($result_capacity === false) {
        error_log("Get result failed: " . $stmt_capacity->error);
        echo json_encode(["error" => "Get result failed"]);
        exit();
    }
    $row_capacity = $result_capacity->fetch_assoc();
    $pps_capacity = $row_capacity['pps_capacity'];

    // Calculate the percentage of capacity used
    $percentage_capacity = ($total_records / $pps_capacity) * 100;

    // Close the statements
    $stmt->close();
    $stmt_capacity->close();

    // Return the total records, family count, and percentage capacity as JSON
    echo json_encode([
        "pps_id" => $pps_id,
        "total_records" => $total_records,
        "total_records_fam" => $total_records_fam,
        "pps_capacity" => $pps_capacity,
        "percentage_capacity" => $percentage_capacity
    ]);
    exit();
} else {
    // If pps_id is not set
    echo json_encode(["error" => "No pps_id specified"]);
}

// Close the database connection
mysqli_close($conn);
?>
