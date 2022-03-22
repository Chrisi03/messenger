class Message {
  String? id;
  final String text;

  Message({this.id, required this.text});

  Message.fromJson(Map<String, dynamic> json, String id)
      : this(
          id: id,
          text: json['text'],
        );

  Map<String, dynamic> toJson(){
    return {
      'text': text
    };
  }
}
