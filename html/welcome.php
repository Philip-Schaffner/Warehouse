<?php
// welcome.php
session_start();

if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    header('Location: login.php');
    exit;
}

$userName = $_SESSION['Username'] ?? 'User'; 
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome Page</title>
    <link rel="stylesheet" href="style.css">
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
