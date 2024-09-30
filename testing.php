<?php
header('Content-Type: application/json');
session_start();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Session Data Example</title>
</head>
<body>
   <?php $_SESSION['pps_id'] = $_POST['pps_id']; ?>
        <?php $_SESSION['datePps'] = $_POST['datePps']; ?>
        <?php $_SESSION['victimFamilyStatus'] =  $_POST['victimFamilyStatus']; ?>
        <?php $_SESSION['victimAddress'] = $_POST['victimAddress']; ?>
        <?php $_SESSION['family_id'] = $_POST['victimIcNo']; ?>
        
     <?php echo $_SESSION['pps_id']; ?>
    <?php echo $_SESSION['datePps']; ?>
    <?php echo $_SESSION['victimFamilyStatus']; ?>
    <?php echo $_SESSION['victimAddress']; ?>
     <?php echo $_SESSION['family_id']; ?>
</body>
</html>