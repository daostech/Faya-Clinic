import 'dart:convert';

import 'package:faya_clinic/models/user_date/section.dart';
import 'package:faya_clinic/models/user_date/service.dart';
import 'package:faya_clinic/models/user_date/sub_section.dart';

List<UserDate2> userDateFromJson(String str) =>
    List<UserDate2>.from(json.decode(str).map((x) => UserDate2.fromJson(x)));

String userDateToJson(List<UserDate2> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserDate2 {
  UserDate2({
    this.id,
    this.userId,
    this.time,
    this.creationDate,
    this.registeredDate,
    this.status,
    this.sections,
    this.subSection,
    this.services,
  });

  String id;
  String userId;
  String time;
  DateTime creationDate;
  DateTime registeredDate;
  String status;
  Sections sections;
  SubSection subSection;
  List<Service> services;

  factory UserDate2.fromJson(Map<String, dynamic> json) => UserDate2(
        id: json["id"],
        userId: json["userId"],
        time: json["time"],
        creationDate: DateTime.parse(json["creationDate"]),
        registeredDate: DateTime.parse(json["registeredDate"]),
        status: json["status"],
        sections: Sections.fromJson(json["sections"]),
        subSection: SubSection.fromJson(json["subSection"]),
        services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "time": time,
        "creationDate": creationDate.toIso8601String(),
        "registeredDate": registeredDate.toIso8601String(),
        "status": status,
        "sections": sections.toJson(),
        "subSection": subSection.toJson(),
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
      };
}
