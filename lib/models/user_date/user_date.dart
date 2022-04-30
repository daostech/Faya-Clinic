import 'dart:convert';

import 'package:faya_clinic/models/user_date/date_service.dart';
import 'package:faya_clinic/models/user_date/mobile_user.dart';
import 'package:faya_clinic/models/user_date/section.dart';

List<UserDate> userDateFromJson(String str) => List<UserDate>.from(json.decode(str).map((x) => UserDate.fromJson(x)));

String userDateToJson(List<UserDate> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserDate {
  UserDate({
    this.dateService,
    this.sections,
    this.mobileUsers,
    this.id,
    this.userId,
    this.time,
    this.creationDate,
    this.sectionId,
    this.subSectionId,
    this.registeredDate,
    this.userRole,
    this.userName,
    this.token,
    this.serviceIds,
  });

  List<DateService> dateService;
  Sections sections;
  MobileUsers mobileUsers;
  String id;
  String userId;
  String time;
  DateTime creationDate;
  String sectionId;
  String subSectionId;
  DateTime registeredDate;
  dynamic userRole;
  dynamic userName;
  dynamic token;
  dynamic serviceIds;

  factory UserDate.fromJson(Map<String, dynamic> json) => UserDate(
        dateService: List<DateService>.from(json["dateService"].map((x) => DateService.fromJson(x))),
        sections: Sections.fromJson(json["sections"]),
        mobileUsers: MobileUsers.fromJson(json["mobileUsers"]),
        id: json["id"],
        userId: json["userId"],
        time: json["time"],
        creationDate: DateTime.parse(json["creationDate"]),
        sectionId: json["sectionId"],
        subSectionId: json["subSectionId"],
        registeredDate: DateTime.parse(json["registeredDate"]),
        userRole: json["userRole"],
        userName: json["userName"],
        token: json["token"],
        serviceIds: json["serviceIds"],
      );

  Map<String, dynamic> toJson() => {
        "dateService": List<dynamic>.from(dateService.map((x) => x.toJson())),
        "sections": sections.toJson(),
        "mobileUsers": mobileUsers.toJson(),
        "id": id,
        "userId": userId,
        "time": time,
        "creationDate": creationDate.toIso8601String(),
        "sectionId": sectionId,
        "subSectionId": subSectionId,
        "registeredDate": registeredDate.toIso8601String(),
        "userRole": userRole,
        "userName": userName,
        "token": token,
        "serviceIds": serviceIds,
      };
}
