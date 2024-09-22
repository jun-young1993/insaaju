import 'package:insaaju/exceptions/unknown_exception.dart';

enum ChatRoomRole {
  button,
  system,
  assistant,
  user
}
extension ChatRoomRoleExtension on ChatRoomRole {
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
class ChatRoomMessage {
  final ChatRoomRole role;
  final String content;
  ChatRoomMessage({
    required this.role,
    required this.content
  });
}