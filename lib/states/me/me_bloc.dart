import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/domain/entities/chat_session.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/repository/info_repository.dart';
import 'package:insaaju/repository/openai_repository.dart';
import 'package:insaaju/states/info/info_bloc.dart';
import 'package:insaaju/states/info/info_event.dart';
import 'package:insaaju/states/info/info_state.dart';
import 'package:insaaju/states/me/me_event.dart';
import 'package:insaaju/states/me/me_state.dart';


class MeBloc extends Bloc<MeEvent, MeState> {
  final InfoRepository _infoRepository;
  final OpenaiRepository _openaiRepository;
  final InfoBloc _infoBloc;

  MeBloc(this._infoRepository, this._openaiRepository, this._infoBloc)
    : super(MeState.initialize())
  {
    on(_onFind);
    on(_onSave);
  }

  Future<void> _onSave(
    SaveMeInfoEvent event,
    Emitter<MeState> emit
  ) async {
    try {
      _infoBloc.add(const ChangeInfoStatusEvent(InfoStatus.saving));
      final ChatSession session = await _openaiRepository.createSession();
      final sessionId = session.id;

      final info = Info.fromState(
        event.infoState.asSetSessionId(sessionId)
      );

      await _infoRepository.saveOrUpdateMe(info);
      // await _openaiRepository.sendMessage(
      //     CodeConstants.four_pillars_of_destiny_system_code,
      //     FourPillarsOfDestinyType.fourPillarsOfDestiny.getValue(),
      //     CodeConstants.gpt_base_model,
      //     session.id,
      //     [
      //       ChatBaseRoomMessage(content: info.toString(), role: ChatRoomRole.user)
      //     ]
      // );
      _infoBloc.add(const ChangeInfoStatusEvent(InfoStatus.saved));
      add(const FindMeEvent());
    } on Exception catch( error ) {
      emit(state.copyWith(
          error: error
      ));
    } catch ( error ) {
      print(error);
      emit(state.copyWith(
          error: Exception(error.toString())
      ));
    }
  }

  Future<void> _onFind(
      FindMeEvent event,
      Emitter<MeState> emit
  ) async {
    try{
      emit(state.copyWith(
        loadStatus: MeLoadStatus.loadProcessing
      ));
      final Info? info = await _infoRepository.findMe();

      if(info == null){
        emit(state.copyWith(loadStatus: MeLoadStatus.loadIsEmpty));
      }else{
        emit(state.copyWith(
            info: info,
            loadStatus: MeLoadStatus.loadComplete
        ));
      }

    } on Exception catch(error){
      emit(state.copyWith(
        error: error,
        loadStatus: MeLoadStatus.loadError
      ));
    } catch ( error ){
      emit(state.copyWith(
        error: Exception(error.toString()),
        loadStatus: MeLoadStatus.loadError
      ));
    }
  }


}