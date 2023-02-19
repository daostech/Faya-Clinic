import 'package:faya_clinic/models/user_date/date_registered.dart';
import 'package:faya_clinic/models/user_date/sub_section.dart';

class Sections {
  Sections({
    this.subSections,
    this.dateRegistered,
    this.id,
    this.name,
    this.text,
    this.image,
    this.creationDate,
    this.userRole,
    this.userName,
    this.token,
  });

  List<SubSection>? subSections;
  List<DateRegistered>? dateRegistered;
  String? id;
  String? name;
  String? text;
  String? image;
  DateTime? creationDate;
  dynamic userRole;
  dynamic userName;
  dynamic token;

  factory Sections.fromJson(Map<String, dynamic> json) => Sections(
        subSections: List<SubSection>.from(json["subSections"].map((x) => SubSection.fromJson(x))),
        dateRegistered: List<DateRegistered>.from(json["dateRegistered"].map((x) => DateRegistered.fromJson(x))),
        id: json["id"],
        name: json["name"],
        text: json["text"],
        image: json["image"],
        creationDate: DateTime.parse(json["creationDate"]),
        userRole: json["userRole"],
        userName: json["userName"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "subSections": List<dynamic>.from(subSections!.map((x) => x.toJson())),
        "dateRegistered": List<dynamic>.from(dateRegistered!.map((x) => x.toJson())),
        "id": id,
        "name": name,
        "text": text,
        "image": image,
        "creationDate": creationDate!.toIso8601String(),
        "userRole": userRole,
        "userName": userName,
        "token": token,
      };
}
