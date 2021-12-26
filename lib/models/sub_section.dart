import 'dart:convert';

SubSection subSectionFromJson(String str) => SubSection.fromJson(json.decode(str));

String subSectionToJson(SubSection data) => json.encode(data.toJson());

class SubSection {
  SubSection({
    this.id,
    this.name,
    this.sectionId,
  });

  String id;
  String name;
  String sectionId;
  List<dynamic> sections; // ! what sections

  factory SubSection.fromJson(Map<String, dynamic> json) => SubSection(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        sectionId: json["sectionId"] == null ? null : json["sectionId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sectionId": sectionId,
      };
}
