<?php
session_start();
header('Content-Type: application/json');

// Connect to the database
$conn = new mysqli("localhost", "id22257398_fliec", "Qwerty123!", "id22257398_fliec_flood");
if ($conn->connect_error) {
    error_log("Connection failed: " . $conn->connect_error);
    echo json_encode(["error" => "Connection failed"]);
    exit();
}

if (isset($_GET['pps_id'])) {
    $pps_id = $_GET['pps_id'];

    // Fetch the main person's data whose ic_no is the same as family_id and based on pps_id
    $stmt = $conn->prepare("SELECT vp.victim_name, vp.victim_ic_no, vc.victim_phone_no
                            FROM victim_profile vp 
                            INNER JOIN victim_pps vpps ON vp.victim_ic_no = vpps.victim_ic_no
                            LEFT JOIN victim_contact vc ON vp.victim_ic_no = vc.family_id
                            WHERE vpps.pps_id = ? AND vp.victim_ic_no = vp.family_id");
    if ($stmt === false) {
        error_log("Prepare failed: " . $conn->error);
        echo json_encode(["error" => "Query prepare failed"]);
        exit();
    }

    $stmt->bind_param("s", $pps_id);
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

    $stmt->close();
    $conn->close();

    echo json_encode($data);
    exit();
}

if (isset($_GET['victim_ic_no'])) {
    $victim_ic_no = $_GET['victim_ic_no'];

    // Fetch the main person's data whose IC number is the same as family_id
    $stmt = $conn->prepare("SELECT vp.victim_name, vp.victim_ic_no, vp.victim_relation, vc.victim_phone_no
                            FROM victim_profile vp
                            LEFT JOIN victim_contact vc ON vp.victim_ic_no = vc.family_id
                            WHERE vp.victim_ic_no = ?");
    if ($stmt === false) {
        error_log("Prepare failed: " . $conn->error);
        echo json_encode(["error" => "Query prepare failed"]);
        exit();
    }

    $stmt->bind_param("s", $victim_ic_no);
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

    $stmt->close();
    $conn->close();

    echo json_encode($data);
    exit();
}

if (isset($_GET['family_id'])) {
    $family_id = $_GET['family_id'];

    // Fetch all family members based on family_id
    $stmt = $conn->prepare("SELECT vp.victim_name, vp.victim_ic_no, vp.victim_relation, vp.victim_age, vc.victim_phone_no
                            FROM victim_profile vp
                            LEFT JOIN victim_contact vc ON vp.family_id = vc.family_id
                            WHERE vp.family_id = ?");
    if ($stmt === false) {
        error_log("Prepare failed: " . $conn->error);
        echo json_encode(["error" => "Query prepare failed"]);
        exit();
    }

    $stmt->bind_param("s", $family_id); // Bind the value of $family_id to the placeholder
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

    $stmt->close();
    $conn->close();

    echo json_encode($data);
    exit();
}

echo json_encode(["error" => "Invalid request"]);
exit();
?>

