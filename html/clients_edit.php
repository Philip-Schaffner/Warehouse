<?php
session_start();

if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    header('Location: login.php');
    exit;
}

include 'db.php'; 

// Check if the client ID is present
if (isset($_GET['id'])) {
    $clientId = $_GET['id'];

    // Fetch client details
    $sql = "SELECT ClientID, Firstname, Lastname, Email, Phone FROM [dbo].[Clients] WHERE ClientID = ?";
    $stmt = $conn->prepare($sql);
    $stmt->execute([$clientId]);
    $client = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$client) {
        die('Client not found.');
    }
} else {
    die('Client ID not specified.');
}

// Update client details
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['update'])) {
    $firstname = $_POST['firstname'];
    $lastname = $_POST['lastname'];
    $email = $_POST['email'];
    $phone = $_POST['phone'];

    $updateSql = "UPDATE [dbo].[Clients] SET Firstname = ?, Lastname = ?, Email = ?, Phone = ? WHERE ClientID = ?";
    $updateStmt = $conn->prepare($updateSql);
    $updateStmt->execute([$firstname, $lastname, $email, $phone, $clientId]);

    header("Location: clients_crud.php"); // Redirect to the clients CRUD page
    exit();
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Client</title>
    <link rel="stylesheet" type="text/css" href="style.css">

</head>
<body>
    <?php include 'side_nav.php'; ?>
    <div class="main-content">
    <h2>Edit Client</h2>
    <form action="clients_edit.php?id=<?php echo htmlspecialchars($clientId); ?>" method="post">
        <div>
            <label>Firstname:</label>
            <input type="text" name="firstname" value="<?php echo htmlspecialchars($client['Firstname']); ?>" required>
        </div>
        <div>
            <label>Lastname:</label>
            <input type="text" name="lastname" value="<?php echo htmlspecialchars($client['Lastname']); ?>" required>
        </div>
        <div>
            <label>Email:</label>
            <input type="email" name="email" value="<?php echo htmlspecialchars($client['Email']); ?>">
        </div>
        <div>
            <label>Phone:</label>
            <input type="text" name="phone" value="<?php echo htmlspecialchars($client['Phone']); ?>">
        </div>
        <div>
            <input type="submit" name="update" value="Update">
        </div>
    </form>
    </div>
</body>
</html>
