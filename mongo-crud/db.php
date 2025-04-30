<?php
require 'vendor/autoload.php'; //include classes from composer

use MongoDB\Client; //import Client class

define("DB_NAME", "products_db"); //create a constant to save the database name

try {
    $client = new Client("mongodb://localhost:27017"); //initialize connection
    $db = $client->selectDatabase(DB_NAME);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Could not connect to MongoDB']);
}
