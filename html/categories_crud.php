<?php
session_start();

if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    header('Location: login.php');
    exit;
}

include 'db.php'; // Include your database connection

// Delete category
if (isset($_GET['delete'])) {
    $id = $_GET['delete'];
    $sql = "DELETE FROM [dbo].[Categories] WHERE CategoryID = ?";
    $stmt = $conn->prepare($sql);
    $stmt->execute([$id]);
    header("Location: categories_crud.php"); // Redirect to avoid resubmission
    exit();
}

// Add category
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name = $_POST['name'];
    $description = $_POST['description'];

    $sql = "INSERT INTO [dbo].[Categories] (Name, Description) VALUES (?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->execute([$name, $description]);
    header("Location: categories_crud.php"); // Redirect to refresh the page and list
    exit();
}

// List categories
$sql = "SELECT CategoryID, Name, Description FROM [dbo].[Categories]";
$stmt = $conn->query($sql);
$categories = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Categories Management</title>
    <link rel="stylesheet" type="text/css" href="style.css">

</head>
<body>
    <?php include 'side_nav.php'; ?>
    <div class="main-content">
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Actions</th>
        </tr>
        <?php foreach ($categories as $category): ?>
        <tr>
            <td><?php echo htmlspecialchars($category['CategoryID']); ?></td>
            <td><?php echo htmlspecialchars($category['Name']); ?></td>
            <td><?php echo htmlspecialchars($category['Description']); ?></td>
            <td>
                <a href="categories_edit.php?id=<?php echo $category['CategoryID']; ?>">Edit</a> 
                <a href="?delete=<?php echo $category['CategoryID']; ?>" onclick="return confirm('Are you sure?');">Delete</a>
            </td>
        </tr>
        <?php endforeach; ?>
        <form action="categories_crud.php" method="post">
            <tr>
                <td>#</td>
                <td><input type="text" name="name" required></td>
                <td><input type="text" name="description"></td>
                <td><input type="submit" value="Add"></td>
            </tr>
        </form>
    </table>
    </div>
</body>
</html>
