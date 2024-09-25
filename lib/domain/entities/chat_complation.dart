
import 'dart:convert';

import 'package:insaaju/domain/entities/code_item.dart';

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
  final CodeItem systemPromptCodeItem;
  final CodeItem userPromptCodeItem;

  ChatCompletion({
    required this.id, 
    required this.choices,
    required this.systemPromptCodeItem,
    required this.userPromptCodeItem
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
      final systemPromptCodeItem = CodeItem.fromJson(json['systemPromptCodeItem']);
      final userPromptCodeItem = CodeItem.fromJson(json['userPromptCodeItem']);
      return ChatCompletion(
        id: json['id'],
        choices: choicesFromJson,
        systemPromptCodeItem: systemPromptCodeItem,
        userPromptCodeItem: userPromptCodeItem
      );
    }
}