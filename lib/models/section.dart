import 'dart:convert';

Section sectionFromJson(String str) => Section.fromJson(json.decode(str));

String sectionToJson(Section data) => json.encode(data.toJson());

class Section {
  Section({
    this.id,
    this.name,
    this.subSections,
  });

  String id;
  String name;
  List<dynamic> subSections;

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"] == null ? null : json["id"],
        name: json["dateId"] == null ? null : json["dateId"],
        subSections: json["subSections"] == null ? null : List<dynamic>.from(json["subSections"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dateId": name,
        "subSections": subSections == null ? null : List<dynamic>.from(subSections.map((x) => x)),
      };
}
