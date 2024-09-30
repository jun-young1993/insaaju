import 'package:insaaju/domain/entities/info.dart';
enum MeLoadStatus {
  loadQueue,
  loadIsEmpty,
  loadComplete,
  loadProcessing,
  loadError
}
class MeState {
  final Info? info;
  final Exception? error;
  final MeLoadStatus loadStatus;

  MeState._({
    this.info,
    this.error,
    this.loadStatus = MeLoadStatus.loadQueue,
  });

  MeState.initialize() : this._();

  MeState copyWith({
    Info? info,
    Exception? error,
    MeLoadStatus? loadStatus,
  }){
    return MeState._(
      info: info ?? this.info,
      error: error ?? this.error,
      loadStatus: loadStatus ?? this.loadStatus,
    );
  }
}