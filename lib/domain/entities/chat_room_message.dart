import 'package:insaaju/domain/entities/code_item.dart';
import 'package:insaaju/exceptions/unknown_exception.dart';

enum ChatRoomRole {
  button,
  system,
  assistant,
  user
}
extension ChatRoomRoleExtension on ChatRoomRole {
  String getValue() {
    return this.toString().split('.').last;
  }
  static ChatRoomRole fromString(String roleString) {
    switch (roleString.toLowerCase()) {
      case 'button':
        return ChatRoomRole.button;
      case 'system':
        return ChatRoomRole.system;
      case 'assistant':
        return ChatRoomRole.assistant;
      case 'user':
        return ChatRoomRole.user;
      default:
        throw UnknownException<String>(roleString);
    }
  }
}

class ChatBaseRoomMessage {
  final ChatRoomRole role;
  final String content;
  ChatBaseRoomMessage({
    required this.role,
    required this.content,
  });
  Map<String, dynamic> toJson(){
    return {
      'role' : role.getValue(),
      'content' : content
    };
  }
}
class ChatRoomMessage extends ChatBaseRoomMessage {
  
  final CodeItem systemPromptCodeItem;
  final CodeItem userPromptCodeItem;
  ChatRoomMessage({
    required this.systemPromptCodeItem,
    required this.userPromptCodeItem, 
    required super.role, 
    required super.content
  });
}