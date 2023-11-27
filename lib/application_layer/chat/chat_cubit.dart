import 'dart:async';

import 'package:echo_chat/domain_layer/message.dart';
import 'package:echo_chat/domain_layer/message_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<List<Message>> {
  ChatCubit(this._messageRepository) : super([]) {
    _subscription = _messageRepository.messages.listen((event) {
      emit(event);
    });
  }

  late final StreamSubscription<List<Message>> _subscription;

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }

  final MessageRepository _messageRepository;

  void addMessage(String message) {
    _messageRepository.addMessage(
      message,
    );
  }
}
