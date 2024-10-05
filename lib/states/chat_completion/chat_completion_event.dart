import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_state.dart';

abstract class ChatCompletionEvent {
  const ChatCompletionEvent();
}

class FindSectionChatCompletionEvent extends ChatCompletionEvent {
  final Info info;
  FindSectionChatCompletionEvent({
    required this.info
  });
}

class SendFourPillarsOfDestinyTypeChatCompletionEvent extends ChatCompletionEvent {
  final FourPillarsOfDestinyType type;
  final Info info;
  SendFourPillarsOfDestinyTypeChatCompletionEvent({
    required this.type,
    required this.info
  });
}

class SendToDayDestinyChatCompletionEvent extends ChatCompletionEvent {
  final Info info;
  SendToDayDestinyChatCompletionEvent({
    required this.info
  });
}

class FindToDayDestinyChatCompletionEvent extends ChatCompletionEvent {
  final Info info;
  FindToDayDestinyChatCompletionEvent({
    required this.info
  });
}

