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
  }

  // Info 객체에서 searchText가 포함되어 있는지 확인하는 메소드
  bool _containsSearchText(Info info, String searchText) {
    // 여기서 Info의 특정 필드에 searchText가 포함되는지 확인
    // 예: info.name에 searchText가 포함되는지 확인
    return info.name.toLowerCase().contains(searchText.toLowerCase());
  }

  Future<void> _onAllList(
      AllListEvent event,
      Emitter<ListState> emit
  ) async {
    try{
      emit(state.copyWith(
        status: ListLoadStatus.loadProcessing
      ));
      final String? searchText = event.searchText;
      final List<Info> list = await _infoRepository.getAll();

      final List<Info> filteredList = (searchText != null && searchText.isNotEmpty)
          ? list.where((info) => _containsSearchText(info, searchText)).toList()
          : list;

      emit(state.copyWith(
        list: filteredList,
        status: ListLoadStatus.loadComplete
      ));
    } on Exception catch(error){
      emit(state.copyWith(
        error: error,
        status: ListLoadStatus.loadError
      ));
    }
  }


}