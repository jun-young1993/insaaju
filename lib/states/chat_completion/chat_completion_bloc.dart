import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/configs/code_constants.dart';
import 'package:insaaju/domain/entities/chat_room_message.dart';
import 'package:insaaju/domain/entities/chat_session.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/exceptions/required_exception.dart';
import 'package:insaaju/repository/info_repository.dart';
import 'package:insaaju/repository/openai_repository.dart';
import 'package:insaaju/states/chat_completion/chat_completion_event.dart';
import 'package:insaaju/states/chat_completion/chat_completion_state.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_state.dart';

class ChatCompletionBloc extends Bloc<ChatCompletionEvent, ChatCompletionState> {
  final OpenaiRepository _openaiRepository;
  final InfoRepository _infoRepository;
  ChatCompletionBloc(
      this._openaiRepository, this._infoRepository,
  )
    : super(ChatCompletionState.initialize())
  {
    on(_onFindSection);
    on(_onSendFourPillarsOfDstinyTypeChatCompletion);
  }

  Future<void> _onFindSection(
      FindSectionChatCompletionEvent event,
      Emitter<ChatCompletionState> emit
  ) async {
    try{
      emit(state.asSectionLoadStatusProcessing());
      late String? mySessionId = event.info.mySessionId;
      if(mySessionId == null){
        throw RequiredException<String>('my session id');
      }
      
      final List<ChatRoomMessage> messages = await _openaiRepository.findChatCompletion(mySessionId);

      emit(state.asSectionLoadStatusComplete(messages));
    } on Exception catch( error ) {
      
      emit(state.asFailer(error));
    }
  }

   Future<void> _onSendFourPillarsOfDstinyTypeChatCompletion(
      SendFourPillarsOfDestinyTypeChatCompletionEvent event,
      Emitter<ChatCompletionState> emit
    ) async {
      try{
        if(event.info.mySessionId == null){
          throw RequiredException<String>('my session id');
        }
        print(event.info.mySessionId);
        final List<ChatRoomMessage> messages = await _openaiRepository.findChatCompletion(event.info.mySessionId!);
        print(messages[0].role);
        print(messages[0].content);
        // _openaiRepository.sendMessage(
        //   CodeConstants.four_pillars_of_destiny_system_code, 
        //   event.type.getValue(),
        //   CodeConstants.gpt_base_model
        // );
        print('on click');
        print(state.messages);
        print(event.info);
        print(event.type);
      } on Exception catch ( error ){
        emit(state.asFailer(error));
      }
    }
}