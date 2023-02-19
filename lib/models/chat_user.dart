import 'dart:convert';

ChatUser chatMessageFromJson(String str) => ChatUser.fromJson(json.decode(str));

String chatMessageToJson(ChatUser data) => json.encode(data.toJson());

class ChatUser {
  ChatUser({
    this.nickname,
  });

  String? nickname;

  factory ChatUser.fromJson(Map<String, dynamic>? json) => ChatUser(
        nickname: json?["nickname"],
      );

  Map<String, dynamic> toJson() => {
        "nickname": nickname,
      };
}
