import 'package:insaaju/domain/entities/info.dart';

class ListState {
  final List<Info> list;
  final Info? me;
  final Exception? error;

  ListState._({
    this.list = const [],
    this.me,
    this.error
  });

  ListState.initialize() : this._();

  ListState copyWith({
    List<Info>? list,
    Info? me,
    Exception? error
  }){
    return ListState._(
      me: me ?? this.me,
      list: list ?? this.list,
      error: error ?? this.error
    );
  }
}