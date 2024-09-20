import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/domain/entities/chat_session.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/repository/info_repository.dart';
import 'package:insaaju/repository/openai_repository.dart';
import 'package:insaaju/states/chat_completion/chat_completion_event.dart';
import 'package:insaaju/states/chat_completion/chat_completion_state.dart';

class ChatCompletionBloc extends Bloc<ChatCompletionEvent, ChatCompletionState> {
  final OpenaiRepository _openaiRepository;
  final InfoRepository _infoRepository;
  ChatCompletionBloc(
      this._openaiRepository, this._infoRepository,
  )
    : super(ChatCompletionState.initialize())
  {
    on(_onFindSection);
  }

  Future<void> _onFindSection(
      FindSectionChatCompletionEvent event,
      Emitter<ChatCompletionState> emit
  ) async {
    try{
      emit(state.asSectionLoadStatusProcessing());
      final String? mySessionId = event.info.mySessionId;
      if(mySessionId == null){
        final ChatSession chatSession = await _openaiRepository.createSession();
        
        final Info updateInfo = Info(
          event.info.name,
          event.info.date,
          event.info.time,
          mySessionId: chatSession.id
        );
        _infoRepository.update(event.info, updateInfo);
      }
      emit(state.asSectionLoadStatusComplete());
    } on Exception catch( error ) {
      print(error);
      emit(state.asFailer(error));
    }
  }
}