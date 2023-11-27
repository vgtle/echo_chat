import 'package:echo_chat/application_layer/chat/chat_cubit.dart';
import 'package:echo_chat/application_layer/chat/widgets/bottom_chat_bar.dart';
import 'package:echo_chat/application_layer/chat/widgets/chat.dart';
import 'package:echo_chat/domain_layer/message.dart';
import 'package:echo_chat/domain_layer/message_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_textEditingListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_textEditingListener);
    _controller.dispose();
    super.dispose();
  }

  void _textEditingListener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(
        context.read<MessageRepository>(),
      ),
      child: BlocListener<ChatCubit, List<Message>>(
        listener: (context, state) => scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
        ),
        child: Builder(builder: (context) {
          final state = context.watch<ChatCubit>().state;
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  "FooBar Chat",
                ),
              ),
              bottomNavigationBar: BottomChatBar(
                controller: _controller,
                onSend: () {
                  context.read<ChatCubit>().addMessage(_controller.text);
                },
              ),
              body: Chat(
                messages: state,
                scrollController: scrollController,
              ),
            ),
          );
        }),
      ),
    );
    ;
  }
}
