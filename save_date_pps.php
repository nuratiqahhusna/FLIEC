<?php
session_start();
header('Content-Type: application/json');

// Error reporting for debugging purposes
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Establish MySQLi connection
$conn = mysqli_connect("localhost", "id22257398_fliec", "Qwerty123!", "id22257398_fliec_flood");
if ($conn == false) {
    die("Connection Error: " . mysqli_connect_error());
}

// Handle POST request
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Decode JSON data from request body
    $data = json_decode(file_get_contents("php://input"));

    // Validate and sanitize input
    $ppsId = mysqli_real_escape_string($conn, $data->ppsId);
    $dateType = mysqli_real_escape_string($conn, $data->dateType);
    $newDate = mysqli_real_escape_string($conn, $data->newDate);

    // Log received data for debugging
    error_log("Received data: ppsId=$ppsId, dateType=$dateType, newDate=$newDate");

    // Perform appropriate update based on dateType
    switch ($dateType) {
        case 'open_date':
            $result = updateOpenDate($conn, $ppsId, $newDate);
            break;
        case 'close_date':
            $result = updateCloseDate($conn, $ppsId, $newDate);
            break;
        default:
            // Handle unexpected dateType
            $result = ['error' => 'Invalid dateType'];
            break;
    }

    // Update status based on new dates
    updateStatus($conn, $ppsId);

    // Output JSON response
    echo json_encode($result);
} else {
    // Handle if request method is not POST
    echo json_encode(['error' => 'Method not allowed']);
}

// Function to update open_date in database
function updateOpenDate($conn, $ppsId, $newOpenDate) {
    $sql = "UPDATE pps_detail SET pps_open_date = ";
    if (empty($newOpenDate)) {
        $sql .= "NULL";
    } else {
        $sql .= "'$newOpenDate'";
    }
    $sql .= " WHERE pps_id = '$ppsId'";
    
    if (mysqli_query($conn, $sql)) {
        return ['success' => true];
    } else {
        return ['error' => 'Failed to update open_date: ' . mysqli_error($conn)];
    }
}

// Function to update close_date in database
function updateCloseDate($conn, $ppsId, $newCloseDate) {
    $sql = "UPDATE pps_detail SET pps_close_date = ";
    if (empty($newCloseDate)) {
        $sql .= "NULL";
    } else {
        $sql .= "'$newCloseDate'";
    }
    $sql .= " WHERE pps_id = '$ppsId'";
    
    if (mysqli_query($conn, $sql)) {
        return ['success' => true];
    } else {
        return ['error' => 'Failed to update close_date: ' . mysqli_error($conn)];
    }
}

// Function to update status based on dates
function updateStatus($conn, $ppsId) {
    $sql = "SELECT pps_open_date, pps_close_date FROM pps_detail WHERE pps_id = '$ppsId'";
    $result = mysqli_query($conn, $sql);
    if ($row = mysqli_fetch_assoc($result)) {
        $openDate = $row['pps_open_date'];
        $closeDate = $row['pps_close_date'];
        $status = 'TIDAK AKTIF';

        if (empty($openDate) && empty($closeDate)) {
            $status = 'TIDAK AKTIF';
        } elseif (!empty($openDate) && empty($closeDate)) {
            $status = 'AKTIF';
        } elseif (!empty($openDate) && !empty($closeDate)) {
            $today = new DateTime();
            $closeDateObj = new DateTime($closeDate);
            if ($closeDateObj < $today) {
                $status = 'TIDAK AKTIF';
            } else {
                $status = 'AKTIF';
            }
        }

        $sqlUpdate = "UPDATE pps_detail SET pps_status = '$status' WHERE pps_id = '$ppsId'";
        mysqli_query($conn, $sqlUpdate);
    }
}

?>
