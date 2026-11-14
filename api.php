<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

$host = "localhost";
$user = "root";
$pass = "";
$dbname = "db_logistik_rs";

$conn = @new mysqli($host, $user, $pass, $dbname);
if ($conn->connect_error) {
    echo json_encode(["status" => "fallback_local", "message" => "Menggunakan mode mandiri (Import database.sql ke phpMyAdmin untuk mengaktifkan MySQL)"]);
    exit;
}

$action = $_GET['action'] ?? 'katalog';
if ($action === 'katalog') {
    $res = $conn->query("SELECT * FROM katalog");
    echo json_encode($res->fetch_all(MYSQLI_ASSOC));
} elseif ($action === 'iklan') {
    $res = $conn->query("SELECT * FROM config_iklan WHERE id=1");
    echo json_encode($res->fetch_assoc());
}
?>