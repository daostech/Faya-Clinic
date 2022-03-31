import 'dart:convert';

import 'package:faya_clinic/models/service.dart';

String dateRegisteredToJson(DateRegisteredRequest request) => json.encode(request.toJson());

class DateRegisteredRequest {
  DateRegisteredRequest({
    this.userId,
    this.sectionId,
    this.subSectionId,
    this.timeStr,
    this.dateTime,
    this.services,
  });

  String userId;
  String sectionId;
  String subSectionId;
  String timeStr;
  DateTime dateTime;
  List<ClinicService> services;

  String get time => timeStr;
  String get registeredDate => dateTime.toIso8601String();
  List<String> get serviceIds => services == null ? [] : services.map((e) => e.id).toList();

  Map<String, dynamic> get dateSubSection => {
        "dateSectionId": sectionId,
        "dateSection": "string",
        "serviceIds": serviceIds,
      };

  Map<String, dynamic> get dateSection => {
        "subSectionId": subSectionId,
        "dateSubSection": dateSubSection,
      };

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "time": time,
        "dateSection": dateSection,
        "registeredDate": registeredDate,
      };
}
