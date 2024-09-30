<?php
session_start();
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $staff_id = $_POST['staff_id'];
    $pps_id = $_POST['pps_id'];
    $staff_shift_start = $_POST['staff_shift_start'];
    $staff_shift_end = $_POST['staff_shift_end'];
    $staff_date = $_POST['staff_date'];

    // Database connection
    $conn = new mysqli('localhost', 'id22257398_fliec', 'Qwerty123!', 'id22257398_fliec_flood');

    if ($conn->connect_error) {
        die(json_encode(['success' => false, 'message' => 'Database connection failed']));
    }

    $stmt = $conn->prepare("UPDATE staff_info SET pps_id = ?, staff_shift_start = ?, staff_shift_end = ?, staff_date = ? WHERE staff_id = ?");
    $stmt->bind_param('isssi', $pps_id, $staff_shift_start, $staff_shift_end, $staff_date, $staff_id);

    if ($stmt->execute()) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'message' => 'Failed to update staff info']);
    }

    $stmt->close();
    $conn->close();
}
?>
