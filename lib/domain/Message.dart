class Message {
  String? id;
  final String content;

  Message({this.id, required this.content});

  Message.fromJson(Map<String, dynamic> json, String id)
      : this(
          id: id,
          content: json['content'],
        );

  Map<String, dynamic> toJson(){
    return {
      'content': content
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Message &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          content == other.content;

  @override
  int get hashCode => id.hashCode ^ content.hashCode;
}
