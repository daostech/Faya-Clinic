import 'package:faya_clinic/common/listable.dart';
import 'package:faya_clinic/models/chat_message.dart';
import 'package:faya_clinic/models/chat_room.dart';
import 'package:faya_clinic/models/chat_user.dart';
import 'package:faya_clinic/models/chat_room_user.dart';
import 'package:faya_clinic/repositories/auth_repository.dart';
import 'package:faya_clinic/services/database_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChatController with ChangeNotifier {
  static const TAG = "ChatController: ";

  static const DB_USERS_REF = "users";
  static const DB_CHATS_REF = "chats";
  static const DB_ROOMS_REF = "rooms";
  static const DB_ROOM_USERS_REF = "roomusers";

  static const TYPE_JOIN = "join";
  static const TYPE_MESSAGE = "message";

  final Database? database;
  final AuthRepositoryBase? authRepository;
  final db = FirebaseDatabase.instance;
  bool _isLoading = true;

  String get userId => authRepository!.userId ?? "";
  String get userName => authRepository!.myUser?.userName ?? "";
  // String get roomName => "$userName-Room";
  String get roomName => authRepository!.chatRoomName ?? "$userName-Room";

  List<ChatMessage> chatMessages = <ChatMessage>[];

  final messageTxtController = TextEditingController();
  ChatController({this.database, this.authRepository});

  bool get isLoading => _isLoading;

  Stream<DatabaseEvent> get chatMessagesStream {
    return db.ref().child(DB_CHATS_REF).orderByChild("roomname").equalTo(roomName).onValue;
  }

  Future<bool> isFirstMessage() async {
    print("$TAG isFirstMessage called");
    final query = db.ref().child(DB_CHATS_REF).orderByChild("roomname").equalTo(roomName);
    final hasData = await query.get().then((value) => value.exists).catchError((error) => false);
    print("$TAG isFirstMessage hasData: $hasData");
    return !hasData;
  }

  bool isJoinMessage(String type) {
    return type == TYPE_JOIN;
  }

  bool sentByMe(String id) {
    return id == userName;
  }

  Future<String> get messageType async {
    if (await isFirstMessage()) {
      return TYPE_JOIN;
    }
    return TYPE_MESSAGE;
  }

  // init() async {
  //   if (await isFirstMessage()) {
  //     print("$TAG init firstMessage true");
  //     final _roomName = userName;
  //     authRepository!.chatRoomName = _roomName;

  //     final chatRoom = ChatRoom(roomname: roomName);
  //     final roomUser = RoomUser(roomname: roomName);

  //     final roomRef = db.ref().child(DB_ROOMS_REF).child(userId);
  //     final roomUserRef = db.ref().child(DB_ROOM_USERS_REF).child(userId);

  //     roomRef.update(chatRoom.toMap());
  //     roomUserRef.update(roomUser.toJson());
  //   }
  // }

  init() async {
    if (await isFirstMessage()) {
      print("$TAG init firstMessage true");
      final _roomName = roomName;
      if (authRepository!.chatRoomName == null) {
        authRepository!.chatRoomName = _roomName;
      }

      final chatUser = ChatUser(nickname: userName);
      final chatRoom = ChatRoom(roomname: _roomName);
      final roomUser = ChatRoomUser(roomname: _roomName, nickname: userName);

      final userRef = db.ref().child(DB_USERS_REF).child(userId);
      final roomRef = db.ref().child(DB_ROOMS_REF).child(userId);
      final roomUserRef = db.ref().child(DB_ROOM_USERS_REF).child(userId);

      await userRef.update(chatUser.toJson());
      await roomRef.update(chatRoom.toMap());
      await roomUserRef.update(roomUser.toJson());
    }
    updateWith(loading: false);
  }

  onSendMessageClick(String message) async {
    print("$TAG onSendMessageClick called");
    if (await isFirstMessage()) {
      print("isFirstMessage true");
      final message = "$userName joined the chat";
      messageTxtController.text = "";
      await sendMessage(message);
    }
    sendMessage(message);
  }

  sendMessage(String message) async {
    print("$TAG sendMessage called message: $message");
    messageTxtController.text = "";
    final ref = db.ref(DB_CHATS_REF).push();
    final chatMessage = ChatMessage(
      message: message,
      roomname: roomName,
      nickname: userName,
      type: await messageType,
      date: DateTime.now(),
    );
    ref.set(chatMessage.toJson());
  }

  updateWith({bool? loading, List<ListAble>? items, List<ListAble>? result}) {
    _isLoading = loading ?? this._isLoading;
    notifyListeners();
  }
}
