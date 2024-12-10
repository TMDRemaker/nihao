<?php
if (!isset($_SESSION)) {
    session_start();
}

$serverName = "localhost";
$dbUsername = "root";
$dbPassword = "";
$dbName = "5dzhengfujie";

// Creare una connessione al database
$connection = new mysqli($serverName, $dbUsername, $dbPassword, $dbName);
if ($connection->connect_error) {
    die("Connessione fallita: " . $connection->connect_error);
}

$parcoId = $_SESSION['parcoId'] ?? null;

// Aggiungi un nuovo animale
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $dex = $_POST['dex'];
    $sesso = $_POST['sesso'];
    $data_nascita = $_POST['data_nascita'];
    $stato_salute = $_POST['stato_salute'];
    $specie_id = $_POST['specie_id'];

    $addSql = "INSERT INTO fauna (fau_dex, fau_sesso, fau_data_nascita, fau_stato_salute, fau_parco_id, fau_specie_spf_id) 
               VALUES (?, ?, ?, ?, ?, ?)";
    $stmt = $connection->prepare($addSql);
    $stmt->bind_param("ssssii", $dex, $sesso, $data_nascita, $stato_salute, $parcoId, $specie_id);

    if ($stmt->execute()) {
        // Reindirizza alla pagina principale
        header("Location: login.php?username=" . urlencode($inputUsername) . "&password=" . urlencode($inputPassword));
        exit();

    } else {
        echo "<h2>Errore durante l'aggiunta del record: " . $stmt->error . "</h2>";
    }
}
?>

<!DOCTYPE html>
<html lang="it">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aggiungi Fauna</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>
    <h1>Aggiungi Nuovo Animale</h1>
    <form method="POST" action="">
        <label for="dex">Descrizione:</label>
        <input type="text" name="dex" required><br>

        <label for="sesso">Sesso:</label>
        <input type="radio" name="sesso" value="M" required> Maschio
        <input type="radio" name="sesso" value="F" required> Femmina<br>

        <label for="data_nascita">Data di nascita:</label>
        <input type="date" name="data_nascita" required><br>

        <label for="stato_salute">Stato di salute:</label>
        <input type="radio" name="stato_salute" value="S" required> Salute
        <input type="radio" name="stato_salute" value="M" required> Malato
        <input type="radio" name="stato_salute" value="D" required> Deceduto<br>

        <label for="specie_id">Specie:</label>
        <select name="specie_id" required>
            <?php
            // Ottieni la lista delle specie
            $specieQuery = "SELECT sfa_id, sfa_dex FROM specie_fauna";
            $specieResult = $connection->query($specieQuery);
            while ($specieRow = $specieResult->fetch_assoc()) {
                echo "<option value='" . $specieRow['sfa_id'] . "'>" . $specieRow['sfa_dex'] . "</option>";
            }
            ?>
        </select><br>

        <button type="submit">Aggiungi</button>
    </form>
    <br>
    <a href="tables.php">Torna alla pagina principale</a>

</body>

</html>