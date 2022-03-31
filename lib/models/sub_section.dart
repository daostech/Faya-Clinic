import 'dart:convert';

import 'package:faya_clinic/constants/config.dart';

SubSection subSectionFromJson(String str) => SubSection.fromJson(json.decode(str));

String subSectionToJson(SubSection data) => json.encode(data.toJson());

List<SubSection> subSectionsFromJson(List<dynamic> json) =>
    List<SubSection>.from(json.map((x) => SubSection.fromJson(x)));

class SubSection {
  SubSection({
    this.id,
    this.sectionId,
    this.name,
    this.text,
    this.description,
    this.img1,
    this.img2,
  });

  String id;
  String sectionId;
  String name;
  String text;
  String description;
  String img1;
  String img2;

  // the image comes from the response hold the file name only
  // so we add the base url prefix in order to load the image properly
  String get imageUrl => "${AppConfig.BASE_URL}$img1";

  factory SubSection.fromJson(Map<String, dynamic> json) => SubSection(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        sectionId: json["sectionId"] == null ? null : json["sectionId"],
        text: json["text"] == null ? null : json["text"],
        description: json["fullText"] == null ? null : json["fullText"],
        img1: json["img1"] == null ? null : json["img1"],
        img2: json["img2"] == null ? null : json["img2"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sectionId": sectionId,
        "text": text,
        "fullText": sectionId,
        "img1": img1,
        "img2": img2,
      };
}
