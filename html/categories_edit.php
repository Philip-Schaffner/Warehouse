<?php
session_start();

if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    header('Location: login.php');
    exit;
}

include 'db.php'; // Include your database connection

// Check if the category ID is present
if (isset($_GET['id'])) {
    $categoryId = $_GET['id'];

    // Fetch category details
    $sql = "SELECT CategoryID, Name, Description FROM [dbo].[Categories] WHERE CategoryID = ?";
    $stmt = $conn->prepare($sql);
    $stmt->execute([$categoryId]);
    $category = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$category) {
        die('Category not found.');
    }
} else {
    die('Category ID not specified.');
}

// Update category details
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['update'])) {
    $name = $_POST['name'];
    $description = $_POST['description'];

    $updateSql = "UPDATE [dbo].[Categories] SET Name = ?, Description = ? WHERE CategoryID = ?";
    $updateStmt = $conn->prepare($updateSql);
    $updateStmt->execute([$name, $description, $categoryId]);

    header("Location: categories_crud.php"); // Redirect to the categories CRUD page
    exit();
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Category</title>
    <link rel="stylesheet" type="text/css" href="style.css">

</head>
<body>
    <?php include 'side_nav.php'; ?>
    <div class="main-content">
    <h2>Edit Category</h2>
    <form action="categories_edit.php?id=<?php echo htmlspecialchars($categoryId); ?>" method="post">
        <div>
            <label>Name:</label>
            <input type="text" name="name" value="<?php echo htmlspecialchars($category['Name']); ?>" required>
        </div>
        <div>
            <label>Description:</label>
            <input type="text" name="description" value="<?php echo htmlspecialchars($category['Description']); ?>">
        </div>
        <div>
            <input type="submit" name="update" value="Update">
        </div>
    </form>
    </div>
</body>
</html>
