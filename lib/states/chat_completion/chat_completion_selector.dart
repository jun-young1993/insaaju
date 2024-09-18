import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/states/chat_completion/chat_completion_bloc.dart';
import 'package:insaaju/states/chat_completion/chat_completion_state.dart';

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