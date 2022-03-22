import 'package:flutter/material.dart';
import 'package:messenger/pages/MessagesPage.dart';
import 'package:messenger/provider/Chats.dart';
import 'package:provider/provider.dart';

class ChipsListView extends StatefulWidget {
  const ChipsListView({Key? key}) : super(key: key);

  @override
  State<ChipsListView> createState() => _ChipsListViewState();
}

class _ChipsListViewState extends State<ChipsListView> {
  late Future _futureChats;

  @override
  void initState() {
    _futureChats = Provider.of<Chats>(context, listen: false).loadChats();
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
                          child: const Text('AB') //TODO Anzahl an Nachrichten,
                          ),
                      label: Text(chats.all[index].title),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MessagesPage(chats.all[index])));
                      });
                });
      },
    );
  }
}
