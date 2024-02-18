<?php
session_start(); // Start the session at the beginning of the script

$host = 'PSTHINKPAD\SQLEXPRESS'; // or your host
$dbname = 'M321';
$dbuser = 'pw_checker';
$dbpass = 'pw_checker';

// Specify the character set
$charset = 'UTF-8';

// Check if the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST['username'];
    $password = $_POST['password'];

    try {
        // Change the connection string for MS SQL Server
        $pdo = new PDO("sqlsrv:Server=$host;Database=$dbname", $dbuser, $dbpass);
        // Set the PDO error mode to exception
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $stmt = $pdo->prepare("SELECT UserID, Username, Password FROM Users WHERE Username = :username");
        $stmt->bindParam(':username', $username, PDO::PARAM_STR);
        $stmt->execute();	

		$user = $stmt->fetch(PDO::FETCH_ASSOC); // Attempt to fetch a row
		
        if ($user) {
            if ($password == $user['Password']) {
                // Password is correct, so start a new session
                $_SESSION['loggedin'] = true;
                $_SESSION['UserID'] = $user['UserID'];
                $_SESSION['Username'] = $user['Username'];
                
                // Redirect user to welcome page
                header("location: welcome.php");
            } else {
                // Display an error message if password is not valid
                echo "The password you entered was not valid.";
            }
        } else {
            // Display an error message if username doesn't exist
            echo "No account found with that username.";
        }
    } catch (PDOException $e) {
        die("Error: " . $e->getMessage());
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="style.css">

</head>
<body>
    <div class="main-content">
    <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
        <div>
            <label>Username</label>
            <input type="text" name="username" required>
        </div>
        <div>
            <label>Password</label>
            <input type="password" name="password" required>
        </div>
        <div>
            <input type="submit" value="Login">
        </div>
    </form>
    </div>
</body>
</html>
