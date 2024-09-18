import 'package:insaaju/domain/entities/chat_complation.dart';
enum SectionLoadStatus {
  queue,
  processing,
  complete,
  fail
}
class ChatCompletionState {
  final List<ChatCompletion> chatCompletion;
  final Exception? error;
  final SectionLoadStatus sectionLoadStatus;

  ChatCompletionState._({
    this.chatCompletion = const [],
    this.error,
    this.sectionLoadStatus = SectionLoadStatus.queue
  });

  ChatCompletionState.initialize() : this._();

  ChatCompletionState asSectionLoadStatusProcessing(){
    return copyWith(sectionLoadStatus: SectionLoadStatus.processing);
  }

  ChatCompletionState asSectionLoadStatusComplete(){
    return copyWith(sectionLoadStatus: SectionLoadStatus.complete);
  }

  ChatCompletionState asSectionLoadStatusQueue(){
    return copyWith(sectionLoadStatus: SectionLoadStatus.queue);
  }

  ChatCompletionState asFailer(Exception error) {
    return copyWith(error: error);
  }

  ChatCompletionState copyWith({
    List<ChatCompletion>? chatCompletion,
    Exception? error,
    SectionLoadStatus? sectionLoadStatus
  }) {
    return ChatCompletionState._(
        sectionLoadStatus: sectionLoadStatus ?? this.sectionLoadStatus,
        chatCompletion: chatCompletion ?? this.chatCompletion,
        error: error ?? this.error
    );
  }
}