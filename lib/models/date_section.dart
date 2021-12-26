import 'dart:convert';

import 'package:faya_clinic/models/date_registered.dart';

DateSection dateSectionFromJson(String str) => DateSection.fromJson(json.decode(str));

String dateSectionToJson(DateSection data) => json.encode(data.toJson());

class DateSection {
  DateSection({
    this.id,
    this.dateId,
    this.sectionId,
    this.dateRegistered,
    this.section,
  });

  String id;
  String dateId;
  String sectionId;
  DateRegistered dateRegistered;
  dynamic section;

  factory DateSection.fromJson(Map<String, dynamic> json) => DateSection(
        id: json["id"] == null ? null : json["id"],
        dateId: json["dateId"] == null ? null : json["dateId"],
        sectionId: json["sectionId"] == null ? null : json["sectionId"],
        dateRegistered: json["dateRegistered"] == null ? null : json["dateRegistered"],
        section: json["section"] == null ? null : json["section"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dateId": dateId,
        "sectionId": sectionId,
        "dateRegistered": dateRegistered,
        "section": section,
      };
}
