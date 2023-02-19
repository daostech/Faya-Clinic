import 'package:faya_clinic/models/user_date/date_service.dart';
import 'package:faya_clinic/models/user_date/section.dart';

class DateRegistered {
  DateRegistered({
    this.dateService,
    this.sections,
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
    this.status,
    this.serviceIds,
  });

  List<DateService>? dateService;
  Sections? sections;
  String? id;
  String? userId;
  String? time;
  DateTime? creationDate;
  String? sectionId;
  String? subSectionId;
  DateTime? registeredDate;
  dynamic userRole;
  dynamic userName;
  dynamic token;
  String? status;
  dynamic serviceIds;

  factory DateRegistered.fromJson(Map<String, dynamic> json) => DateRegistered(
        dateService: List<DateService>.from(json["dateService"].map((x) => DateService.fromJson(x))),
        sections: json["sections"] == null ? null : Sections.fromJson(json["sections"]),
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
        status: json["status"],
        serviceIds: json["serviceIds"],
      );

  Map<String, dynamic> toJson() => {
        "dateService": List<dynamic>.from(dateService!.map((x) => x.toJson())),
        "sections": sections == null ? null : sections!.toJson(),
        "id": id,
        "userId": userId,
        "time": time,
        "creationDate": creationDate!.toIso8601String(),
        "sectionId": sectionId,
        "subSectionId": subSectionId,
        "registeredDate": registeredDate!.toIso8601String(),
        "userRole": userRole,
        "userName": userName,
        "token": token,
        "status": status,
        "serviceIds": serviceIds,
      };
}
