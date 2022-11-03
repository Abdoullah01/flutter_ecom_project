// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

/* import 'dart:convert';

List<Category> categoryFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
    Category({
        required this.id,
        required this.name,
        required this.parentId,
        required this.childId,
    });

    int id;
    String name;
    List<String> parentId;
    List<String> childId;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
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
 */