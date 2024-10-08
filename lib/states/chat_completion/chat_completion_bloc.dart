import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/configs/code_constants.dart';
import 'package:insaaju/domain/entities/chat_room_message.dart';
import 'package:insaaju/domain/entities/code_item.dart';
import 'package:insaaju/exceptions/four_of_destiny_required_exception.dart';
import 'package:insaaju/exceptions/not_found_exception.dart';
import 'package:insaaju/exceptions/required_exception.dart';
import 'package:insaaju/repository/code_item_repository.dart';
import 'package:insaaju/repository/info_repository.dart';
import 'package:insaaju/repository/openai_repository.dart';
import 'package:insaaju/states/chat_completion/chat_completion_event.dart';
import 'package:insaaju/states/chat_completion/chat_completion_state.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_state.dart';

class ChatCompletionBloc extends Bloc<ChatCompletionEvent, ChatCompletionState> {
  final OpenaiRepository _openaiRepository;
  final InfoRepository _infoRepository;
  final CodeItemRepository _codeItemRepository;
  ChatCompletionBloc(
      this._openaiRepository, 
      this._infoRepository,
      this._codeItemRepository
  )
    : super(ChatCompletionState.initialize())
  {
    on(_onFindSection);
    on(_onSendFourPillarsOfDestinyTypeChatCompletion);
    on(_onFindToDayDestinyChatCompletion);
    on(_onSendFourPillarsOfDestinyToDay);
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
      DateTime now = DateTime.now();
      DateTime startOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0);
      DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

