class ChatSession {
 final String id;

  ChatSession({required this.id});

  factory ChatSession.fromJson(Map<String, dynamic> json) {
    return ChatSession(
      id: json['id']
    );
  }
}