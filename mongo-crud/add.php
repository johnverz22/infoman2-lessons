<?php
require 'db.php';

//set content to json
header('Content-Type: application/json');

//fetch JSON data from request
$request_data = json_decode(file_get_contents('php://input'), true);

//insert data to database
if (!empty($request_data['name'])) {
    $name = $request_data['name'] ?? '';
    $description = $request_data['description'] ?? '';
    $price = $request_data['price'] ?? 0;

    $db->products->insertOne([
        'name' => $name,
        'description' => $description,
        'price' => $price,
    ]);

    //send response
    echo json_encode(['success' => 'Data has been saved.']);
}
