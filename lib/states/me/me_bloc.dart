import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/repository/info_repository.dart';
import 'package:insaaju/states/list/list_event.dart';
import 'package:insaaju/states/me/me_event.dart';
import 'package:insaaju/states/me/me_state.dart';


class MeBloc extends Bloc<MeEvent, MeState> {
  final InfoRepository _infoRepository;

  MeBloc(this._infoRepository)
    : super(MeState.initialize())
  {
    on(_onFind);
  }

  Future<void> _onFind(
      FindMeEvent event,
      Emitter<MeState> emit
  ) async {
    try{
      emit(state.copyWith(
        loadStatus: MeLoadStatus.loadProcessing
      ));
      final List<Info> info = await _infoRepository.getAll();
      emit(state.copyWith(
        info: info[0],
        loadStatus: MeLoadStatus.loadComplete
      ));
    } on Exception catch(error){
      emit(state.copyWith(
        error: error,
        loadStatus: MeLoadStatus.loadError
      ));
    }
  }


}