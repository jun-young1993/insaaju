import 'package:insaaju/domain/entities/info.dart';

class ListState {
  final List<Info>? list;
  final Exception? error;

  ListState._({
    this.list = const [],
    this.error
  });

  ListState.initialize() : this._();

  ListState copyWith({
    List<Info>? list,
    Exception? error
  }){
    return ListState._(
      list: list ?? this.list,
      error: error ?? this.error
    );
  }
}