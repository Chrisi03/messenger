import 'dart:async';

import 'package:flutter/material.dart';
import 'package:messenger/domain/Chat.dart';
import 'package:messenger/provider/Chats.dart';
import 'package:messenger/provider/Messages.dart';
import 'package:provider/provider.dart';

class MessagesPage extends StatefulWidget {
  int chatIndex;

  MessagesPage(this.chatIndex, {Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = new TextEditingController();
  late Future _futureChats;
  late Timer timer;

  @override
  void initState() {
    _futureChats = Provider.of<Chats>(context, listen: false).loadChats();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final messages = Provider.of<Messages>(context);
    final chats = Provider.of<Chats>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(chats.all[widget.chatIndex].title),
      ),
      body: FutureBuilder(
          future: _futureChats,
          builder: (_, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: chats.all[widget.chatIndex].messages == null
                        ? 0
                        : chats.all[widget.chatIndex].messages!.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        title: Text(chats.all[widget.chatIndex].messages![index].content),
                        subtitle: Text(chats.all[widget.chatIndex].messages![index].id!),
                      );
                    });
          }),
      bottomSheet: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'New Message',
            suffixIcon: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    messages.addMessage(_controller.text, chats.all[widget.chatIndex].id!);
                    _controller.clear();
                  }
                }),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
      ),
    );
  }
}
