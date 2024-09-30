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

    // Retrieve data sent from the client-side JavaScript
    $victim_ic_no = $_POST['victim_ic_no']; // Assuming 'ic_no' is the unique identifier for the record
    $checkboxes = isset($_POST['checkboxes']) ? $_POST['checkboxes'] : [];
    $disease_name = implode(", ", $checkboxes); // Combine checkbox values into a comma-separated string
    $note = isset($_POST['note']) ? $_POST['note'] : ''; // Get note value or set empty string if not provided

    // Prepare a SQL statement to update the database record with the new values
    $sql = "UPDATE disease_detail SET disease_name = ?, note = ? WHERE victim_ic_no = ?";

    // Prepare the statement
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ssi", $disease_name, $note, $victim_ic_no);

    // Execute the SQL statement
    if ($stmt->execute()) {
        // Return a success message as JSON response
        echo json_encode(array("success" => true, "message" => "Values updated successfully"));
    } else {
        // Return an error message as JSON response
        echo json_encode(array("success" => false, "message" => "Error updating values: " . $stmt->error));
    }

    // Close the statement and the database connection
    $stmt->close();
    $conn->close();
} else {
    // If the request method is not POST, return an error message
    echo json_encode(array("success" => false, "message" => "Invalid request method"));
}
?>
