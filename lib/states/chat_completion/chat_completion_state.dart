import 'package:insaaju/domain/entities/chat_complation.dart';

class ChatCompletionState {
  final List<ChatCompletion> chatCompletion;

  ChatCompletionState._({
    this.chatCompletion = const []
  });

  ChatCompletionState.initialize() : this._();
}