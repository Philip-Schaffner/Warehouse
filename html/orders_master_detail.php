<?php
session_start();

if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    header('Location: login.php');
    exit;
}

include 'db.php';

// Fetch order statuses for dropdown
$statusesSql = "SELECT StatusID, Status FROM OrderStatuses";
$statusesStmt = $conn->query($statusesSql);
$statuses = $statusesStmt->fetchAll(PDO::FETCH_ASSOC);

// Handle status update
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['updateStatus'])) {
    $orderId = $_POST['orderId'];
    $statusId = $_POST['status'];

    $updateStatusSql = "UPDATE Orders SET Status = ? WHERE OrderID = ?";
    $updateStatusStmt = $conn->prepare($updateStatusSql);
    $updateStatusStmt->execute([$statusId, $orderId]);

    header("Location: orders_master_detail.php"); // Refresh the page
    exit();
}

// Fetch all orders
$ordersSql = "SELECT o.OrderID, c.Firstname, c.Lastname, os.Status, o.OrderDate FROM Orders o JOIN Clients c ON o.ClientID = c.ClientID JOIN OrderStatuses os ON o.Status = os.StatusID";
$ordersStmt = $conn->query($ordersSql);
$orders = $ordersStmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Orders Master-Detail</title>
    <link rel="stylesheet" type="text/css" href="style.css">

</head>
<body>
    <?php include 'side_nav.php'; ?>
    <div class="main-content">
    <h2>Orders</h2>
    <?php foreach ($orders as $order): ?>
        <div>
            <h3>Order ID: <?php echo $order['OrderID']; ?></h3>
            <p>Client: <?php echo htmlspecialchars($order['Firstname'] . ' ' . $order['Lastname']); ?></p>
            <p>Order Date: <?php echo $order['OrderDate']; ?></p>
            <form action="orders_master_detail.php" method="post">
                <label>Status:</label>
                <select name="status">
                    <?php foreach ($statuses as $status): ?>
                            <option value="<?php echo $status['StatusID']; ?>" <?php echo $status['Status'] == $order['Status'] ? 'selected' : ''; ?>>
                            <?php echo htmlspecialchars($status['Status']); ?>
                        </option>
                    <?php endforeach; ?>
                </select>
                <input type="hidden" name="orderId" value="<?php echo $order['OrderID']; ?>">
                <input type="submit" name="updateStatus" value="Update Status">
            </form>

            <table>
                <tr>
                    <th>Article</th>
                    <th>Quantity</th>
                </tr>
                <?php
                // Fetch order details
                    $detailsSql = "SELECT ad.Quantity, a.Name FROM OrderDetails ad JOIN Articles a ON ad.ArticleID = a.ArticleID WHERE ad.OrderID = ?";
                $detailsStmt = $conn->prepare($detailsSql);
                $detailsStmt->execute([$order['OrderID']]);
                $details = $detailsStmt->fetchAll(PDO::FETCH_ASSOC);

                foreach ($details as $detail): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($detail['Name']); ?></td>
                        <td><?php echo $detail['Quantity']; ?></td>
                    </tr>
                <?php endforeach; ?>
            </table>
        </div>
    <?php endforeach; ?>
    </div>
</body>
</html>
