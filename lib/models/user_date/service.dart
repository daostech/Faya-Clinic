import 'package:faya_clinic/models/user_date/sub_section.dart';

class Service {
  Service({
    this.id,
    this.name,
    this.creationDate,
    this.subSectionId,
    this.userRole,
    this.userName,
    this.token,
    this.subSection,
  });

  String? id;
  String? name;
  DateTime? creationDate;
  String? subSectionId;
  dynamic userRole;
  dynamic userName;
  dynamic token;
  SubSection? subSection;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        name: json["name"],
        creationDate: DateTime.parse(json["creationDate"]),
        subSectionId: json["subSectionId"],
        userRole: json["userRole"],
        userName: json["userName"],
        token: json["token"],
        subSection: json["subSection"] == null ? null : SubSection.fromJson(json["subSection"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "creationDate": creationDate!.toIso8601String(),
        "subSectionId": subSectionId,
        "userRole": userRole,
        "userName": userName,
        "token": token,
        "subSection": subSection == null ? null : subSection!.toJson(),
      };
}
