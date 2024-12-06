<?php
// Connect to database
require 'connectDB.php';
date_default_timezone_set('Asia/Kolkata');
$current_date = date("Y-m-d");
$current_time = date("H:i:s");

if (isset($_GET['card_uid']) && isset($_GET['device_token'])) {
    $card_uid = $_GET['card_uid'];
    $device_token = $_GET['device_token'];
    $is_logout = isset($_GET['logout']) ? $_GET['logout'] == 'true' : false;

    if ($is_logout) {
        // Handle logout request
        handleLogout($card_uid, $device_token, $current_date, $current_time);
    } else {
        // Handle login or keep-alive request
        handleLoginOrKeepAlive($card_uid, $device_token, $current_date, $current_time);
    }

    // Check for inactive users and log them out if necessary
    checkAndLogoutInactiveUsers($current_date, $current_time);
} else {
    echo "Invalid Request";
    exit();
}

function handleLogout($card_uid, $device_token, $current_date, $current_time) {
    global $conn;

    // Get the user's login record
    $sql = "SELECT * FROM users_logs WHERE card_uid=? AND device_uid=? AND checkindate=? AND card_out=0";
    $stmt = mysqli_stmt_init($conn);
    if (!mysqli_stmt_prepare($stmt, $sql)) {
        echo "SQL_Error_Select_logs";
        exit();
    } else {
        mysqli_stmt_bind_param($stmt, "sss", $card_uid, $device_token, $current_date);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);

        if ($row = mysqli_fetch_assoc($result)) {
            // Calculate the duration from login to logout
            $timein = $row['timein'];
            $timein_datetime = new DateTime($timein);
            $timeout_datetime = new DateTime($current_time);
            $total_interval = $timein_datetime->diff($timeout_datetime);
            $total_seconds = ($total_interval->days * 24 * 60 * 60) + ($total_interval->h * 60 * 60) + ($total_interval->i * 60) + $total_interval->s;

            // Update logout time and duration
            $sql = "UPDATE users_logs SET card_out=1, duration_seconds=?, timeout=? WHERE card_uid=? AND device_uid=? AND checkindate=? AND card_out=0";
            $stmt = mysqli_stmt_init($conn);
            if (!mysqli_stmt_prepare($stmt, $sql)) {
                echo "SQL_Error_Update_logout";
                exit();
            } else {
                mysqli_stmt_bind_param($stmt, "issss", $total_seconds, $current_time, $card_uid, $device_token, $current_date);
                mysqli_stmt_execute($stmt);

                // Update the user's remaining time
                $sql = "UPDATE users SET remaining_time = remaining_time - ? WHERE card_uid=?";
                $stmt = mysqli_stmt_init($conn);
                if (!mysqli_stmt_prepare($stmt, $sql)) {
                    echo "SQL_Error_Update_remaining_time";
                    exit();
                } else {
                    mysqli_stmt_bind_param($stmt, "ds", $total_seconds, $card_uid);
                    mysqli_stmt_execute($stmt);
                    echo "logout" . getUserName($card_uid);  // Assuming getUserName is a function that gets the user's name
                    exit();
                }
            }
        } else {
            echo "user_not_logged_in";
            exit();
        }
    }
}

