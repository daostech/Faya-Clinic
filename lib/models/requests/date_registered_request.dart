import 'dart:convert';

import 'package:faya_clinic/models/date_section.dart';
import 'package:faya_clinic/models/date_service.dart';
import 'package:faya_clinic/models/time_span.dart';

DateRegisteredRequest dateRegisteredFromJson(String str) => DateRegisteredRequest.fromJson(json.decode(str));

String dateRegisteredToJson(DateRegisteredRequest data) => json.encode(data.toJson());

class DateRegisteredRequest {
  DateRegisteredRequest({
    this.id,
    this.userId,
    this.dateService,
    this.dateSection,
    this.timeSpan,
  });

  String id;
  String userId;
  DateService dateService;
  DateSection dateSection;
  TimeSpan timeSpan;

  factory DateRegisteredRequest.fromJson(Map<String, dynamic> json) => DateRegisteredRequest(
        id: json["id"] == null ? null : json["id"],
        userId: json["userId"] == null ? null : json["userId"],
        dateSection: json["dateSection"] == null ? null : DateSection.fromJson(json["dateSection"]),
        dateService: json["dateService"] == null ? null : DateService.fromJson(json["dateService"]),
        timeSpan: json["timeSpan"] == null ? null : TimeSpan.fromJson(json["timeSpan"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "dateSection": dateSection.toJson(),
        "dateService": dateService.toJson(),
        "timeSpan": timeSpan.toJson(),
      };
}
