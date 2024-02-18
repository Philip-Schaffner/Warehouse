<?php
session_start();

if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    header('Location: login.php');
    exit;
}

include 'db.php'; 

// Delete client
if (isset($_GET['delete'])) {
    $id = $_GET['delete'];
    $sql = "DELETE FROM [dbo].[Clients] WHERE ClientID = ?";
    $stmt = $conn->prepare($sql);
    $stmt->execute([$id]);
    header("Location: clients_crud.php"); // Redirect to avoid resubmission
    exit();
}

// Add client
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $firstname = $_POST['firstname'];
    $lastname = $_POST['lastname'];
    $email = $_POST['email'];
    $phone = $_POST['phone'];

    $sql = "INSERT INTO [dbo].[Clients] (Firstname, Lastname, Email, Phone) VALUES (?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->execute([$firstname, $lastname, $email, $phone]);
    header("Location: clients_crud.php"); // Redirect to refresh the page and list
    exit();
}

// List clients
$sql = "SELECT ClientID, Firstname, Lastname, Email, Phone FROM [dbo].[Clients]";
$stmt = $conn->query($sql);
$clients = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Clients Management</title>
    <link rel="stylesheet" type="text/css" href="style.css">

</head>
<body>
    <?php include 'side_nav.php'; ?>
    <div class="main-content">
    <table>
        <tr>
            <th>ID</th>
            <th>Fistname</th>
            <th>Lastname</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Actions</th>
        </tr>
        <?php foreach ($clients as $client): ?>
        <tr>
            <td><?php echo htmlspecialchars($client['ClientID']); ?></td>
            <td><?php echo htmlspecialchars($client['Firstname']); ?></td>
            <td><?php echo htmlspecialchars($client['Lastname']); ?></td>
            <td><?php echo htmlspecialchars($client['Email']); ?></td>
            <td><?php echo htmlspecialchars($client['Phone']); ?></td>
            <td>
                <a href="clients_edit.php?id=<?php echo $client['ClientID']; ?>">Edit</a>
                <a href="?delete=<?php echo $client['ClientID']; ?>" onclick="return confirm('Are you sure?');">Delete</a>
            </td>
        </tr>
        <?php endforeach; ?>
        <form action="clients_crud.php" method="post">
            <tr>
                <td>#</td>
                <td><input type="text" name="firstname" required></td>
                <td><input type="text" name="lastname" required></td>
                <td><input type="email" name="email"></td>
                <td><input type="text" name="phone"></td>
                <td><input type="submit" value="Add"></td>
            </tr>
        </form>
    </table>
    </div>
</body>
</html>
