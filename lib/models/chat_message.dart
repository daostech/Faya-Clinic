import 'dart:convert';

import 'package:faya_clinic/utils/date_formatter.dart';

ChatMessage chatMessageFromJson(String str) => ChatMessage.fromJson(json.decode(str));

String chatMessageToJson(ChatMessage data) => json.encode(data.toJson());

class ChatMessage {
  ChatMessage({
    this.date,
    this.message,
    this.nickname,
    this.roomname,
    this.type,
    this.isNew,
  });

  DateTime? date;
  String? message;
  String? nickname;
  String? roomname;
  String? type;
  bool? isNew;

  factory ChatMessage.fromJson(Map<String, dynamic>? json) => ChatMessage(
        date: json?["date"] == null ? null : MyDateFormatter.toDateTimeChatFormat(json!["date"]),
        message: json?["message"],
        nickname: json?["nickname"],
        roomname: json?["roomname"],
        type: json?["type"],
        isNew: json?["isNew"],
      );

  Map<String, dynamic> toJson() => {
        "date": MyDateFormatter.toStringDateTimeChatFormat(date),
        "message": message,
        "nickname": nickname,
        "roomname": roomname,
        "type": type,
        "isNew": isNew,
      };
}
