import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/configs/code_constants.dart';
import 'package:insaaju/domain/entities/chat_room_message.dart';
import 'package:insaaju/domain/entities/chat_session.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/repository/code_item_repository.dart';
import 'package:insaaju/repository/info_repository.dart';
import 'package:insaaju/repository/openai_repository.dart';
import 'package:insaaju/states/info/info_event.dart';
import 'package:insaaju/states/info/info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState>{
  final InfoRepository _infoRepository;
  final OpenaiRepository _openaiRepository;
  final CodeItemRepository _codeItemRepository;
  InfoBloc(
    this._infoRepository, 
    this._openaiRepository,
    this._codeItemRepository
  ) 
    : super(InfoState.initialize())
  {
    on(_onInputName);
    on(_onInputDate);
    on(_onInputTime);
    on(_onChangeMenu);
    on(_onSave);
    on(_onCheck);
    on(_onInitialize);
    on(_onRemove);
    on(_onChangeStatus);
    on(_onInputSolarAndLunar);
    on(_onInputGender);
  }

  Future<void> _onInputName(
    InputNameEvent event,
    Emitter<InfoState> emit
  ) async {
    try{
      
      emit(state.asSetName(event.name));
      emit(state.asHasMissingFieldStatus());
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
      emit(state.asHasMissingFieldStatus());
    } on Exception catch(error){
      emit(state.asFailer(error));
    }
  }

  void _onInputSolarAndLunar(
    InputSolarAndLunarEvent event,
    Emitter<InfoState> emit
  ){
    try{
      emit(state.asSetSolarAndLunar(event.solarAndLunar));
      emit(state.asHasMissingFieldStatus());
    } on Exception catch(error){
      emit(state.asFailer(error));
    }
  }

  void _onInputGender(
    InputGenderEvent event,
    Emitter<InfoState> emit
  ){
    try {
      emit(state.asGender(event.gender));
      emit(state.asHasMissingFieldStatus());
    } on Exception catch( error ){
      emit(state.asFailer(error));
    }
  }

  Future<void> _onInputTime(
    InputTimeEvent event,
    Emitter<InfoState> emit
  ) async {
    try{
      emit(state.asSetTime(event.time));
      emit(state.asHasMissingFieldStatus());
      if(event.check == true){
        await _infoRepository.check(
          Info.fromState(state)
        );
      }
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
      // add(SaveEvent(info: event.info));
    } on Exception catch(error){
      emit(state.asFailer(error));
    }
  }

  Future<void> _onRemove(
    RemoveInfoEvent event,
    Emitter<InfoState> emit
  ) async {
    try{
      emit(state.copyWith(removeStatus: InfoRemoveStatus.processing));
      _infoRepository.remove(event.info);
      emit(state.copyWith(removeStatus: InfoRemoveStatus.complete));
    } on Exception catch(error) {
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
      final ChatSession session = await _openaiRepository.createSession();
      final sessionId = session.id;
      
      final info = Info.fromState(
        event.infoState.asSetSessionId(sessionId)
      );
      
      // event.info.setMySession(session);
      await _infoRepository.save(info);

      // await _openaiRepository.sendMessage(
      //   CodeConstants.four_pillars_of_destiny_system_code,
      //   FourPillarsOfDestinyType.fourPillarsOfDestiny.getValue(),
      //   CodeConstants.gpt_base_model,
      //   session.id,
      //   [
      //     ChatBaseRoomMessage(content: event.info.toString(), role: ChatRoomRole.user)
      //   ]
      // );
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

  Future<void> _onChangeStatus(
      ChangeInfoStatusEvent event,
      Emitter<InfoState> emit
  ) async {
    try {
      emit(state.copyWith(status: event.infoStatus));
      print('bloc change ${event.infoStatus}');
    } on Exception catch( error ) {
      emit(state.asFailer(error));
    }
  }
}