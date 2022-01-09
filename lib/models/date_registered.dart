import 'dart:convert';

DateRegistered dateRegisteredFromJson(String str) => DateRegistered.fromJson(json.decode(str));

String dateRegisteredToJson(DateRegistered data) => json.encode(data.toJson());

class DateRegistered {
  DateRegistered({
    this.id,
    this.userId,
    this.time,
    this.dateSectionId,
    this.subSectionId,
    this.registeredDate,
    this.serviceIds,
    this.dateService,
  });

  String id;
  String userId;
  String time;
  String dateSectionId;
  String subSectionId;
  DateTime registeredDate;
  List<dynamic> serviceIds;
  List<dynamic> dateService;

  factory DateRegistered.fromJson(Map<String, dynamic> json) => DateRegistered(
        id: json["id"] == null ? null : json["id"],
        userId: json["userId"] == null ? null : json["userId"],
        time: json["time"] == null ? null : json["time"],
        dateSectionId: json["dateSectionId"] == null ? null : json["dateSectionId"],
        subSectionId: json["subSectionId"] == null ? null : json["subSectionId"],
        registeredDate: json["registeredDate"] == null ? null : DateTime.parse(json["registeredDate"]),
        serviceIds: json["serviceIds"] == null ? null : List<dynamic>.from(json["serviceIds"].map((x) => x)),
        dateService: json["dateService"] == null ? null : List<dynamic>.from(json["dateService"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "time": time,
        "dateSectionId": dateSectionId,
        "subSectionId": subSectionId,
        "registeredDate": registeredDate?.toIso8601String(),
        "serviceIds": serviceIds == null ? null : List<dynamic>.from(serviceIds.map((x) => x)),
        "dateService": dateService == null ? null : List<dynamic>.from(dateService.map((x) => x)),
      };
}
