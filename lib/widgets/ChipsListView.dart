import 'dart:async';

import 'package:flutter/material.dart';
import 'package:messenger/domain/Chat.dart';
import 'package:messenger/pages/MessagesPage.dart';
import 'package:messenger/provider/Chats.dart';
import 'package:messenger/provider/Messages.dart';
import 'package:provider/provider.dart';

class ChipsListView extends StatefulWidget {
  const ChipsListView({Key? key}) : super(key: key);

  @override
  State<ChipsListView> createState() => _ChipsListViewState();
}

class _ChipsListViewState extends State<ChipsListView> {
  late Future _futureChats;
  var chatLenght;

  @override
  void initState() {
    _futureChats = Provider.of<Chats>(context, listen: false).loadChats();

    Timer.periodic(Duration(seconds: 5), (_) {
      _futureChats = Provider.of<Chats>(context, listen: false).loadChats();
    });
  }

  @override
  Widget build(BuildContext context) {
    final chats = Provider.of<Chats>(context);


    return FutureBuilder(
      future: _futureChats,
      builder: (_, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                shrinkWrap: true,
                itemCount: chats.all.length,
                itemBuilder: (_, index) {
                  print('test');
                  return ActionChip(
                      avatar: CircleAvatar(
                          backgroundColor: Colors.grey.shade800,
                          child: getChatLength(chats.all[index])),
                      label: Text(chats.all[index].title),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MessagesPage(chats.all[index])));
                      });
                });
      },
    );
  }

  FutureBuilder getChatLength(Chat chat) {
    print(chat.id);
    final messages = Provider.of<Messages>(context);
    late Future _futureMessages =
        Provider.of<Messages>(context, listen: false).loadMessages(chat.id!);
  return FutureBuilder(
        future: _futureMessages,
        builder: (_, snapshot){
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : Text(messages.all.length.toString());
        });
  }
}
