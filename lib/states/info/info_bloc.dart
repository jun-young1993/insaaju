import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/repository/info_repository.dart';
import 'package:insaaju/states/info/info_event.dart';
import 'package:insaaju/states/info/info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState>{
  final InfoRepository _infoRepository;

  InfoBloc(this._infoRepository) 
    : super(InfoState.initialize())
  {
    on(_onInputName);
  }

  void _onInputName(
    InputNameEvent event,
    Emitter<InfoState> emit
  ){
    try{
      emit(state.asSetName(event.name));
    } on Exception catch(error){
      emit(state.asFailer(error));
    }
  }
  
}