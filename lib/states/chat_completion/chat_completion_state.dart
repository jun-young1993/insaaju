import 'package:insaaju/domain/entities/chat_complation.dart';
import 'package:insaaju/domain/entities/chat_room_message.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_state.dart';
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
  final List<ChatRoomMessage> messages;
  final List<FourPillarsOfDestinyType> types;

  ChatCompletionState._({
    this.chatCompletion = const [],
    this.error,
    this.sectionLoadStatus = SectionLoadStatus.queue,
    this.messages = const [],
    this.types = const [FourPillarsOfDestinyType.yongsinAndGisin, FourPillarsOfDestinyType.daewoon, FourPillarsOfDestinyType.sipsinAnalysis]
  });

  ChatCompletionState.initialize() : this._();

  ChatCompletionState asSectionLoadStatusProcessing(){
    return copyWith(sectionLoadStatus: SectionLoadStatus.processing);
  }

  ChatCompletionState asSectionLoadStatusComplete(List<ChatRoomMessage> messages){
    return copyWith(sectionLoadStatus: SectionLoadStatus.complete, messages: messages);
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
    SectionLoadStatus? sectionLoadStatus,
    List<ChatRoomMessage>? messages
  }) {
    return ChatCompletionState._(
        sectionLoadStatus: sectionLoadStatus ?? this.sectionLoadStatus,
        chatCompletion: chatCompletion ?? this.chatCompletion,
        error: error ?? this.error,
        messages: messages ?? this.messages
    );
  }
}