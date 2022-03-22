class Chat {
  String? id;
  final String title;

  Chat({
    this.id,
    required this.title
});

  Chat.fromJson(Map<String, dynamic> json, String id)
      : this(
          id: id,
          title: json['title'],
        );


  Map<String, dynamic> toJson(){
    return {
      'title': title
    };
  }
}
