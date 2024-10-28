import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/configs/code_constants.dart';
import 'package:insaaju/domain/entities/code_item.dart';
import 'package:insaaju/repository/code_item_repository.dart';
import 'package:insaaju/repository/four_pillars_of_destiny_repository.dart';
import 'package:insaaju/repository/openai_repository.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_event.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_state.dart';
import 'package:insaaju/utills/format_string.dart';

class FourPillarsOfDestinyBloc extends Bloc<FourPillarsOfDestinyEvent, FourPillarsOfDestinyState>{
  final OpenaiRepository _openaiRepository;
  final CodeItemRepository _codeItemRepository;
  final FourPillarsOfDestinyRepository _fourPillarsOfDestinyRepository;
  FourPillarsOfDestinyBloc(
      this._openaiRepository,
      this._codeItemRepository,
      this._fourPillarsOfDestinyRepository
  )
    : super(FourPillarsOfDestinyState.initialize())
     {
      on(_onSetInfo);
      on(_onSendMessage);
      on(_initialize);
      on(_onUnSelected);
      on(_onSendCompatibilityMessage);
      on(_onShowFourPillarsOfDestiny);
    }

    Future<void> _initialize(
      InitializeFourPillarsOfDestinyEvent event,
      Emitter<FourPillarsOfDestinyState> emit
    ) async {
      try{
        final fourPillarsOfDestinyData = await _fourPillarsOfDestinyRepository.getFourPillarsOfDestinyList(event.info);
        emit(state.copyWith(fourPillarsOfDestinyData: fourPillarsOfDestinyData));
      } on Exception catch (error) {
        emit(state.asFailer(error));
      }
    }

    Future<void> _onSetInfo(
      SelectedInfoFourPillarsOfDestinyEvent event,
      Emitter<FourPillarsOfDestinyState> emit
    )async {
      try{
        add(InitializeFourPillarsOfDestinyEvent(info: event.info));
        emit(state.asSetInfo(event.info));
      } on Exception catch(error){
        emit(state.asFailer(error));
      }
    }

    Future<void> _onUnSelected(
        UnSelectedInfoFourPillarsOfDestinyEvent event,
        Emitter<FourPillarsOfDestinyState> emit
    )async {
      try{
        emit(state.asInitialize());
      } on Exception catch( error ){
        emit(state.asFailer(error));
      }
    }

    Future<void> _onSendCompatibilityMessage(
        SendMessageFourPillarsOfDestinyCompatibilityEvent event,
        Emitter<FourPillarsOfDestinyState> emit
    ) async {
      try {
        final CodeItem messageCodeItem = await _codeItemRepository.fetchCodeItem(
            CodeConstants.four_pillars_of_destiny_compatibility_message_template,
            event.fourPillarsOfDestinyCompatibilityType.getValue()
        );
        final message = formatString(
            messageCodeItem.value,
            [
              event.info[0].name,event.info[0].date.toString(), event.info[0].time.toString(),
              event.info[1].name,event.info[1].date.toString(), event.info[1].time.toString()
            ]
        );
        print(message);
      } on Exception catch( error ){
        emit(state.asFailer(error));
      }
    }

    Future<void> _onShowFourPillarsOfDestiny(
      ShowFourPillarsOfDestinyEvent event,
      Emitter<FourPillarsOfDestinyState> emit
    ) async {
      try {
        emit(state.asLoading(true));
        final fourPillarsOfDestinyStructure = await _fourPillarsOfDestinyRepository.getFourPillarsOfDestiny(event.info);
        print('fourPillarsOfDestinyStructure');
        print(fourPillarsOfDestinyStructure);
        emit(state.asFourPillarsOfDestinyStrcture(fourPillarsOfDestinyStructure));
        emit(state.asLoading(false));
      } on Exception catch ( error ){
        print(error);
        emit(state.asLoading(false));
        emit(state.asFailer(error));
        
      }
    }

    Future<void> _onSendMessage(
      SendMessageFourPillarsOfDestinyEvent event,
      Emitter<FourPillarsOfDestinyState> emit
    ) async {
      try{
          emit(state.asLoading(true));
          final CodeItem messageCodeItem = await _codeItemRepository.fetchCodeItem(
            CodeConstants.four_pillars_of_destiny_message_template,
            event.fourPillarsOfDestinyType.getValue()
        );
        final message = formatString(
            messageCodeItem.value,
            [
              event.info.name,
              event.info.date.toString(),
              event.info.time.toString(),
            ]
        );
        
        // final chatCompilation = await _openaiRepository.sendMessage(
        //   event.fourPillarsOfDestinyType.getValue(),
        //   event.modelCode,
        //   message
        // );

        // final bool saved = await _fourPillarsOfDestinyRepository.saveFourPillarsOfDestiny(
        //   event.fourPillarsOfDestinyType,
        //   chatCompilation,
        //   event.info
        // );
        add(InitializeFourPillarsOfDestinyEvent(info: event.info));
        // if(!saved){
        //   throw Exception('fail saved');
        // }
        emit(state.asLoading(false));
      } on Exception catch(error){

        emit(state.asFailer(error));
      }
    }

}