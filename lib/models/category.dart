import 'dart:convert';

import 'package:faya_clinic/models/sub_category.dart';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    this.id,
    this.name,
    this.subCategories,
  });

  String? id;
  String? name;
  List<SubCategory>? subCategories;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        subCategories: json["subCategories"] == null
            ? null
            : List<SubCategory>.from(json["subCategories"].map((x) => SubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "subCategories": subCategories == null ? null : List<SubCategory>.from(subCategories!.map((x) => x)),
      };
}
