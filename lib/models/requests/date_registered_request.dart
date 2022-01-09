import 'dart:convert';

import 'package:faya_clinic/models/service.dart';
import 'package:faya_clinic/utils/date_formatter.dart';

String dateRegisteredToJson(DateRegisteredRequest request) => json.encode(request.toJson());

class DateRegisteredRequest {
  DateRegisteredRequest({
    this.userId,
    this.sectionId,
    this.subSectionId,
    this.dateTime,
    this.services,
  });

  String userId;
  String sectionId;
  String subSectionId;
  DateTime dateTime;
  List<ClinicService> services;

  String get time => MyDateFormatter.toStringTime(dateTime);
  String get registeredDate => MyDateFormatter.toStringDate(dateTime);
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
