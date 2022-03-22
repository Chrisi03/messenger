import 'package:flutter/material.dart';
import 'package:messenger/provider/Chats.dart';
import 'package:messenger/provider/Messages.dart';
import 'package:provider/provider.dart';

import 'pages/ChatsPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Chats>(create: (_) => Chats()),
        ChangeNotifierProvider<Messages>(create: (_) => Messages()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            '/': (context) => ChatsPage(),
          }),
    );
  }
}
