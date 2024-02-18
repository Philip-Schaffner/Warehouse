<?php
session_start();

if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    header('Location: login.php');
    exit;
}

include 'db.php'; // Assume this includes the PDO connection setup

// Handle stock update
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['update'])) {
    $stock = $_POST['stock'];

    $updateSql = "UPDATE [dbo].[Stock] SET Stock = ? WHERE ArticleID = ? AND WarehouseID = ?";
    $updateStmt = $conn->prepare($updateSql);
    $updateStmt->execute([$stock, $articleId, $warehouseID]);

    header("Location: manage_stock.php"); // Refresh the page
    exit();
}

// Handle add new stock
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['add'])) {
    $articleId = $_POST['new_articleId'];
    $warehouseId = $_POST['new_warehouseId'];
    $stock = $_POST['new_stock'];

    $addSql = "INSERT INTO [dbo].[Stock] (ArticleID, WarehouseID, Stock) VALUES (?, ?, ?)";
    $addStmt = $conn->prepare($addSql);
    $addStmt->execute([$articleId, $warehouseId, $stock]);

    header("Location: manage_stock.php"); // Refresh the page
    exit();
}

// Fetch articles and warehouses for dropdowns
$articlesSql = "SELECT ArticleID, Name FROM [dbo].[Articles]";
$articlesStmt = $conn->query($articlesSql);
$articles = $articlesStmt->fetchAll(PDO::FETCH_ASSOC);

$warehousesSql = "SELECT WarehouseID, Name FROM [dbo].[Warehouses]";
$warehousesStmt = $conn->query($warehousesSql);
$warehouses = $warehousesStmt->fetchAll(PDO::FETCH_ASSOC);

// Fetch all stock entries
$stocksSql = "SELECT s.ArticleID, s.WarehouseID, s.Stock, a.Name AS ArticleName, w.Name AS WarehouseName FROM [dbo].[Stock] s JOIN [dbo].[Articles] a ON s.ArticleID = a.ArticleID JOIN [dbo].[Warehouses] w ON s.WarehouseID = w.WarehouseID";
$stocksStmt = $conn->query($stocksSql);
$stocks = $stocksStmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Stock</title>
    <link rel="stylesheet" type="text/css" href="style.css">

</head>
<body>
    <?php include 'side_nav.php'; ?>
    <div class="main-content">
    <h2>Stock Management</h2>
    <table>
        <tr>
            <th>Article</th>
            <th>Warehouse</th>
            <th>Stock</th>
            <th>Action</th>
        </tr>
        <?php foreach ($stocks as $stock): ?>
        <form action="manage_stock.php" method="post">
            <tr>
                <td><?php echo htmlspecialchars($stock['ArticleName']); ?></td>
                <td><?php echo htmlspecialchars($stock['WarehouseName']); ?></td>
                <td><input type="number" name="stock" value="<?php echo $stock['Stock']; ?>"></td>
                <td>
                    <input type="submit" name="update" value="Update">
                </td>
            </tr>
        </form>
        <?php endforeach; ?>
        <form action="manage_stock.php" method="post">
            <tr>
                <td>
                    <select name="new_articleId">
                        <option value="">Select Article</option>
                        <?php foreach ($articles as $article): ?>
                        <option value="<?php echo $article['ArticleID']; ?>"><?php echo htmlspecialchars($article['Name']); ?></option>
                        <?php endforeach; ?>
                    </select>
                </td>
                <td>
                    <select name="new_warehouseId">
                        <option value="">Select Warehouse</option>
                        <?php foreach ($warehouses as $warehouse): ?>
                        <option value="<?php echo $warehouse['WarehouseID']; ?>"><?php echo htmlspecialchars($warehouse['Name']); ?></option>
                        <?php endforeach; ?>
                    </select>
                </td>
                <td><input type="number" name="new_stock"></td>
                <td><input type="submit" name="add" value="Add"></td>
            </tr>
        </form>
    </table>
    </div>
</body>
</html>
