<?php
if (!isset($_SESSION)) {
    session_start();
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $serverName = "localhost";
    $dbUsername = "root"; 
    $dbPassword = "";     
    $dbName = "5dzhengfujie";     

    // 
    $connection = new mysqli($serverName, $dbUsername, $dbPassword, $dbName);

    if ($connection->connect_error) {
        die("Connection failed: " . $connection->connect_error);
    }

    $inputUsername = $_POST['username'];
    $inputPassword = $_POST['password'];

    $sql = "SELECT gua_parco_id FROM gurdia_parco WHERE gua_utente = ? AND gua_password = ?";
    $stmt = $connection->prepare($sql);
    $stmt->bind_param("ss", $inputUsername, $inputPassword);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $parcoID = $row['gua_parco_id']; 
        $_SESSION['parcoId'] = $parcoID;

        header("Location: tables.php");
        exit();
    } else {
        echo "<h2>Password o nome utente errati</h2>";
    }

    $stmt->close();
    $connection->close();
}
?>
