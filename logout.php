<?php
session_start();

// Destroy session
session_destroy();

error_reporting(E_ALL);
ini_set('display_errors', 1);


// Send JSON response indicating success
echo json_encode(["success" => true]);
?>
