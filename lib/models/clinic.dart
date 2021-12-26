import 'dart:convert';

import 'package:faya_clinic/models/sub_category.dart';

Clinic clinicFromJson(String str) => Clinic.fromJson(json.decode(str));

String clinicToJson(Clinic data) => json.encode(data.toJson());

class Clinic {
  Clinic({
    this.id,
    this.title,
    this.subCategories,
  });

  String id;
  String title;
  String sectionId;
  String subSectionId;
  List<SubCategory> subCategories;

  factory Clinic.fromJson(Map<String, dynamic> json) => Clinic(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        subCategories: json["subCategories"] == null ? null : json["subCategories"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subCategories": subCategories == null ? null : List<dynamic>.from(subCategories.map((x) => x)),
      };
}
