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
    on(_onInputDate);
    on(_onInputTime);
    on(_onInputHanja);
    on(_onChangeMenu);
    on(_onSave);
  }

  Future<void> _onInputName(
    InputNameEvent event,
    Emitter<InfoState> emit
  ) async {
    try{
      List<String> characters = event.name.split('');
      List<List<Map<String, dynamic>>> hanjaListByCharacters = await _infoRepository.getHanjaByCharacters(characters);
      emit(state.asSetName(event.name));
      emit(state.asSetHanjaList(hanjaListByCharacters));

    } on Exception catch(error){
      emit(state.asFailer(error));
    }
  }

  void _onInputDate(
    InputDateEvent event,
    Emitter<InfoState> emit
  ){
    try{
      emit(state.asSetDate(event.date));
    } on Exception catch(error){
      emit(state.asFailer(error));
    }
  }

  void _onInputTime(
    InputTimeEvent event,
    Emitter<InfoState> emit
  ){
    try{
      
      emit(state.asSetTime(event.time));
    } on Exception catch(error){
      emit(state.asFailer(error));
    }
  }

  void _onInputHanja(
      InputHanjaEvent event,
      Emitter<InfoState> emit
      ){
    try{

      emit(state.asSetHanja(event.hanja));
    } on Exception catch(error){
      emit(state.asFailer(error));
    }
  }

  void _onChangeMenu(
      InputMenuEvent event,
      Emitter<InfoState> emit
  ){
    try{

      emit(state.asSetMenu(event.menu));
    } on Exception catch(error){

      emit(state.asFailer(error));
    }
  }

  Future<void> _onSave(
    SaveEvent event,
    Emitter<InfoState> emit
  )async {
    try{
      emit(state.asChangeStatus(InfoStatus.saving));
      _infoRepository.save(event.info);
      emit(state.asChangeStatus(InfoStatus.saved));
    } on Exception catch(error){
      emit(state.asFailer(error));
    }
  }
  
}