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

if (isset($_GET['pps_district'])) {
    $pps_district = $_GET['pps_district'];

    // Prepare and execute the query to fetch data from both tables
    $sql = "SELECT vp.victim_name, vp.victim_age, vp.victim_gender, vp.victim_ic_no, vp.victim_special_categ, vd.disease_name, vd.note, vd.after_checkup
            FROM victim_profile vp
            INNER JOIN disease_detail vd ON vp.victim_ic_no = vd.victim_ic_no
            INNER JOIN victim_pps vpps ON vp.victim_ic_no = vpps.victim_ic_no
            WHERE vpps.pps_id = ?";
    
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
        // Filter out records where disease_name is "TIADA"
        if ($row['disease_name'] !== "TIADA") {
            $data[] = $row;
        }
    }

    // Close the statement
    $stmt->close();

    // Return the data as JSON
    echo json_encode($data);
    exit();
} else {
    echo json_encode(["error" => "pps_district is not set"]);
    exit();
}

// Close the database connection
mysqli_close($conn);
?>
