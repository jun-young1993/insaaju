import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/domain/entities/chat_room_message.dart';
import 'package:insaaju/states/chat_completion/chat_completion_bloc.dart';
import 'package:insaaju/states/chat_completion/chat_completion_state.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_state.dart';

class ChatCompletionSelector<T> extends BlocSelector<ChatCompletionBloc, ChatCompletionState, T> {
  ChatCompletionSelector({
    required T Function(ChatCompletionState) selector,
    required Widget Function(T) builder
  }) : super(
    selector: selector,
    builder: (_, value) => builder(value)
  );
}
class SectionChatCompletionSelector extends ChatCompletionSelector<SectionLoadStatus> {
  SectionChatCompletionSelector(Widget Function(SectionLoadStatus) builder)
  :super(
    selector: (state) => state.sectionLoadStatus,
    builder: builder
  );
}

class SectionMessageChatCompletionSelector extends ChatCompletionSelector<List<ChatRoomMessage>> {
  SectionMessageChatCompletionSelector(Widget Function(List<ChatRoomMessage>) builder)
  :super(
    selector: (state) => state.messages,
    builder: builder
  );
}


class SectionErrorChatCompletionSelector extends ChatCompletionSelector<Exception?> {
  SectionErrorChatCompletionSelector(Widget Function(Exception?) builder)
  :super(
    selector: (state) => state.error,
    builder: builder
  );
}

class SectionChatRequestTypeSelector extends ChatCompletionSelector<List<FourPillarsOfDestinyType>> {
    SectionChatRequestTypeSelector(Widget Function(List<FourPillarsOfDestinyType>) builder)
  :super(
    selector: (state) => state.types,
    builder: builder
  );
}