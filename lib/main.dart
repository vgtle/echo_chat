import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final List<Message> messages = [];

  final TextEditingController _controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  void addMessage(Message message) {
    setState(() {
      messages.add(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Color.fromRGBO(243, 0, 104, 1),
        useMaterial3: true,
      ),
      home: Builder(builder: (context) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                "FooBar Chat",
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              elevation: 1,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: EdgeInsets.all(12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: _controller.text.isEmpty
                            ? null
                            : () async {
                                final message = Message(
                                    message: _controller.text,
                                    username: "me",
                                    time: DateTime.now());
                                final message2 = Message(
                                    message: _controller.text
                                        .replaceAll("foo", "bar"),
                                    username: "bot",
                                    time: DateTime.now());
                                _controller.clear();
                                if (scrollController.position.maxScrollExtent >
                                    scrollController.position.pixels) {
                                  await Future.delayed(
                                      const Duration(milliseconds: 200));
                                  scrollController.animateTo(
                                    scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeOutCubic,
                                  );
                                  await Future.delayed(
                                      const Duration(milliseconds: 500), () {});
                                }

                                addMessage(message);
                                await Future.delayed(
                                    const Duration(milliseconds: 200));
                                scrollController.animateTo(
                                  scrollController.position.maxScrollExtent,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeOutCubic,
                                );
                                await Future.delayed(
                                    const Duration(milliseconds: 500), () {});
                                addMessage(message2);

                                await Future.delayed(
                                    const Duration(milliseconds: 200));
                                scrollController.animateTo(
                                  scrollController.position.maxScrollExtent,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeOutCubic,
                                );
                              },
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.send,
                            color: _controller.value.text.isEmpty
                                ? Theme.of(context).disabledColor
                                : Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          return Align(
                            alignment: message.isMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: ChatBubble(
                              message: message,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 8,
                          );
                        },
                        itemCount: messages.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class Message {
  final String message;
  final String username;
  final DateTime time;

  Message({
    required this.message,
    required this.username,
    required this.time,
  });

  bool get isMe => username == "me";
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
  });

  final Message message;

  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, child) {
        final curvedValue = Curves.easeOutCubic.transform(value);
        final curvedValueEaseIn = Curves.easeInCubic.transform(value);
        return Opacity(
          opacity: curvedValueEaseIn,
          child: Transform.translate(
            offset: Offset((message.isMe ? 100 : -100) * (1 - curvedValue), 0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 140),
              child: Container(
                decoration: BoxDecoration(
                  color: message.isMe
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.15)
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 240),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.username,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: message.isMe
                                      ? Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.5)
                                      : Colors.grey[400],
                                ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Text(message.message)),
                              Text(
                                "${message.time.hour}:${message.time.minute}",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      color: message.isMe
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.5)
                                          : Colors.grey[400],
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          ),
        );
      },
    );
  }
}
