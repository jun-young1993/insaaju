import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/repository/info_repository.dart';
import 'package:insaaju/states/list/list_event.dart';
import 'package:insaaju/states/list/list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  final InfoRepository _infoRepository;

  ListBloc(this._infoRepository)
    : super(ListState.initialize())
  {
    on(_onAllList);
    on(_onMe);
  }

  Future<void> _onAllList(
      AllListEvent event,
      Emitter<ListState> emit
  ) async {
    try{
      final List<Info> list = await _infoRepository.getAll();
      emit(state.copyWith(list: list));
    } on Exception catch(error){
      emit(state.copyWith(error: error));
    }

  }

  Future<void> _onMe(
      MeEvent event,
      Emitter<ListState> emit
  ) async {
    try{
      final List<Info> list = await _infoRepository.getAll();
      emit(state.copyWith(me: list[0]));
    } on Exception catch(error){
      emit(state.copyWith(error: error));
    }

  }

}