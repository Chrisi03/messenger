import 'dart:async';

import 'package:flutter/material.dart';
import 'package:messenger/domain/Chat.dart';
import 'package:messenger/provider/Messages.dart';
import 'package:provider/provider.dart';

class MessagesPage extends StatefulWidget {
  Chat chat;

  MessagesPage(this.chat, {Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = new TextEditingController();
  late Future _futureMessages;

  @override
  void initState() {
    _futureMessages = Provider.of<Messages>(context, listen: false)
        .loadMessages(widget.chat.id!);
    /*Timer.periodic(Duration(seconds: 5), (timer) {
      _futureMessages = Provider.of<Messages>(context, listen: false)
          .loadMessages(widget.chat.id!);
      print('test2');
    });

     */
  }

  @override
  Widget build(BuildContext context) {
    final messages = Provider.of<Messages>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chat.title),
      ),
      body: FutureBuilder(
          future: _futureMessages,
          builder: (_, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: messages.all.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        title: Text(messages.all[index].content),
                        subtitle: Text(messages.all[index].id!),
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
                    messages.addMessage(_controller.text, widget.chat.id!);
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
