import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/domain/entities/info.dart';
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
    on(_onCheck);
    on(_onInitialize);
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

  Future<void> _onInputTime(
    InputTimeEvent event,
    Emitter<InfoState> emit
  ) async {
    try{
      emit(state.asSetTime(event.time));
      if(event.check == true){
        await _infoRepository.check(
          Info.fromState(state)
        );
      }
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

  Future<void> _onCheck(
    CheckEvent event,
    Emitter<InfoState> emit
  ) async {
    try{
      await _infoRepository.check(event.info);
      add(SaveEvent(info: event.info));
    } on Exception catch(error){
      emit(state.asFailer(error));
    }
  }

  Future<void> _onSave(
    SaveEvent event,
    Emitter<InfoState> emit
  )async {
    try{
      emit(state.copyWith(
          status: InfoStatus.saving,
          error: null
      ));
      _infoRepository.save(event.info);
      emit(state.asChangeStatus(InfoStatus.saved));
    } on Exception catch(error){
      emit(state.asFailer(error));
    }
  }

  Future<void> _onInitialize(
      InfoInitializeEvent event,
      Emitter<InfoState> emit
  )async {
    try {
      emit(state.asInitialize());
    } on Exception catch(error){
      emit(state.asFailer(error));
    }
  }
  
}