<?php
session_start();
header('Content-Type: application/json');
ob_start(); // Start output buffering

// Connect to the database
$conn = mysqli_connect("localhost", "id22257398_fliec", "Qwerty123!", "id22257398_fliec_flood");
if (!$conn) {
    error_log("Connection failed: " . mysqli_connect_error());
    http_response_code(500); // Internal Server Error
    echo json_encode(["error" => "Connection failed: " . mysqli_connect_error()]);
    ob_end_flush();
    exit();
}

// Check if pps_district is set in POST request
if (isset($_POST['pps_district'])) {
    $pps_district = $_POST['pps_district'];
    
    // Insert data into database
    if (
        isset($_POST['name']) && 
        isset($_POST['capacity']) && 
        isset($_POST['address']) && 
        isset($_POST['dateOpen']) && 
        isset($_POST['latitude']) && 
        isset($_POST['longitude']) && 
        isset($_POST['category'])
    ) {
        $names = $_POST['name'];
        $capacities = $_POST['capacity'];
        $addresses = $_POST['address'];
        $datesOpen = $_POST['dateOpen'];
        $latitudes = $_POST['latitude'];
        $longitudes = $_POST['longitude'];
        $categories = $_POST['category'];

        // Prepare and execute the query to insert data
        $sql = "INSERT INTO pps_detail (pps_name, pps_capacity, pps_address, pps_open_date, pps_latitude, pps_longitude, pps_categ, pps_district) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        $stmt = $conn->prepare($sql);
        if ($stmt === false) {
            error_log("Prepare failed: " . $conn->error);
            http_response_code(500); // Internal Server Error
            echo json_encode(["error" => "Prepare failed: " . $conn->error]);
            ob_end_flush();
            exit();
        }
        
        // Bind parameters and execute the statement for each row
        for ($i = 0; $i < count($names); $i++) {
            $name_upper = strtoupper($names[$i]);
            $address_upper = strtoupper($addresses[$i]);
            $stmt->bind_param("sissddsi", $name_upper, $capacities[$i], $address_upper, $datesOpen[$i], $latitudes[$i], $longitudes[$i], $categories[$i], $pps_district);
            if ($stmt->execute() === false) {
                error_log("Execute failed: " . $stmt->error);
                http_response_code(500); // Internal Server Error
                echo json_encode(["error" => "Execute failed: " . $stmt->error]);
                ob_end_flush();
                exit();
            }
        }
        
        // Return success message
        http_response_code(200); // OK
        echo json_encode(["success" => true]);
        ob_end_flush();
        exit();
    } else {
        error_log("Invalid request parameters");
        http_response_code(400); // Bad Request
        echo json_encode(["error" => "Invalid request parameters"]);
        ob_end_flush();
        exit();
    }
} else {
    error_log("pps_district not set");
    http_response_code(400); // Bad Request
    echo json_encode(["error" => "pps_district not set"]);
    ob_end_flush();
    exit();
}

// Close the database connection
mysqli_close($conn);
ob_end_flush();
?>
