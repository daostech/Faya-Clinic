import 'dart:convert';

import 'package:faya_clinic/constants/hive_keys.dart';
import 'package:faya_clinic/models/storage_model.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'user.g.dart';

MyUser productFromJson(String str) => MyUser.fromJson(json.decode(str));

String productToJson(MyUser data) => json.encode(data.toJson());

@HiveType(typeId: HiveKeys.TYPE_USER)
class MyUser extends StorageModel {
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

  @HiveField(0)
  String id;
  @HiveField(1)
  String fullName;
  @HiveField(2)
  String email;
  @HiveField(3)
  bool isActive;
  @HiveField(4)
  int gender;
  @HiveField(5)
  String phone;
  @HiveField(6)
  String dateBirth;
  @HiveField(7)
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

  @override
  String get primaryKey => this.id ?? Uuid().v4();
}
