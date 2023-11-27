import 'dart:math';

import 'package:echo_chat/application_layer/chat/chat_page.dart';
import 'package:echo_chat/data_layer/storage.dart';
import 'package:echo_chat/domain_layer/message_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: const Color.fromRGBO(243, 0, 104, 1),
        useMaterial3: true,
      ),
      home: RepositoryProvider(
        create: (context) => MessageRepository(Storage()),
        child: Builder(builder: (context) {
          return const ChatPage();
        }),
      ),
    );
  }
}
