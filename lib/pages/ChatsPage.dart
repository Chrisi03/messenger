import 'package:flutter/material.dart';
import 'package:messenger/provider/Chats.dart';
import 'package:messenger/widgets/ChipsListView.dart';
import 'package:provider/provider.dart';

class ChatsPage extends StatelessWidget {
  ChatsPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final chats = Provider.of<Chats>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: ChipsListView(),
      bottomSheet: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'New Chat',
            suffixIcon: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    chats.addChat(_controller.text);
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
