import 'dart:convert';

class ChatRoom {
  String roomname;
  ChatRoom({
    required this.roomname,
  });

  ChatRoom copyWith({
    String? roomName,
  }) {
    return ChatRoom(
      roomname: roomName ?? this.roomname,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'roomname': roomname,
    };
  }

  factory ChatRoom.fromMap(Map<String, dynamic> map) {
    return ChatRoom(
      roomname: map['roomname'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatRoom.fromJson(String source) => ChatRoom.fromMap(json.decode(source));

  @override
  String toString() => 'ChatRoom(roomname: $roomname)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatRoom && other.roomname == roomname;
  }

  @override
  int get hashCode => roomname.hashCode;
}
