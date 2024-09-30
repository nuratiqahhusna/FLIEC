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

try {
    // Check if the AJAX request is sent
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        
        // Check if all expected POST parameters are set
        $requiredFields = [
            'datePps', 'victimName', 'victimIcNo', 'victimAge', 'victimGender',
            'victimFamilyStatus', 'victimPhoneNo', 'victimAddress', 'victimAgeCategory', 'victimSpecialCategory', 'victimCovidInfo'
        ];

        foreach ($requiredFields as $field) {
            if (!isset($_POST[$field])) {
                throw new Exception("Missing field: " . $field);
            }
        }

        // Extract POST data
        $_SESSION['pps_id'] = $_POST['pps_id'];
        $_SESSION['datePps'] = $_POST['datePps'];
        $_SESSION['victimFamilyStatus'] = $_POST['victimFamilyStatus'];
        $_SESSION['victimAddress'] = $_POST['victimAddress'];
        $_SESSION['family_id'] = $_POST['victimIcNo'];
        
        $pps_id = $_POST['pps_id'];
        $datePps = $_POST['datePps'];
        $victimName = mysqli_real_escape_string($conn, strtoupper($_POST['victimName']));
        $victimIcNo = mysqli_real_escape_string($conn, $_POST['victimIcNo']);
        $victimFamRelation = 'WAKIL KELUARGA';
        $victimAge = mysqli_real_escape_string($conn, $_POST['victimAge']);
        $victimGender = mysqli_real_escape_string($conn, $_POST['victimGender']);
        $victimAgeCategory = mysqli_real_escape_string($conn, $_POST['victimAgeCategory']);
        $victimFamilyStatus = mysqli_real_escape_string($conn, $_POST['victimFamilyStatus']);
        $victimPhoneNo = mysqli_real_escape_string($conn, $_POST['victimPhoneNo']);
        $victimAddress = mysqli_real_escape_string($conn, strtoupper($_POST['victimAddress']));
        $victimCovidInfo = mysqli_real_escape_string($conn, $_POST['victimCovidInfo']);
        $victimAdditionalNeeds = isset($_POST['victimAdditionalNeed']) ? $_POST['victimAdditionalNeed'] : array();
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
        $victimDisease = isset($_POST['victimDisease']) ? implode(", ", array_map(function($disease) use ($conn) {
            return mysqli_real_escape_string($conn, $disease);
        }, $_POST['victimDisease'])) : "TIADA";
        $diseaseNotes = isset($_POST['diseaseNotes']) ? mysqli_real_escape_string($conn, strtoupper($_POST['diseaseNotes'])) : "TIADA";

        // Start transaction
        mysqli_begin_transaction($conn);

        try {
            // Insert into victim_pps table
            $query1 = "INSERT INTO victim_pps (pps_id, pps_date, victim_ic_no) VALUES ('$pps_id', '$datePps', '$victimIcNo')";
            $result1 = mysqli_query($conn, $query1);
            if (!$result1) throw new Exception(mysqli_error($conn));

            // Insert into victim_contact table
            $query2 = "INSERT INTO victim_contact (family_id, victim_phone_no, victim_status, victim_address) VALUES ('$victimIcNo', '$victimPhoneNo', '$victimFamilyStatus', '$victimAddress')";
            $result2 = mysqli_query($conn, $query2);
            if (!$result2) throw new Exception(mysqli_error($conn));

            // Insert into victim_profile table
            $query3 = "INSERT INTO victim_profile (victim_name, victim_ic_no, victim_age, victim_gender, victim_special_categ, victim_age_categ, victim_relation, family_id) VALUES ('$victimName', '$victimIcNo', '$victimAge', '$victimGender', '$victimSpecialCategory', '$victimAgeCategory', '$victimFamRelation', '$victimIcNo')";
            $result3 = mysqli_query($conn, $query3);
            if (!$result3) throw new Exception(mysqli_error($conn));

            // Insert into disease_detail table
            $query4 = "INSERT INTO disease_detail (disease_name, victim_ic_no, pps_id, note, victim_covid_check) VALUES ('$victimDisease', '$victimIcNo', '$pps_id', '$diseaseNotes', '$victimCovidInfo')";
            $result4 = mysqli_query($conn, $query4);
            if (!$result4) throw new Exception(mysqli_error($conn));

            // Update stock in flood_supply table
            foreach ($victimAdditionalNeeds as $supply_name) {
                $supply_name_escaped = mysqli_real_escape_string($conn, $supply_name);
                $query5 = "UPDATE flood_supply SET stock = stock - 1 WHERE supply_name = '$supply_name_escaped' AND pps_id = $pps_id";
                $result5 = mysqli_query($conn, $query5);
                if (!$result5) throw new Exception("Failed to update stock: " . mysqli_error($conn));
            }

            // Commit the transaction if all queries were successful
            mysqli_commit($conn);

            echo json_encode(array("status" => "success", "message" => "Data inserted successfully into tables"));
        } catch (Exception $e) {
            // Rollback the transaction in case of exception
            mysqli_rollback($conn);
            throw new Exception("Database operation failed");
        }
    } else {
        echo json_encode(["error" => "Invalid request method"]);
    }
} catch (Exception $e) {
    echo json_encode(array("status" => "error", "message" => "Transaction failed: " . $e->getMessage()));
}

// Close connection
$conn->close();
?>
