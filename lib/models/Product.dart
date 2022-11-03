// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

/* List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson()))); */

/* class Product {
    Product({
        required this.id,
        required this.name,
        required this.productVariantCount,
        required this.listPrice,
        required this.descriptionSale,
        required this.productVariantIds,
        required this.image1920,
    });

    int id;
    String name;
    int productVariantCount;
    double listPrice;
    dynamic descriptionSale;
    ProductVariantIds productVariantIds;
    String image1920;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        productVariantCount: json["product_variant_count"],
        listPrice: json["list_price"].toDouble(),
        descriptionSale: json["description_sale"],
        productVariantIds: ProductVariantIds.fromJson(json["product_variant_ids"]),
        image1920: json["image_1920"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "product_variant_count": productVariantCount,
        "list_price": listPrice,
        "description_sale": descriptionSale,
        "product_variant_ids": productVariantIds.toJson(),
        "image_1920": image1920,
    };
}

class ProductVariantIds {
    ProductVariantIds({
        required this.imageVariant1920,
        required this.lstPrice,
    });

    List<String> imageVariant1920;
    List<double> lstPrice;

    factory ProductVariantIds.fromJson(Map<String, dynamic> json) => ProductVariantIds(
        imageVariant1920: List<String>.from(json["image_variant_1920"].map((x) => x)),
        lstPrice: List<double>.from(json["lst_price"].map((x) => x.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "image_variant_1920": List<dynamic>.from(imageVariant1920.map((x) => x)),
        "lst_price": List<dynamic>.from(lstPrice.map((x) => x)),
    };
} */


// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);



List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
    Product({
        required this.id,
        required this.name,
        required this.listPrice,
        this.descriptionSale,
        required this.productVariantIds,
        required this.attributeLineIds,
        required this.publicCategIds,
        required this.image1920,
    });

    int id;
    String name;
    double listPrice;
    dynamic descriptionSale;
    ProductVariantIds productVariantIds;
    AttributeLineIds attributeLineIds;
    PublicCategIds publicCategIds;
    String image1920;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        listPrice: json["list_price"].toDouble(),
        descriptionSale: json["description_sale"],
        productVariantIds: ProductVariantIds.fromJson(json["product_variant_ids"]),
        attributeLineIds: AttributeLineIds.fromJson(json["attribute_line_ids"]),
        publicCategIds: PublicCategIds.fromJson(json["public_categ_ids"]),
        image1920: json["image_1920"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "list_price": listPrice,
        "description_sale": descriptionSale,
        "product_variant_ids": productVariantIds.toJson(),
        "attribute_line_ids": attributeLineIds.toJson(),
        "public_categ_ids": publicCategIds.toJson(),
        "image_1920": image1920,
    };
}

class AttributeLineIds {
    AttributeLineIds({
        required this.attributeId,
    });

    List<String> attributeId;

    factory AttributeLineIds.fromJson(Map<String, dynamic> json) => AttributeLineIds(
        attributeId: List<String>.from(json["attribute_id"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "attribute_id": List<dynamic>.from(attributeId.map((x) => x)),
    };
}

class ProductVariantIds {
    ProductVariantIds({
        required this.id,
        required this.imageVariant1920,
        required this.lstPrice,
    });

    List<int> id;
    List<String> imageVariant1920;
    List<double> lstPrice;

    factory ProductVariantIds.fromJson(Map<String, dynamic> json) => ProductVariantIds(
        id: List<int>.from(json["id"].map((x) => x)),
        imageVariant1920: List<String>.from(json["image_variant_1920"].map((x) => x)),
        lstPrice: List<double>.from(json["lst_price"].map((x) => x.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "id": List<dynamic>.from(id.map((x) => x)),
        "image_variant_1920": List<dynamic>.from(imageVariant1920.map((x) => x)),
        "lst_price": List<dynamic>.from(lstPrice.map((x) => x)),
    };
}

class PublicCategIds {
    PublicCategIds({
        required this.id,
        required this.name,
        required this.parentId,
        required this.childId,
    });

    dynamic id;
    dynamic name;
    List<String> parentId;
    List<String> childId;

    factory PublicCategIds.fromJson(Map<String, dynamic> json) => PublicCategIds(
        id: json["id"],
        name: json["name"],
        parentId: List<String>.from(json["parent_id"].map((x) => x)),
        childId: List<String>.from(json["child_id"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "parent_id": List<dynamic>.from(parentId.map((x) => x)),
        "child_id": List<dynamic>.from(childId.map((x) => x)),
    };
}

List<Category> categoryFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
    Category({
        required this.id,
        required this.name,
        required this.image1920,
        required this.parentId,
        required this.childId,
    });

    int id;
    String name;
    dynamic image1920;
    List<String> parentId;
    List<String> childId;

      factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image1920: json["image_1920"],
        parentId: List<String>.from(json["parent_id"].map((x) => x)),
        childId: List<String>.from(json["child_id"].map((x) => x)),
    );

     Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_1920": image1920,
        "parent_id": List<dynamic>.from(parentId.map((x) => x)),
        "child_id": List<dynamic>.from(childId.map((x) => x)),
    };
}























































/* import 'package:flutter/material.dart';

class Product {
  final int id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;

  Product({
    required this.id,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
  });
}

// Our demo Products

List<Product> demoProducts = [
  Product(
    id: 1,
    images: [
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Wireless Controller for PS4™",
    price: 64.99,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 2,
    images: [
      "assets/images/Image Popular Product 2.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Nike Sport White - Man Pant",
    price: 50.5,
    description: description,
    rating: 4.1,
    isPopular: true,
  ),
  Product(
    id: 3,
    images: [
      "assets/images/glap.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Gloves XC Omega - Polygon",
    price: 36.55,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 4,
    images: [
      "assets/images/wireless headset.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Logitech Head",
    price: 20.20,
    description: description,
    rating: 4.1,
    isFavourite: true,
  ),
];

const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
 */