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
    this.userId,
    this.userName,
    this.email,
    this.isActive,
    this.gender,
    this.phoneNumber,
    this.dateBirth,
    this.dateCreated,
    this.imgUrl,
    this.token,
  });

  @HiveField(0)
  String userId;
  @HiveField(1)
  String userName;
  @HiveField(2)
  String email;
  @HiveField(3)
  bool isActive;
  @HiveField(4)
  int gender;
  @HiveField(5)
  String phoneNumber;
  @HiveField(6)
  String dateBirth;
  @HiveField(7)
  String dateCreated;
  @HiveField(8)
  String imgUrl;
  @HiveField(9)
  String token;

  factory MyUser.fromJson(Map<String, dynamic> json) => MyUser(
        userId: json["id"] == null ? null : json["id"],
        userName: json["fullName"] == null ? null : json["fullName"],
        email: json["email"] == null ? null : json["email"],
        isActive: json["isActive"] == null ? null : json["isActive"],
        gender: json["gender"] == null ? null : json["gender"],
        phoneNumber: json["phone"] == null ? null : json["phone"],
        dateBirth: json["dateBirth"] == null ? null : json["dateBirth"],
        dateCreated: json["dateCreated"] == null ? null : json["dateCreated"],
        imgUrl: json["imgUrl"] == null ? null : json["imgUrl"],
        token: json["token"] == null ? null : json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": userId,
        "fullName": userName,
        "email": email,
        "isActive": isActive,
        "gender": gender,
        "phone": phoneNumber,
        "dateBirth": dateBirth,
        "dateCreated": dateCreated,
        "imgUrl": imgUrl,
        "token": token,
      };

  MyUser copyWith({
    userId,
    userName,
    phoneNumber,
    dateBirth,
    email,
    isActive,
    gender,
    token,
    imgUrl,
  }) {
    return MyUser(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateBirth: dateBirth ?? this.dateBirth,
      email: email ?? this.email,
      isActive: isActive ?? this.isActive,
      gender: gender ?? this.gender,
      token: token ?? this.token,
      imgUrl: imgUrl ?? this.imgUrl,
    );
  }

  MyUser copyFrom({MyUser user}) {
    return MyUser(
      userId: user.userId ?? this.userId,
      userName: user.userName ?? this.userName,
      phoneNumber: user.phoneNumber ?? this.phoneNumber,
      dateBirth: user.dateBirth ?? this.dateBirth,
      email: user.email ?? this.email,
      isActive: user.isActive ?? this.isActive,
      gender: user.gender ?? this.gender,
      token: user.token ?? this.token,
      imgUrl: user.imgUrl ?? this.imgUrl,
    );
  }

  @override
  String get primaryKey => this.userId ?? Uuid().v4();
}
