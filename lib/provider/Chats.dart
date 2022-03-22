import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:messenger/domain/Chat.dart';
import 'package:http/http.dart' as http;

class Chats with ChangeNotifier{
  var _values = <Chat>[
  ];

  static const baseUrl =
      'https://messenger-435fe-default-rtdb.europe-west1.firebasedatabase.app/';

  List<Chat> get all {
    return [..._values];
  }

  Future<void> loadChats() async {
    final url = Uri.parse('$baseUrl/chats.json');
    try{
      final response = await http.get(url);
      final data = jsonDecode(response.body);
      _values = data.entries.map<Chat>((entry) => Chat.fromJson
        (entry.value, entry.key)).toList();
    }catch (error){
      print(error);
    }
  }

  Future<void> addChat(String title) async {
    final url = Uri.parse('$baseUrl/chats.json');
    final chat = Chat(title: title);
    final body = jsonEncode(chat.toJson());
    try{
      final response = await http.post(url,body: body);
      chat.id = jsonDecode(response.body)['name'];
      _values.add(chat);
      notifyListeners();
    }catch(error){
      print(error);
    }
  }
}