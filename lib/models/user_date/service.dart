class Service {
  Service({
    this.id,
    this.name,
    this.creationDate,
    this.subSectionId,
    this.userRole,
    this.userName,
    this.token,
  });

  String id;
  String name;
  DateTime creationDate;
  String subSectionId;
  dynamic userRole;
  dynamic userName;
  dynamic token;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        name: json["name"],
        creationDate: DateTime.parse(json["creationDate"]),
        subSectionId: json["subSectionId"],
        userRole: json["userRole"],
        userName: json["userName"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "creationDate": creationDate.toIso8601String(),
        "subSectionId": subSectionId,
        "userRole": userRole,
        "userName": userName,
        "token": token,
      };
}
