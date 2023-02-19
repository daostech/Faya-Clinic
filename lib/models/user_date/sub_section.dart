import 'package:faya_clinic/models/user_date/section.dart';
import 'package:faya_clinic/models/user_date/service.dart';

class SubSection {
  SubSection({
    this.services,
    this.id,
    this.name,
    this.text,
    this.fullText,
    this.img1,
    this.img2,
    this.sectionId,
    this.creationDate,
    this.serviceIds,
    this.userRole,
    this.userName,
    this.token,
    this.sections,
  });

  List<Service>? services;
  String? id;
  String? name;
  String? text;
  String? fullText;
  String? img1;
  String? img2;
  String? sectionId;
  DateTime? creationDate;
  dynamic serviceIds;
  dynamic userRole;
  dynamic userName;
  dynamic token;
  Sections? sections;

  factory SubSection.fromJson(Map<String, dynamic> json) => SubSection(
        services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
        id: json["id"],
        name: json["name"],
        text: json["text"],
        fullText: json["fullText"],
        img1: json["img1"],
        img2: json["img2"],
        sectionId: json["sectionId"],
        creationDate: DateTime.parse(json["creationDate"]),
        serviceIds: json["serviceIds"],
        userRole: json["userRole"],
        userName: json["userName"],
        token: json["token"],
        sections: json["sections"] == null ? null : Sections.fromJson(json["sections"]),
      );

  Map<String, dynamic> toJson() => {
        "services": List<dynamic>.from(services!.map((x) => x.toJson())),
        "id": id,
        "name": name,
        "text": text,
        "fullText": fullText,
        "img1": img1,
        "img2": img2,
        "sectionId": sectionId,
        "creationDate": creationDate!.toIso8601String(),
        "serviceIds": serviceIds,
        "userRole": userRole,
        "userName": userName,
        "token": token,
        "sections": sections == null ? null : sections!.toJson(),
      };
}
