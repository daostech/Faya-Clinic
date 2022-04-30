class DateService {
  DateService({
    this.id,
    this.serviceId,
    this.dateId,
  });

  String id;
  String serviceId;
  String dateId;

  factory DateService.fromJson(Map<String, dynamic> json) => DateService(
        id: json["id"],
        serviceId: json["serviceId"],
        dateId: json["dateId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "serviceId": serviceId,
        "dateId": dateId,
      };
}
