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
  late Timer timer;

  @override
  void initState() {
    //Provider.of<Chats>(context,listen: true);
    _futureChats = Provider.of<Chats>(context, listen: false).loadChats();

    timer = Timer.periodic(Duration(seconds: 5), (_) {
      print('test');
      _futureChats = Provider.of<Chats>(context, listen: false).loadChats();
    });
  }


  @override
  void dispose() {
    timer.cancel();
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
                  return ActionChip(
                      avatar: CircleAvatar(
                          backgroundColor: Colors.grey.shade800,
                          child: chats.all[index].messages == null
                              ? Text('0')
                              :Text(chats.all[index].messages!.length.toString())
                      ),
                      label: Text(chats.all[index].title),
                      onPressed: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MessagesPage(index)));

                      });
                });
      },
    );
  }
/*
  FutureBuilder getChatLength(Chat chat) {
    print(chat.id);
    final messages = Provider.of<Messages>(context);
    Future _futureMessages =
        Provider.of<Messages>(context, listen: false).loadMessages(chat.id!);
  return FutureBuilder(
        future: _futureMessages,
        builder: (_, snapshot){
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : Text(messages.all.length.toString());
        });
  }

 */
}
