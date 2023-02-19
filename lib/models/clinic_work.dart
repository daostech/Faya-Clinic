import 'dart:convert';

import 'package:faya_clinic/constants/config.dart';

ClinicWork clinicWorkFromJson(String str) => ClinicWork.fromJson(json.decode(str));

String clinicWorkToJson(ClinicWork data) => json.encode(data.toJson());

class ClinicWork {
  ClinicWork({
    this.referenceId,
    this.id,
    this.name,
    this.text,
    this.fullText,
    this.img1,
    this.img2,
    this.img3,
    this.subSectionId,
    this.creationDate,
    this.userRole,
    this.userName,
  });

  int? referenceId;
  String? id;
  String? name;
  String? text;
  String? fullText;
  String? img1;
  String? img2;
  dynamic img3;
  String? subSectionId;
  DateTime? creationDate;
  dynamic userRole;
  dynamic userName;

  // the image comes from the response hold the file name only
  // so we add the base url prefix in order to load the image properly
  String _imageUrl(String? img) => "${AppConfig.RAW_BASE_URL}/$img";

  List<String> get images {
    List<String?> tmps = [img1, img2, img3];
    List<String> imgs = [];
    for (int i = 0; i < 3; i++) {
      if (tmps[i] != null) imgs.add(_imageUrl(tmps[i]));
    }
    return imgs;
  }

  bool get hasImages => images != null && images.length > 0;

  factory ClinicWork.fromJson(Map<String, dynamic> json) => ClinicWork(
        referenceId: json["referenceId"],
        id: json["id"],
        name: json["name"],
        text: json["text"],
        fullText: json["fullText"],
        img1: json["img1"],
        img2: json["img2"],
        img3: json["img3"],
        subSectionId: json["subSectionId"],
        creationDate: DateTime.parse(json["creationDate"]),
        userRole: json["userRole"],
        userName: json["userName"],
      );

  Map<String, dynamic> toJson() => {
        "referenceId": referenceId,
        "id": id,
        "name": name,
        "text": text,
        "fullText": fullText,
        "img1": img1,
        "img2": img2,
        "img3": img3,
        "subSectionId": subSectionId,
        "creationDate": creationDate?.toIso8601String(),
        "userRole": userRole,
        "userName": userName,
      };
}
