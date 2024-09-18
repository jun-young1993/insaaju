import 'package:insaaju/domain/entities/info.dart';

abstract class ChatCompletionEvent {
  const ChatCompletionEvent();
}

class FindSectionChatCompletionEvent extends ChatCompletionEvent {
  final Info info;
  FindSectionChatCompletionEvent({
    required this.info
  });
}