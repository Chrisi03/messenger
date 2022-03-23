import 'package:flutter/foundation.dart';

import 'Message.dart';

class Chat {
  String? id;
  final String title;
  List<Message>? messages;

  Chat({
    this.id,
    required this.title,
    this.messages
});

  Chat.fromJson(Map<String, dynamic> json, String id)
      : this(
          id: id,
          title: json['title'],
          messages: json['messages'] == null
            ? []
            : json['messages'].entries.map<Message>((entry) => Message.fromJson(entry.value, entry.key)).toList()
        );


  Map<String, dynamic> toJson(){
    return {
      'title': title,
      'messages': messages
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Chat &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          listEquals(messages, other.messages);


  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ messages.hashCode;
}
