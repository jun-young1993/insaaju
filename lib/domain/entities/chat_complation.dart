
import 'dart:convert';

class ChatComplationMessage {
  final String role;
  final String content;

  ChatComplationMessage({
    required this.role, 
    required this.content
  });

  Map<String, dynamic> toJson(){
    return {
      'role': role,
      'content': content
    };
  }

  factory ChatComplationMessage.fromJson(Map<String, dynamic> json){
    return ChatComplationMessage(
      content: json['content'],
      role: json['role']
    );
  }
}

class ChatComplationChoice {
  final int index;
  final ChatComplationMessage message;

  ChatComplationChoice({
    required this.index, 
    required this.message
  });

  
  Map<String, dynamic> toJson(){
    return {
      'index': index,
      'message': message.toJson()
    };
  }

  factory ChatComplationChoice.fromJson(Map<String, dynamic> json){
    
    return ChatComplationChoice(
      message: ChatComplationMessage.fromJson(json['message']),
      index: json['index']
    );
  }
}

class ChatCompletion {
  final String id;
  final List<ChatComplationChoice> choices;

  ChatCompletion({
    required this.id, 
    required this.choices
  });

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'choices': choices.map((choice) => choice.toJson()).toList()
    };
  }

  @override
  String toString(){
    return jsonEncode(toJson());
  }

  factory ChatCompletion.fromJson(Map<String, dynamic> json){
      
      final List<dynamic> choices = json['choices'];
      
      final List<ChatComplationChoice> choicesFromJson = choices
        .map((choiceJson) => ChatComplationChoice.fromJson(choiceJson))
        .toList();
    return ChatCompletion(
      id: json['id'],
      choices: choicesFromJson
    );
  }
}