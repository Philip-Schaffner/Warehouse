<?php
include 'db.php'; // Include your database connection

// Delete article
if (isset($_GET['delete'])) {
    $id = $_GET['delete'];
    $sql = "DELETE FROM [dbo].[Articles] WHERE ArticleID = ?";
    $stmt = $conn->prepare($sql);
    $stmt->execute([$id]);
    header("Location: articles_crud.php"); // Redirect to avoid resubmission
    exit();
}

// Add article
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name = $_POST['name'];
    $categoryID = $_POST['categoryID']; // Get category ID from the dropdown
    $price = $_POST['price'];

    $sql = "INSERT INTO [dbo].[Articles] (Name, CategoryID, Price) VALUES (?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->execute([$name, $categoryID, $price]);
    header("Location: articles_crud.php"); // Redirect to refresh the page and list
    exit();
}

// List articles
$sql = "SELECT ArticleID, Name, CategoryID, Price FROM [dbo].[Articles]";
$stmt = $conn->query($sql);
$articles = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Fetch categories for the dropdown
$categorySql = "SELECT CategoryID, Name FROM [dbo].[Categories]";
$categoryStmt = $conn->query($categorySql);
$categories = $categoryStmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Articles Management</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <?php include 'side_nav.php'; ?>
    <div class="main-content">
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Category</th>
            <th>Price</th>
            <th>Actions</th>
        </tr>
        <?php foreach ($articles as $article): ?>
        <tr>
            <td><?php echo htmlspecialchars($article['ArticleID']); ?></td>
            <td><?php echo htmlspecialchars($article['Name']); ?></td>
            <td><?php echo htmlspecialchars($article['CategoryID']); ?></td>
            <td><?php echo htmlspecialchars($article['Price']); ?></td>
            <td>
                <a href="articles_edit.php?id=<?php echo $article['ArticleID']; ?>">Edit</a>
                <a href="?delete=<?php echo $article['ArticleID']; ?>" onclick="return confirm('Are you sure?');">Delete</a>
            </td>
        </tr>
        <?php endforeach; ?>
        <form action="articles_crud.php" method="post">
            <tr>
                <td>#</td>
                <td><input type="text" name="name" required></td>
                <td>
                    <select name="categoryID" required>
                        <option value="">Select a category</option>
                        <?php foreach ($categories as $category): ?>
                        <option value="<?php echo $category['CategoryID']; ?>"><?php echo htmlspecialchars($category['Name']); ?></option>
                        <?php endforeach; ?>
                    </select>
                </td>
                <td><input type="text" name="price" required></td>
                <td><input type="submit" value="Add"></td>
            </tr>
        </form>
    </table>
    </div>
</body>
</html>
