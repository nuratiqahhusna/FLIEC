<?php
session_start();
header('Content-Type: application/json');

// Connect to the database
$conn = mysqli_connect("localhost", "id22257398_fliec", "Qwerty123!", "id22257398_fliec_flood");
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// Check if pps_id is set in the request (assuming it's passed via GET or POST)
$pps_id = isset($_REQUEST['pps_id']) ? mysqli_real_escape_string($conn, $_REQUEST['pps_id']) : null;

// Query to fetch the data based on pps_id
$query = "
    SELECT 
        vp.family_id AS head_family_ic_no,
        IF(vp.victim_ic_no = vp.family_id, vp.victim_name, head.victim_name) AS head_family_name,
        vp.victim_name,
        vp.victim_age,
        vp.victim_ic_no,
        vp.victim_gender,
        vp.victim_age_categ,
        vp.victim_special_categ,
        vp.victim_relation,
        vc.victim_address,
        vc.victim_phone_no,
        vps.pps_id
    FROM 
        victim_profile vp
    LEFT JOIN 
        victim_profile head ON vp.family_id = head.victim_ic_no
    LEFT JOIN 
        victim_pps vps ON vp.victim_ic_no = vps.victim_ic_no
    LEFT JOIN 
        victim_contact vc ON vp.family_id = vc.family_id
    WHERE 
        vps.pps_id = '$pps_id'  -- Filter by pps_id
    ORDER BY 
        vp.family_id";  // Order by family_id

$result = mysqli_query($conn, $query);

if (!$result) {
    die("Query failed: " . mysqli_error($conn));
}

$data = array();
$familyCounts = array(); // Initialize array to store family counts

while ($row = mysqli_fetch_assoc($result)) {
    $data[] = $row;
    // Count occurrences of each head_family_ic_no
    $family_id = $row['head_family_ic_no'];
    if (!isset($familyCounts[$family_id])) {
        $familyCounts[$family_id] = 0;
    }
    $familyCounts[$family_id]++;
}

// Include familyCounts in the JSON response
$response = array(
    'data' => $data,
    'familyCounts' => $familyCounts
);
echo json_encode($response);

mysqli_close($conn);
?>
