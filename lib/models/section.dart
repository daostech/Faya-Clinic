import 'dart:convert';

import 'package:faya_clinic/common/listable.dart';
import 'package:faya_clinic/constants/config.dart';

Section sectionFromJson(String str) => Section.fromJson(json.decode(str));

String sectionToJson(Section data) => json.encode(data.toJson());

class Section implements ListAble {
  Section({
    this.id,
    this.name,
    this.image,
    this.description,
  });

  String id;
  String name;
  String image;
  String description;

  // the image comes from the response hold the file name only
  // so we add the base url prefix in order to load the image properly
  String get imageUrl => "${AppConfig.RAW_BASE_URL}/$image";

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? null : json["image"],
        description: json["text"] == null ? null : json["text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "text": description,
      };
  @override
  bool containsKeyword(String keyword) {
    return name.toLowerCase().contains(keyword.toLowerCase());
  }

  @override
  String get titleValue => name;
}
