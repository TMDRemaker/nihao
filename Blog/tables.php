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

// Elimina
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'delete') {
    if (isset($_POST['id'])) {
        $faunaId = $_POST['id'];
        deleteAnimal($connection, $faunaId);
    }
}

// Funzione per ottenere la fauna per parco_id
function getFaunaByParcoId($connection, $parcoId)
{
    $sql = "SELECT fau_id, fau_dex, fau_sesso, fau_data_nascita, fau_stato_salute FROM fauna WHERE fau_parco_id = ?";
    $stmt = $connection->prepare($sql);
    $stmt->bind_param("i", $parcoId);
    $stmt->execute();
    return $stmt->get_result();
}

// Funzione per eliminare un animale
function deleteAnimal($connection, $faunaId)
{
    $deleteSql = "DELETE FROM fauna WHERE fau_id = ?";
    $stmt = $connection->prepare($deleteSql);
    $stmt->bind_param("i", $faunaId);
    $stmt->execute();
}

// Funzione per generare la tabella HTML
function renderFaunaTable($connection, $parcoId)
{
    $resultFauna = getFaunaByParcoId($connection, $parcoId);
    if ($resultFauna->num_rows > 0) {
        echo "<table border='1' style='width: 80%; margin: 20px auto; border-collapse: collapse;'>";
        echo "<tr>";
        echo "<th>Descrizione</th>";
        echo "<th>Sesso</th>";
        echo "<th>Data di nascita</th>";
        echo "<th>Stato di salute</th>";
        echo "<th>Operazioni</th>";
        echo "</tr>";
        while ($rowFauna = $resultFauna->fetch_assoc()) {
            echo "<tr>";
            echo "<td>" . htmlspecialchars($rowFauna['fau_dex']) . "</td>";
            echo "<td>" . htmlspecialchars($rowFauna['fau_sesso']) . "</td>";
            echo "<td>" . htmlspecialchars($rowFauna['fau_data_nascita']) . "</td>";
            echo "<td>" . htmlspecialchars($rowFauna['fau_stato_salute']) . "</td>";
            echo "<td>";
            // 
            echo "<form action='' method='POST' style='display:inline;'>";
            echo "<input type='hidden' name='action' value='delete'>";
            echo "<input type='hidden' name='id' value='" . htmlspecialchars($rowFauna['fau_id']) . "'>";
            echo "<button type='submit'>Elimina</button>";
            echo "</form> | ";
            // 
            echo "<form action='editFauna.php' method='GET' style='display:inline;'>";
            echo "<input type='hidden' name='id' value='" . htmlspecialchars($rowFauna['fau_id']) . "'>";
            echo "<button type='submit'>Modifica</button>";
            echo "</form>";
            echo "</td>";
            echo "</tr>";
        }
        echo "<tr>";
        echo "<td colspan='5' style='text-align:center;'>";
        // 
        echo "<form action='addFauna.php' method='GET' style='display:inline;'>";
        echo "<button type='submit'>Aggiungi Nuovo</button>";
        echo "</form>";
        echo "</td>";
        echo "</tr>";
        echo "</table>";
    } else {
        echo "<h2 style='text-align: center;'>Nessun dato trovato.</h2>";
        echo "<div style='text-align:center;'>";
        echo "<form action='addFauna.php' method='GET' style='display:inline;'>";
        echo "<button type='submit'>Aggiungi Nuovo</button>";
        echo "</form>";
        echo "</div>";
    }
}

?>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestione Fauna</title>
    <link rel="stylesheet" href="styleTables.css">
</head>
<body>
    <h1 style="text-align: center;">Gestione Fauna</h1>
    <?php
    // Visualizza la tabella
    echo $parcoId;
    if ($parcoId != 0 || $parcoId!= null) {
        renderFaunaTable($connection, $parcoId);
    } else {
        echo "<h2 style='text-align: center;'>Errore: parcoId non trovato.</h2>";
    }
    ?>
</body>
</html>
