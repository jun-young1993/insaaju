import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/configs/code_constants.dart';
import 'package:insaaju/domain/entities/chat_room_message.dart';
import 'package:insaaju/domain/entities/chat_session.dart';
import 'package:insaaju/domain/entities/code_item.dart';
import 'package:insaaju/domain/entities/info.dart';
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
    on(_onSendFourPillarsOfDstinyTypeChatCompletion);
  }

  Future<void> _onFindSection(
      FindSectionChatCompletionEvent event,
      Emitter<ChatCompletionState> emit
  ) async {
    try{
      emit(state.asSectionLoadStatusProcessing());
      late String? mySessionId = event.info.mySessionId;
      print('sessionId: ${mySessionId}');
      
      if(mySessionId == null){
        throw RequiredException<String>('my session id');
      }
      
      final List<ChatRoomMessage> messages = await _openaiRepository.findChatCompletion(mySessionId);

      final List<ChatRoomMessage> chatRoomMessages = messages.expand((message) {
        final FourPillarsOfDestinyType? userType = FourPillarsOfDestinyTypeExtension.fromValue(message.userPromptCodeItem.key);
        if (userType != null) {
          return [
            ChatRoomMessage(
              role: ChatRoomRole.button,
              content: userType.getTitle(),
              systemPromptCodeItem: CodeItem.copyWith(key: userType.getValue()), 
              userPromptCodeItem: CodeItem.copyWith(key: userType.getValue()),
            ),
            message
          ];
        }
        return [message];
      }).toList();

      // `userType`이 null인 경우를 추적
      final Set<FourPillarsOfDestinyType> existingTypes = messages
          .map((message) => FourPillarsOfDestinyTypeExtension.fromValue(message.userPromptCodeItem.key))
          .where((userType) => userType != null)
          .cast<FourPillarsOfDestinyType>()
          .toSet();

      // `FourPillarsOfDestinyType`에서 빠진 요소들 추가
      final List<ChatRoomMessage> missingMessages = FourPillarsOfDestinyType.values
          .where((type) => !existingTypes.contains(type))
          .map((type) => ChatRoomMessage(
                role: ChatRoomRole.button,
                content: type.getTitle(),
                systemPromptCodeItem: CodeItem.copyWith(key: type.getValue()),
                userPromptCodeItem: CodeItem.copyWith(key: type.getValue()),
              ))
          .toList();

      // 빠진 요소들을 `chatRoomMessages`의 맨 뒤에 추가
      chatRoomMessages.addAll(missingMessages);
      emit(state.asSectionLoadStatusComplete(chatRoomMessages));
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
        
        final ChatRoomMessage fourPillarsOfDestinyMessage = messages.firstWhere((message) => FourPillarsOfDestinyType.fourPillarsOfDestiny.hasSameValue(message.userPromptCodeItem.key));
        if(fourPillarsOfDestinyMessage == null){
          throw RequiredException('fourPillarsOfDestiny');
        }
        final CodeItem fourPillarsOfDestinyCodeItem = await _codeItemRepository.fetchCodeItem(CodeConstants.userPromptTemplate, FourPillarsOfDestinyType.fourPillarsOfDestiny.getValue());
        
        final List<ChatBaseRoomMessage> sendMessages = [
          ChatBaseRoomMessage(content: fourPillarsOfDestinyCodeItem.value, role: ChatRoomRole.user),
          ChatBaseRoomMessage(content: event.info.toString(), role: ChatRoomRole.user),
          ChatBaseRoomMessage(content: fourPillarsOfDestinyMessage.content, role: ChatRoomRole.assistant),
        ];

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
        emit(state.asFailer(error));
      }
    }
}