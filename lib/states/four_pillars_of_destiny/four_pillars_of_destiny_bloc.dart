import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/repository/four_pillars_of_destiny_repository.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_event.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_state.dart';

class FourPillarsOfDestinyBloc extends Bloc<FourPillarsOfDestinyEvent, FourPillarsOfDestinyState>{
  final FourPillarsOfDestinyRepository _fourPillarsOfDestinyRepository;

  FourPillarsOfDestinyBloc(this._fourPillarsOfDestinyRepository)
    : super(FourPillarsOfDestinyState.initialize())
    {
      on(_onSetInfo);
    }

    Future<void> _onSetInfo(
      SelectedInfoFourPillarsOfDestinyEvent event,
      Emitter<FourPillarsOfDestinyState> emit
    )async {
      try{
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
        print(emit.type);
      } on Exception catch(error){
        emit(state.asFailer(error));
      }
    }
}