import 'dart:convert';

SubCategory subCategoryFromJson(String str) => SubCategory.fromJson(json.decode(str));

String subCategoryToJson(SubCategory data) => json.encode(data.toJson());

List<SubCategory> subCategoriesFromJson(List<dynamic> json) =>
    List<SubCategory>.from(json.map((x) => SubCategory.fromJson(x)));

class SubCategory {
  SubCategory({
    this.id,
    this.name,
    this.categoryId,
  });

  String id;
  String name;
  String categoryId;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        categoryId: json["categoryId"] == null ? null : json["categoryId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "categoryId": categoryId,
      };
}
