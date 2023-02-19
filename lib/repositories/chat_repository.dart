// import 'package:faya_clinic/api/firebase_api.dart';
// import 'package:faya_clinic/models/chat_message.dart';
// import 'package:faya_clinic/storage/local_storage.dart';

// abstract class ChatRepositoryBase {
//   List<ChatMessage> get savedMessages;
//   List<ChatMessage> fetchMessages(String userId);
//   sendMessage(ChatMessage message);
//   deleteAll();
// }

// class ChatRepository implements ChatRepositoryBase {
//   final LocalStorageService localStorage;
//   final FirebaseApi firebaseApi;
//   ChatRepository(this.localStorage, this.firebaseApi);

//   @override
//   List<ChatMessage> get savedMessages => List<ChatMessage>.from(localStorage.getAll());

//   @override
//   sendMessage(ChatMessage message) {
//     print("ChatRepository: adding ${message.toJson()}");
//     // localStorage.insertObject(message);
//   }

//   @override
//   deleteAll() {
//     localStorage.clearAll();
//   }

//   @override
//   List<ChatMessage> fetchMessages(String userId) {
//     final ss = firebaseApi.chatMessages;
//   }
// }
