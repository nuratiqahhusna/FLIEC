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

// Check if victim_ic_no is provided
if (isset($_GET['victim_ic_no'])) {
    $victim_ic_no = $_GET['victim_ic_no'];

    // Query to fetch the checkbox state from the database
    $query = "SELECT after_checkup, disease_name FROM disease_detail WHERE victim_ic_no = '$victim_ic_no'";

    // Execute the query
    $result = mysqli_query($conn, $query);

    if ($result) {
        // Fetch rows
        $rows = [];
        while ($row = mysqli_fetch_assoc($result)) {
            $rows[] = $row;
        }

        $checkbox_state = [];
        foreach ($rows as $row) {
            if (!empty($row['after_checkup'])) {
                // If after_checkup is not null, use its value to determine checkbox state
                $checkbox_state = array_merge($checkbox_state, explode(', ', $row['after_checkup']));
            } else {
                // If after_checkup is null, use disease_name column to determine checkbox state
                $checkbox_state = array_merge($checkbox_state, explode(', ', $row['disease_name']));
            }
        }
        $checkbox_state = array_unique($checkbox_state);

        // Prepare response data
        $response = array(
            'checkbox_state' => $checkbox_state
        );

        // Return JSON response
        echo json_encode($response);
    } else {
        // Query failed
        $response = array(
            'error' => 'Failed to fetch checkbox state from the database.'
        );
        echo json_encode($response);
    }
} else {
    // Required parameter not provided
    $response = array(
        'error' => 'victim_ic_no parameter is required.'
    );
    echo json_encode($response);
}
?>
