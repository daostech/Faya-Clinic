import 'dart:convert';

NotificationModel notificationFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.id,
    this.userId,
    this.typeId,
    this.title,
    this.body,
    this.isShowed,
    this.creationDate,
  });

  String id;
  String title;
  String userId;
  String typeId;
  String body;
  bool isShowed;
  DateTime creationDate;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        userId: json["userId"],
        typeId: json["Type"],
        isShowed: json["isShowed"],
        creationDate: DateTime.tryParse(json["creationDate"]),
      );
  // factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
  //       id: json["id"],
  //       userId: json["userId"],
  //       typeId: json["typeId"],
  //       title: json["title"],
  //       text: json["text"],
  //       isShowed: json["isShowed"],
  //       creationDate: DateTime.tryParse(json["creationDate"]),
  //     );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "typeId": typeId,
        "title": title,
        "text": body,
        "isShowed": isShowed,
        "creationDate": creationDate.toString(),
      };
}
