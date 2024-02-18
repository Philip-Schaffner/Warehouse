<?php
session_start();

if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    header('Location: login.php');
    exit;
}

include 'db.php'; // Include your database connection

// Check if the article ID is present
if (isset($_GET['id'])) {
    $articleId = $_GET['id'];

    // Fetch article details
    $sql = "SELECT ArticleID, Name, CategoryID, Price FROM [dbo].[Articles] WHERE ArticleID = ?";
    $stmt = $conn->prepare($sql);
    $stmt->execute([$articleId]);
    $article = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$article) {
        die('Article not found.');
    }

    // Fetch categories for the dropdown
    $categorySql = "SELECT CategoryID, Name FROM [dbo].[Categories]";
    $categoryStmt = $conn->query($categorySql);
    $categories = $categoryStmt->fetchAll(PDO::FETCH_ASSOC);
} else {
    die('Article ID not specified.');
}

// Update article details
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['update'])) {
    $name = $_POST['name'];
    $categoryID = $_POST['categoryID'];
    $price = $_POST['price'];

    $updateSql = "UPDATE [dbo].[Articles] SET Name = ?, CategoryID = ?, Price = ? WHERE ArticleID = ?";
    $updateStmt = $conn->prepare($updateSql);
    $updateStmt->execute([$name, $categoryID, $price, $articleId]);

    header("Location: articles_crud.php"); // Redirect to the articles CRUD page
    exit();
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Article</title>
    <link rel="stylesheet" type="text/css" href="style.css">

</head>
<body>
    <?php include 'side_nav.php'; ?>
    <div class="main-content">
    <h2>Edit Article</h2>
    <form action="articles_edit.php?id=<?php echo htmlspecialchars($articleId); ?>" method="post">
        <div>
            <label>Name:</label>
            <input type="text" name="name" value="<?php echo htmlspecialchars($article['Name']); ?>" required>
        </div>
        <div>
            <label>Category:</label>
            <select name="categoryID" required>
                <?php foreach ($categories as $category): ?>
                <option value="<?php echo $category['CategoryID']; ?>" <?php if ($category['CategoryID'] == $article['CategoryID']) echo 'selected'; ?>>
                    <?php echo htmlspecialchars($category['Name']); ?>
                </option>
                <?php endforeach; ?>
            </select>
        </div>
        <div>
            <label>Price:</label>
            <input type="text" name="price" value="<?php echo htmlspecialchars($article['Price']); ?>" required>
        </div>
        <div>
            <input type="submit" name="update" value="Update">
        </div>
    </form>
    </div>
</body>
</html>
