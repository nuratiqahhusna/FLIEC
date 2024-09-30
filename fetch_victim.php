<?php
session_start();
$servername = "localhost";
$username = "id22257398_fliec";
$password = "Qwerty123!";
$dbname = "id22257398_fliec_flood";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Retrieve session variables
$ppsId = $_SESSION['pps_id'];
$familyId = $_SESSION['family_id'];

// Check if session variables are set
if (isset($ppsId) && isset($familyId)) {
    // Prepare and execute SQL query with JOIN
    $sql = "SELECT vp.victim_ic_no, vp.victim_name, vp.victim_age, vp.victim_gender, vp.victim_age_categ, vp.victim_special_categ, vp.victim_relation 
            FROM victim_profile vp
            JOIN victim_pps pp ON vp.victim_ic_no = pp.victim_ic_no
            WHERE pp.pps_id = ? AND vp.family_id = ?";

    $stmt = $conn->prepare($sql);
    if ($stmt) {
        $stmt->bind_param("ss", $ppsId, $familyId);
        $stmt->execute();
        $result = $stmt->get_result();

        $data = array();
        if ($result->num_rows > 0) {
            // Fetch all data into an array
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
        }

        $stmt->close();
    } else {
        echo "Error preparing statement: " . $conn->error;
    }
} else {
    echo "Session variables are not set.";
}

$conn->close();

// Encode data to JSON
echo json_encode($data);
?>
