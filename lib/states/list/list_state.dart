import 'package:insaaju/domain/entities/info.dart';
enum ListLoadStatus {
  loadQueue,
  loadComplete,
  loadProcessing,
  loadError
}
class ListState {
  final List<Info> list;
  final Exception? error;
  final ListLoadStatus status;
  ListState._({
    this.list = const [],
    this.error,
    this.status = ListLoadStatus.loadQueue,
  });

  ListState.initialize() : this._();

  ListState copyWith({
    List<Info>? list,
    Exception? error,
    ListLoadStatus? status
  }){
    return ListState._(
      list: list ?? this.list,
      error: error ?? this.error,
      status: status ?? this.status
    );
  }
}