function handleLoginOrKeepAlive($card_uid, $device_token, $current_date, $current_time) {
    global $conn;

    // Check if the user is already logged in
    $sql = "SELECT * FROM users_logs WHERE card_uid=? AND device_uid=? AND checkindate=? AND card_out=0";
    $stmt = mysqli_stmt_init($conn);
    if (!mysqli_stmt_prepare($stmt, $sql)) {
        echo "SQL_Error_Select_logs";
        exit();
    } else {
        mysqli_stmt_bind_param($stmt, "sss", $card_uid, $device_token, $current_date);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);

        if ($row = mysqli_fetch_assoc($result)) {
            // User is already logged in, update the timeout to the current time
            $sql = "UPDATE users_logs SET timeout=? WHERE card_uid=? AND device_uid=? AND checkindate=? AND card_out=0";
            $stmt = mysqli_stmt_init($conn);
            if (!mysqli_stmt_prepare($stmt, $sql)) {
                echo "SQL_Error_Update_timeout";
                exit();
            } else {
                mysqli_stmt_bind_param($stmt, "ssss", $current_time, $card_uid, $device_token, $current_date);
                mysqli_stmt_execute($stmt);
                echo "user_active";
                exit();
            }
        } else {
            // New login request
            $sql = "INSERT INTO users_logs (card_uid, device_uid, checkindate, timein, timeout, card_out, duration_seconds) VALUES (?, ?, ?, ?, ?, 0, 0)";
            $stmt = mysqli_stmt_init($conn);
            if (!mysqli_stmt_prepare($stmt, $sql)) {
                echo "SQL_Error_Insert_login";
                exit();
            } else {
                mysqli_stmt_bind_param($stmt, "sssss", $card_uid, $device_token, $current_date, $current_time, $current_time);
                mysqli_stmt_execute($stmt);
                echo "login" . getUserName($card_uid);  // Assuming getUserName is a function that gets the user's name
                exit();
            }
        }
    }
}

function checkAndLogoutInactiveUsers($current_date, $current_time) {
    global $conn;

    $sql = "SELECT * FROM users_logs WHERE checkindate=? AND card_out=0";
    $stmt = mysqli_stmt_init($conn);
    if (!mysqli_stmt_prepare($stmt, $sql)) {
        echo "SQL_Error_Select_logs";
        exit();
    } else {
        mysqli_stmt_bind_param($stmt, "s", $current_date);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);

        while ($row = mysqli_fetch_assoc($result)) {
            $card_uid = $row['card_uid'];
            $device_uid = $row['device_uid'];
            $timeout = $row['timeout'];
            $timein = $row['timein'];

            $timeout_datetime = new DateTime($timeout);
            $current_datetime = new DateTime($current_time);
            $interval = $timeout_datetime->diff($current_datetime);
            $seconds = ($interval->days * 24 * 60 * 60) + ($interval->h * 60 * 60) + ($interval->i * 60) + $interval->s;

            // If more than 30 seconds have passed since the last request, log the user out
            if ($seconds > 30) {
                // Calculate total duration from login to logout
                $timein_datetime = new DateTime($timein);
                $total_interval = $timein_datetime->diff($current_datetime);
                $total_seconds = ($total_interval->days * 24 * 60 * 60) + ($total_interval->h * 60 * 60) + ($total_interval->i * 60) + $total_interval->s;

                // Update the log record to mark the user as logged out
                $sql = "UPDATE users_logs SET card_out=1, duration_seconds=?, timeout=? WHERE card_uid=? AND device_uid=? AND checkindate=? AND card_out=0";
                $stmt = mysqli_stmt_init($conn);
                if (!mysqli_stmt_prepare($stmt, $sql)) {
                    echo "SQL_Error_Update_logout";
                    exit();
                } else {
                    mysqli_stmt_bind_param($stmt, "issss", $total_seconds, $current_time, $card_uid, $device_uid, $current_date);
                    mysqli_stmt_execute($stmt);

                    // Update the user's remaining time
                    $sql = "UPDATE users SET remaining_time = remaining_time - ? WHERE card_uid=?";
                    $stmt = mysqli_stmt_init($conn);
                    if (!mysqli_stmt_prepare($stmt, $sql)) {
                        echo "SQL_Error_Update_remaining_time";
                        exit();
                    } else {
                        mysqli_stmt_bind_param($stmt, "ds", $total_seconds, $card_uid);
                        mysqli_stmt_execute($stmt);
                    }
                }
            }
        }
    }
}

function getUserName($card_uid) {
    global $conn;
    $sql = "SELECT username FROM users WHERE card_uid=?";
    $stmt = mysqli_stmt_init($conn);
    if (!mysqli_stmt_prepare($stmt, $sql)) {
        return "Error fetching username";
    } else {
        mysqli_stmt_bind_param($stmt, "s", $card_uid);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);
        if ($row = mysqli_fetch_assoc($result)) {
            return $row['username'];
        } else {
            return "Unknown user";
        }
    }
}
?>
