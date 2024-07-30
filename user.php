<?php
// Connect to database
require 'connectDB.php';
date_default_timezone_set('Asia/Kolkata');
$d = date("Y-m-d");
$t = date("H:i:s");

// Function to fetch user login data
function fetchUserData($conn, $d) {
    $sql = "SELECT * FROM users_logs WHERE checkindate=? ORDER BY timein DESC";
    $stmt = mysqli_stmt_init($conn);
    if (!mysqli_stmt_prepare($stmt, $sql)) {
        echo "SQL_Error_Select_logs";
        return [];
    } else {
        mysqli_stmt_bind_param($stmt, "s", $d);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);
        $userData = [];
        while ($row = mysqli_fetch_assoc($result)) {
            $userData[] = $row;
        }
        return $userData;
    }
}

// Fetch user data
$userData = fetchUserData($conn, $d);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Login Data</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>User Login Data for <?php echo $d; ?></h1>
    <table>
        <thead>
            <tr>
                <th>Username</th>
                <th>Card UID</th>
                <th>Device UID</th>
                <th>Device Department</th>
                <th>Check-in Date</th>
                <th>Time In</th>
                <th>Time Out</th>
                <th>Duration (Seconds)</th>
                <th>Remaining Time</th>
            </tr>
        </thead>
        <tbody>
            <?php if (empty($userData)): ?>
                <tr>
                    <td colspan="9">No user data found for today.</td>
                </tr>
            <?php else: ?>
                <?php foreach ($userData as $user): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($user['username']); ?></td>
                        <td><?php echo htmlspecialchars($user['card_uid']); ?></td>
                        <td><?php echo htmlspecialchars($user['device_uid']); ?></td>
                        <td><?php echo htmlspecialchars($user['device_dep']); ?></td>
                        <td><?php echo htmlspecialchars($user['checkindate']); ?></td>
                        <td><?php echo htmlspecialchars($user['timein']); ?></td>
                        <td><?php echo htmlspecialchars($user['timeout']); ?></td>
                        <td><?php echo htmlspecialchars($user['duration_seconds']); ?></td>
                        <td><?php echo htmlspecialchars($user['remaining_time']); ?></td>
                    </tr>
                <?php endforeach; ?>
            <?php endif; ?>
        </tbody>
    </table>
</body>
</html>
