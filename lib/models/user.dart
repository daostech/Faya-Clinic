import 'dart:convert';

MyUser productFromJson(String str) => MyUser.fromJson(json.decode(str));

String productToJson(MyUser data) => json.encode(data.toJson());

class MyUser {
  MyUser({
    this.id,
    this.fullName,
    this.email,
    this.isActive,
    this.gender,
    this.phone,
    this.dateBirth,
    this.dateCreated,
  });

  String id;
  String fullName;
  String email;
  bool isActive;
  int gender;
  int phone;
  String dateBirth;
  String dateCreated;

  factory MyUser.fromJson(Map<String, dynamic> json) => MyUser(
        id: json["id"] == null ? null : json["id"],
        fullName: json["fullName"] == null ? null : json["fullName"],
        email: json["email"] == null ? null : json["email"],
        isActive: json["isActive"] == null ? null : json["isActive"],
        gender: json["gender"] == null ? null : json["gender"],
        phone: json["phone"] == null ? null : json["phone"],
        dateBirth: json["dateBirth"] == null ? null : json["dateBirth"],
        dateCreated: json["dateCreated"] == null ? null : json["dateCreated"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "email": email,
        "isActive": isActive,
        "gender": gender,
        "phone": phone,
        "dateBirth": dateBirth,
        "dateCreated": dateCreated,
      };
}
