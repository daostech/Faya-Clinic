import 'dart:convert';

DateRegisteredRequest dateRegisteredRequestFromJson(String str) => DateRegisteredRequest.fromJson(json.decode(str));

String dateRegisteredRequestToJson(DateRegisteredRequest data) => json.encode(data.toJson());

class DateRegisteredRequest {
  DateRegisteredRequest({
    this.userId,
    this.dateSectionId,
    this.subSectionId,
    this.serviceIds,
    this.registeredDate,
    this.time,
  });

  String? userId;
  String? dateSectionId;
  String? subSectionId;
  List<String?>? serviceIds;
  DateTime? registeredDate;
  String? time;

  factory DateRegisteredRequest.fromJson(Map<String, dynamic> json) => DateRegisteredRequest(
        userId: json["userId"],
        dateSectionId: json["sectionId"],
        subSectionId: json["subSectionId"],
        serviceIds: List<String>.from(json["ServiceIds"].map((x) => x)),
        registeredDate: DateTime.parse(json["registeredDate"]),
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "sectionId": dateSectionId,
        "subSectionId": subSectionId,
        "ServiceIds": List<dynamic>.from(serviceIds!.map((x) => x)),
        "registeredDate": registeredDate!.toIso8601String(),
        "time": time,
      };
}
