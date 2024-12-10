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

$faunaId = $_GET['id'] ?? null;

// Ottieni i dati esistenti
$faunaData = [];
if ($faunaId) {
    $sql = "SELECT * FROM fauna WHERE fau_id = ?";
    $stmt = $connection->prepare($sql);
    $stmt->bind_param("i", $faunaId);
    $stmt->execute();
    $faunaData = $stmt->get_result()->fetch_assoc();
}

// Modifica l'animale
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $dex = $_POST['dex'];
    $sesso = $_POST['sesso'];
    $data_nascita = $_POST['data_nascita'];
    $stato_salute = $_POST['stato_salute'];
    $specie_id = $_POST['specie_id'];

    $updateSql = "UPDATE fauna SET fau_dex = ?, fau_sesso = ?, fau_data_nascita = ?, fau_stato_salute = ?, fau_specie_spf_id = ? 
                  WHERE fau_id = ?";
    $stmt = $connection->prepare($updateSql);
    $stmt->bind_param("ssssii", $dex, $sesso, $data_nascita, $stato_salute, $specie_id, $faunaId);

    if ($stmt->execute()) {
        // Reindirizza alla pagina principale
        header("Location: login.php");
        exit();
    } else {
        echo "<h2>Errore durante la modifica del record: " . $stmt->error . "</h2>";
    }
}
?>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifica Fauna</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Modifica Animale</h1>
    <form method="POST" action="">
        <label for="dex">Descrizione:</label>
        <input type="text" name="dex" value="<?php echo htmlspecialchars($faunaData['fau_dex'] ?? ''); ?>" required><br>

        <label for="sesso">Sesso:</label>
        <input type="radio" name="sesso" value="M" <?php echo ($faunaData['fau_sesso'] ?? '') === 'M' ? 'checked' : ''; ?> required> Maschio
        <input type="radio" name="sesso" value="F" <?php echo ($faunaData['fau_sesso'] ?? '') === 'F' ? 'checked' : ''; ?> required> Femmina<br>

        <label for="data_nascita">Data di nascita:</label>
        <input type="date" name="data_nascita" value="<?php echo htmlspecialchars($faunaData['fau_data_nascita'] ?? ''); ?>" required><br>

        <label for="stato_salute">Stato di salute:</label>
        <input type="radio" name="stato_salute" value="S" <?php echo ($faunaData['fau_stato_salute'] ?? '') === 'S' ? 'checked' : ''; ?> required> Salute
        <input type="radio" name="stato_salute" value="M" <?php echo ($faunaData['fau_stato_salute'] ?? '') === 'M' ? 'checked' : ''; ?> required> Malato
        <input type="radio" name="stato_salute" value="D" <?php echo ($faunaData['fau_stato_salute'] ?? '') === 'D' ? 'checked' : ''; ?> required> Deceduto<br>

        <label for="specie_id">Specie:</label>
        <select name="specie_id" required>
            <?php
            // Ottieni la lista delle specie
            $specieQuery = "SELECT sfa_id, sfa_dex FROM specie_fauna";
            $specieResult = $connection->query($specieQuery);
            while ($specieRow = $specieResult->fetch_assoc()) {
                $selected = ($specieRow['sfa_id'] == ($faunaData['fau_specie_spf_id'] ?? '')) ? 'selected' : '';
                echo "<option value='" . $specieRow['sfa_id'] . "' $selected>" . $specieRow['sfa_dex'] . "</option>";
            }
            ?>
        </select><br>

        <button type="submit">Salva</button>
    </form>
    <br>
    <a href="tables.php">Torna alla pagina principale</a>
</body>
</html>
