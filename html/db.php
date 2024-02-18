<?php
$serverName = "PSTHINKPAD\SQLEXPRESS";
$database = "M321";
$username = "warehouse_admin";
$password = "whadmin";

try {
    $conn = new PDO("sqlsrv:Server=$serverName;Database=$database", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    echo "Connection failed: " . $e->getMessage();
}
?>
