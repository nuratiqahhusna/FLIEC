<?php
session_start();

// Check if the request method is POST
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Database connection parameters
    $servername = "localhost";
    $username = "id22257398_fliec";
    $password = "Qwerty123!";
    $dbname = "id22257398_fliec_flood";

    // Create a connection
    $conn = new mysqli($servername, $username, $password, $dbname);

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Retrieve and sanitize input data
    $victim_ic_no = isset($_POST['victim_ic_no']) ? $conn->real_escape_string($_POST['victim_ic_no']) : '';
    $checkboxes = isset($_POST['checkboxes']) ? $_POST['checkboxes'] : [];
    $after_checkup = implode(", ", $checkboxes); // Combine checkbox values into a comma-separated string
    $note = isset($_POST['note']) ? $conn->real_escape_string($_POST['note']) : ''; // Sanitize note value

    // Prepare a SQL statement to update the database record with the new values
    $sql = "UPDATE disease_detail SET after_checkup = ?, note = ? WHERE victim_ic_no = ?";

    // Prepare the statement
    if ($stmt = $conn->prepare($sql)) {
        // Bind parameters (assume victim_ic_no is a string)
        $stmt->bind_param("sss", $after_checkup, $note, $victim_ic_no);

        // Execute the SQL statement
        if ($stmt->execute()) {
            // Return a success message as JSON response
            echo json_encode(array("success" => true, "message" => "Values updated successfully"));
        } else {
            // Return an error message as JSON response
            echo json_encode(array("success" => false, "message" => "Error updating values: " . $stmt->error));
        }

        // Close the statement
        $stmt->close();
    } else {
        // Handle statement preparation error
        echo json_encode(array("success" => false, "message" => "Failed to prepare statement: " . $conn->error));
    }

    // Close the database connection
    $conn->close();
} else {
    // If the request method is not POST, return an error message
    echo json_encode(array("success" => false, "message" => "Invalid request method"));
}
?>
