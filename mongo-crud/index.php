<?php
require 'db.php';

//set content to json
header('Content-Type: application/json');

//read data and return
$products = $db->products->find();

$return_data = [];

foreach ($products as $product) {
    $product['_id'] = (string) $product['_id'];
    $return_data[] = $product;
}

echo json_encode($return_data);
