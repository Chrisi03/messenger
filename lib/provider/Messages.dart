import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:messenger/domain/Message.dart';
import 'package:http/http.dart' as http;

class Messages with ChangeNotifier{
  var _values = <Message>[
  ];

  static const baseUrl =
      'https://messenger-435fe-default-rtdb.europe-west1.firebasedatabase.app/';

  List<Message> get all {
    return [..._values];
  }

  Future<void> loadMessages(String chatId) async {
    final url = Uri.parse('$baseUrl/chats/$chatId/messages.json');
    try{
      final response = await http.get(url);
      final data = jsonDecode(response.body);
      _values = data.entries.map<Message>((entry) => Message.fromJson
        (entry.value, entry.key)).toList();
    }catch (error){
      print(error);
    }
  }

  Future<void> addMessage(String content, String chatId) async {
    final url = Uri.parse('$baseUrl/chats/$chatId/messages.json');
    final message = Message(content: content);
    final body = jsonEncode(message.toJson());
    try{
      final response = await http.post(url,body: body);
      message.id = jsonDecode(response.body)['name'];
      _values.add(message);
      notifyListeners();
    }catch(error){
      print(error);
    }
  }



}