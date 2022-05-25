import 'package:faya_clinic/models/message.dart';
import 'package:faya_clinic/storage/local_storage.dart';

abstract class ChatRepositoryBase {
  List<Message> get savedMessages;
  List<Message> fetchMessages(String userId);
  sendMessage(Message message);
  deleteAll();
}

class ChatRepository implements ChatRepositoryBase {
  final LocalStorageService localStorage;
  ChatRepository(this.localStorage);

  @override
  List<Message> get savedMessages => List<Message>.from(localStorage.getAll()) ?? [];

  @override
  sendMessage(Message message) {
    print("ChatRepository: adding ${message.toJson()}");
    localStorage.insertObject(message);
  }

  @override
  deleteAll() {
    localStorage.clearAll();
  }

  @override
  List<Message> fetchMessages(String userId) {
    // TODO: implement fetchMessages
    throw UnimplementedError();
  }
}
