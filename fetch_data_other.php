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

if (isset($_GET['pps_id'])) {
    $pps_id = $_GET['pps_id'];

    // Prepare and execute the query to fetch data from victim_profile, disease_detail, and victim_pps tables
    $sql = "SELECT vp.victim_name, vp.victim_age, vp.victim_gender, vp.victim_ic_no, vp.victim_age_categ, vp.victim_special_categ, 
                   COALESCE(vd.disease_name, '0') as disease_name, vd.note, COALESCE(vd.after_checkup, 0) as after_checkup
            FROM victim_profile vp
            LEFT JOIN disease_detail vd ON vp.victim_ic_no = vd.victim_ic_no
            LEFT JOIN victim_pps vpps ON vp.victim_ic_no = vpps.victim_ic_no
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
    echo json_encode(["error" => "pps_district is not set"]);
    exit();
}

// Close the database connection
mysqli_close($conn);
?>
