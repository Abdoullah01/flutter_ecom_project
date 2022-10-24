// To parse this JSON data, do
//
//     final product = productFromMap(jsonString);

import 'dart:convert';

Product productFromMap(String str) => Product.fromMap(json.decode(str));

String productToMap(Product data) => json.encode(data.toMap());

class Product {
    Product({
        required this.params,
    });

    Params params;

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        params: Params.fromMap(json["params"]),
    );

    Map<String, dynamic> toMap() => {
        "params": params.toMap(),
    };
}

class Params {
    Params({
        required this.orderData,
    });

    List<OrderDatum> orderData;

    factory Params.fromMap(Map<String, dynamic> json) => Params(
        orderData: List<OrderDatum>.from(json["order_data"].map((x) => OrderDatum.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "order_data": List<dynamic>.from(orderData.map((x) => x.toMap())),
    };
}

class OrderDatum {
    OrderDatum({
        required this.productId,
        required this.quantity,
    });

    int productId;
    int quantity;

    factory OrderDatum.fromMap(Map<String, dynamic> json) => OrderDatum(
        productId: json["product_id"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toMap() => {
        "product_id": productId,
        "quantity": quantity,
    };
}
