import 'package:echo_chat/data_layer/storage.dart';
import 'package:echo_chat/domain_layer/message.dart';

class MessageRepository {
  MessageRepository(this._storage);

  final Storage<Message> _storage;

  Stream<List<Message>> get messages => _storage.items;

  Future<void> addMessage(String textMessage) async {
    _storage.add(
      Message(
        message: textMessage,
        username: "me",
        time: DateTime.now(),
      ),
    );
    await Future.delayed(
      const Duration(seconds: 1),
    );
    _storage.add(
      Message(
        message: textMessage.replaceAll("foo", "bar"),
        username: "bot",
        time: DateTime.now(),
      ),
    );
  }
}
