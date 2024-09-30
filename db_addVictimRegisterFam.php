<?php
session_start();

// Enable error reporting for debugging
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Start output buffering to capture any unexpected output
ob_start();

// Include the database connection file
$conn = mysqli_connect("localhost", "id22257398_fliec", "Qwerty123!", "id22257398_fliec_flood");
if ($conn == false) {
    die("Connection Error: " . mysqli_connect_error());
}
header('Content-Type: application/json');

// Check if the AJAX request is sent
if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    // Collect and sanitize POST data
    $datePps = mysqli_real_escape_string($conn, $_POST['datePps'] ?? '');
    $victimName = mysqli_real_escape_string($conn, strtoupper($_POST['victimName'] ?? ''));
    $victimIcNo = mysqli_real_escape_string($conn, $_POST['victimIcNo'] ?? '');
    $victimAge = mysqli_real_escape_string($conn, $_POST['victimAge'] ?? '');
    $victimGender = mysqli_real_escape_string($conn, $_POST['victimGender'] ?? '');
    $victimAgeCategory = mysqli_real_escape_string($conn, $_POST['victimAgeCategory']);
    $victimFamRelation = mysqli_real_escape_string($conn, $_POST['victimFamRelation'] ?? '');
     error_log("victimFamRelation: " . $victimFamRelation);
    $victimDisease = isset($_POST['victimDisease']) ? implode(", ", array_map(function($disease) use ($conn) { return mysqli_real_escape_string($conn, $disease);
        }, $_POST['victimDisease'])) : "TIADA";
    $diseaseNotes = mysqli_real_escape_string($conn, strtoupper($_POST['diseaseNotes']) ?? "TIADA");
    $victimCovidInfo = mysqli_real_escape_string($conn, $_POST['victimCovidInfo'] ?? '');
    $victimAdditionalNeeds = $_POST['victimAdditionalNeed'] ?? [];
     if (isset($_POST['victimSpecialCategory'])) {
    if (is_array($_POST['victimSpecialCategory'])) {
        // Multiple checkboxes selected
        $victimSpecialCategory = implode(", ", array_map(function($cat) use ($conn) {
            return mysqli_real_escape_string($conn, $cat);
        }, $_POST['victimSpecialCategory']));
    } else {
        // Single checkbox selected
        $victimSpecialCategory = mysqli_real_escape_string($conn, $_POST['victimSpecialCategory']);
    }
} else {
    $victimSpecialCategory = "TIADA";
}

    // Retrieve session data
    $ppsId = $_SESSION['pps_id'];
    $victimFamilyStatus = $_SESSION['victimFamilyStatus'];
    $victimAddress = $_SESSION['victimAddress'];
    $familyId = $_SESSION['family_id'];
    

    // Start transaction
    mysqli_begin_transaction($conn);

    try {
        // Insert into victim_pps table
        $query1 = "INSERT INTO victim_pps (pps_id, pps_date, victim_ic_no) VALUES ('$ppsId', '$datePps', '$victimIcNo')";
        $result1 = mysqli_query($conn, $query1);
        if (!$result1) throw new Exception(mysqli_error($conn));

        // Insert into victim_profile table
         $query2 = "INSERT INTO victim_profile (victim_name, victim_ic_no, victim_age, victim_gender, victim_special_categ, victim_age_categ, victim_relation, family_id) VALUES ('$victimName', '$victimIcNo', '$victimAge', '$victimGender', '$victimSpecialCategory', '$victimAgeCategory', '$victimFamRelation', '$familyId')";
        $result2 = mysqli_query($conn, $query2);
            if (!$result2) throw new Exception(mysqli_error($conn));
 
        // Insert into disease_detail table
        $query3 = "INSERT INTO disease_detail (disease_name, victim_ic_no, pps_id, note, victim_covid_check) VALUES ('$victimDisease', '$victimIcNo', '$ppsId', '$diseaseNotes', '$victimCovidInfo')";
        $result3 = mysqli_query($conn, $query3);
        if (!$result3) throw new Exception(mysqli_error($conn));

        // Update stock in flood_supply table
        foreach ($victimAdditionalNeeds as $supply_name) {
            $query4 = "UPDATE flood_supply SET stock = stock - 1 WHERE supply_name = '$supply_name' AND pps_id = $ppsId";
            $result4 = mysqli_query($conn, $query4);
            if (!$result4) {
                throw new Exception("Failed to update stock");
            }
        }

        // If all queries were successful
        mysqli_commit($conn);
        ob_clean(); // Clear any output buffer before sending JSON response
        echo json_encode(array("status" => "success", "message" => "Data inserted successfully into tables"));
    } catch (Exception $e) {
        // Rollback the transaction in case of exception
        mysqli_rollback($conn);
        
        // Send JSON error response
        ob_clean(); // Clear any output buffer before sending JSON response
        echo json_encode(array("status" => "error", "message" => "Database operation failed: " . $e->getMessage()));
    }

    $conn->close();
} else {
    // If not a POST request, return an error
    ob_clean();
    echo json_encode(array("status" => "error", "message" => "Invalid request method"));
}
?>