      final List<ChatRoomMessage> messages = await _openaiRepository.findChatCompletion(
          mySessionId,
          query: {
            'system_prompt_code_item_key': CodeConstants.four_pillars_of_destiny_system_code,
          }
      );
      emit(state.asSectionLoadStatusComplete(messages));
    } on Exception catch( error ) {
      emit(state.copyWith(
        sectionLoadStatus: SectionLoadStatus.fail,
        error: error
      ));
    }
  }

  Future<void> _onSendFourPillarsOfDestinyTypeChatCompletion(
      SendFourPillarsOfDestinyTypeChatCompletionEvent event,
      Emitter<ChatCompletionState> emit
  ) async {
      try{

        if(event.info.mySessionId == null){
          throw RequiredException<String>('my session id');
        }

        emit(state.asSectionLoadStatusProcessingType());
        final List<ChatRoomMessage> messages = await _openaiRepository.findChatCompletion(event.info.mySessionId!);
        final ChatRoomMessage? isMessage = messages.firstWhereOrNull(
          (message) => event.type.hasSameValue(message.userPromptCodeItem.key)
        );
        if(isMessage != null){
          emit(state.asSectionLoadStatusCompleteType());
          add(FindSectionChatCompletionEvent(info: event.info));
          return;
        }
        

        final CodeItem fourPillarsOfDestinyCodeItem = await _codeItemRepository.fetchCodeItem(CodeConstants.userPromptTemplate, FourPillarsOfDestinyType.fourPillarsOfDestiny.getValue());
        
        final List<ChatBaseRoomMessage> sendMessages = [
          ChatBaseRoomMessage(content: fourPillarsOfDestinyCodeItem.value, role: ChatRoomRole.user),
          ChatBaseRoomMessage(content: event.info.toString(), role: ChatRoomRole.user),
        ];
        final ChatRoomMessage? fourPillarsOfDestinyMessage = messages.firstWhereOrNull((message) => FourPillarsOfDestinyType.fourPillarsOfDestiny.hasSameValue(message.userPromptCodeItem.key));

        if(
            event.type != FourPillarsOfDestinyType.fourPillarsOfDestiny
            && fourPillarsOfDestinyMessage == null
        ){
          throw FourOfDestinyRequiredException('fourPillarsOfDestiny');
        }else{
          if(fourPillarsOfDestinyMessage != null){
            sendMessages.add(ChatBaseRoomMessage(content: fourPillarsOfDestinyMessage!.content, role: ChatRoomRole.assistant));
          }
        }

        await _openaiRepository.sendMessage(
          CodeConstants.four_pillars_of_destiny_system_code,
          event.type.getValue(),
          CodeConstants.gpt_base_model,
          event.info.mySessionId!,
          sendMessages
        );
        emit(state.asSectionLoadStatusCompleteType());
        add(FindSectionChatCompletionEvent(info: event.info));
        
      } on Exception catch ( error ){
        emit(state.copyWith(
            sectionLoadStatus: SectionLoadStatus.fail,
            error: error
        ));
      }
    }

  Future<void> _onFindToDayDestinyChatCompletion(
      FindToDayDestinyChatCompletionEvent event,
      Emitter<ChatCompletionState> emit
  ) async {
    try {
      emit(state.copyWith(
        toDayStatus: ToDayStatus.processing
      ));
      late String? mySessionId = event.info.mySessionId;
      if(mySessionId == null){
        throw RequiredException<String>('my session id');
      }
      DateTime now = DateTime.now();
      DateTime startOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0);
      DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
      final List<ChatRoomMessage> messages = await _openaiRepository.findChatCompletion(
          mySessionId,
          query: {
            'system_prompt_code_item_key': CodeConstants.four_pillars_of_destiny_to_day_system_code,
            'start_date' : startOfDay,
            'end_date': endOfDay
          }
      );
      
      if(messages.isEmpty){
        emit(state.copyWith(
            toDayStatus: ToDayStatus.isEmpty
        ));
      }else{
        emit(state.copyWith(
            toDayStatus: ToDayStatus.complete,
            messages: messages
        ));
      }
    } on NotFoundException catch ( error ) {
      emit(state.copyWith(
        toDayStatus: ToDayStatus.isEmpty
      ));
    } on Exception catch( error ) {
      print(error);
      emit(state.copyWith(
          toDayStatus: ToDayStatus.fail,
          error: error
      ));
    }
  }

  Future<void> _onSendFourPillarsOfDestinyToDay(
      SendToDayDestinyChatCompletionEvent event,
      Emitter<ChatCompletionState> emit
  ) async {
    try {
      emit(state.copyWith(
          toDayStatus: ToDayStatus.processing
      ));
      late String? mySessionId = event.info.mySessionId;
      if(mySessionId == null){
        throw RequiredException<String>('my session id');
      }

      final List<ChatRoomMessage> messages = await _openaiRepository.findChatCompletion(mySessionId);
      final ChatRoomMessage? fourPillarsOfDestinyMessage = messages.firstWhereOrNull((message) => FourPillarsOfDestinyType.fourPillarsOfDestiny.hasSameValue(message.userPromptCodeItem.key));
      final CodeItem fourPillarsOfDestinyCodeItem = await _codeItemRepository.fetchCodeItem(CodeConstants.userPromptTemplate, FourPillarsOfDestinyType.fourPillarsOfDestiny.getValue());

      final List<ChatBaseRoomMessage> sendMessages = [
        ChatBaseRoomMessage(content: fourPillarsOfDestinyCodeItem.value, role: ChatRoomRole.user),
        ChatBaseRoomMessage(content: event.info.toString(), role: ChatRoomRole.user),
      ];
      if(
      fourPillarsOfDestinyMessage == null
      ){
        throw FourOfDestinyRequiredException('fourPillarsOfDestiny');
      }else{
        sendMessages.add(ChatBaseRoomMessage(content: fourPillarsOfDestinyMessage!.content, role: ChatRoomRole.assistant));
      }

      sendMessages.add(ChatBaseRoomMessage(role: ChatRoomRole.user, content: "Today's date is ${DateTime.now()}"));
      await _openaiRepository.sendMessage(
          CodeConstants.four_pillars_of_destiny_to_day_system_code,
          CodeConstants.four_pillars_of_destiny_to_day_user_code,
          CodeConstants.gpt_base_model,
          event.info.mySessionId!,
          sendMessages
      );
      emit(state.copyWith(
          toDayStatus: ToDayStatus.complete
      ));
      add(FindToDayDestinyChatCompletionEvent(info: event.info));
    } on Exception catch( error ) {
      emit(state.copyWith(
          toDayStatus: ToDayStatus.fail,
          error: error
      ));
    }
  }
}