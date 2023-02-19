import 'dart:convert';

ChatRoomUser roomUserFromJson(String str) => ChatRoomUser.fromJson(json.decode(str));

String roomUserToJson(ChatRoomUser data) => json.encode(data.toJson());

class ChatRoomUser {
  ChatRoomUser({
    this.roomname,
    this.nickname,
    this.status = "online",
  });

  String? roomname;
  String? nickname;
  String status;

  factory ChatRoomUser.fromJson(Map<String, dynamic> json) => ChatRoomUser(
        roomname: json["roomname"],
        nickname: json["nickname"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "roomname": roomname,
        "nickname": nickname,
        "status": status,
      };
}
