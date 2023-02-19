import 'dart:convert';

import 'package:faya_clinic/models/service.dart';

DateService dateServiceFromJson(String str) => DateService.fromJson(json.decode(str));

String dateServiceToJson(DateService data) => json.encode(data.toJson());

class DateService {
  DateService({
    this.id,
    this.dateId,
    this.serviceId,
    this.dateRegistered,
    this.service,
  });

  String? id;
  String? dateId;
  String? serviceId;
  dynamic dateRegistered;
  ClinicService? service;

  factory DateService.fromJson(Map<String, dynamic> json) => DateService(
        id: json["id"] == null ? null : json["id"],
        dateId: json["dateId"] == null ? null : json["dateId"],
        serviceId: json["serviceId"] == null ? null : json["serviceId"],
        dateRegistered: json["dateRegistered"] == null ? null : json["dateRegistered"],
        service: json["service"] == null ? null : json["service"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dateId": dateId,
        "serviceId": serviceId,
        "dateRegistered": dateRegistered,
        "service": service,
      };
}
