<?php
// welcome.php
// Place session_start() at the beginning of the file if you're using sessions.
session_start();

// Perform your check to see if the user is logged in
// This is just a placeholder for your authentication check
if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    header('Location: login.php');
    exit;
}

// Sample user greeting
$userName = $_SESSION['Username'] ?? 'User'; // Replace with the actual session variable or method you use to retrieve the logged-in user's name
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome Page</title>
    <link rel="stylesheet" href="style.css"> <!-- Link to your CSS file -->
</head>
<body>
    <h1>Welcome, <?php echo htmlspecialchars($userName); ?>!</h1>
    <div class="navigation">
        <button onclick="window.location.href='clients_crud.php';">Manage Clients</button>
        <button onclick="window.location.href='articles_crud.php';">Manage Articles</button>
        <button onclick="window.location.href='categories_crud.php';">Manage Categories</button>
        <button onclick="window.location.href='orders_master_detail.php';">Order Overview</button>
        <button onclick="window.location.href='manage_stock.php';">Manage Stock</button>
    </div>
</body>
</html>
