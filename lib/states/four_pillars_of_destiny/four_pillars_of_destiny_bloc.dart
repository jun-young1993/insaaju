import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/configs/code_constants.dart';
import 'package:insaaju/domain/entities/code_item.dart';
import 'package:insaaju/repository/code_item_repository.dart';
import 'package:insaaju/repository/openai_repository.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_event.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_state.dart';

class FourPillarsOfDestinyBloc extends Bloc<FourPillarsOfDestinyEvent, FourPillarsOfDestinyState>{
  final OpenaiRepository _openaiRepository;
  final CodeItemRepository _codeItemRepository;
  FourPillarsOfDestinyBloc(this._openaiRepository, this._codeItemRepository)
    : super(FourPillarsOfDestinyState.initialize())
     {
      on(_onSetInfo);
      on(_onSendMessage);
      on(_initialize);
    }

    Future<void> _initialize(
      InitializeFourPillarsOfDestinyEvent event,
      Emitter<FourPillarsOfDestinyState> emit
    ) async {
      try{
        final fourPillarsOfDestinyData = await _openaiRepository.getAll(event.info);
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

    Future<void> _onSendMessage(
      SendMessageFourPillarsOfDestinyEvent event,
      Emitter<FourPillarsOfDestinyState> emit
    ) async {
      try{
        
        final CodeItem codeItem = await _codeItemRepository.fetchCodeItem(
          CodeConstants.message,
          event.fourPillarsOfDestinyType.getValue()
        );
        final String message = codeItem.value;
        
        final chatComplation = await _openaiRepository.sendMessage(
          CodeConstants.four_pillars_of_destiny, 
          message
        );
        final bool saved = await _openaiRepository.save(
          event.fourPillarsOfDestinyType, 
          chatComplation,
          event.info
        );
        add(InitializeFourPillarsOfDestinyEvent(info: event.info));
        if(!saved){
          throw Exception('fail saved');
        }
        
      } on Exception catch(error){
        
        emit(state.asFailer(error));
      }
    }
}