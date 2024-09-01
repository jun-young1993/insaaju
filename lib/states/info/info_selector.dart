import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/states/info/info_bloc.dart';
import 'package:insaaju/states/info/info_state.dart';

class InfoSelector<T> extends BlocSelector<InfoBloc, InfoState, T>{
  InfoSelector({
    required T Function(InfoState) selector,
    required Widget Function(T) builder,
  }): super(
    selector: selector,
    builder: (_, value) => builder(value)
  );
}

class InfoNameStateSelector extends InfoSelector<String?> {
  InfoNameStateSelector(Widget Function(String?) builder)
  : super(
    selector: (state) => state.name,
    builder: builder
  );
}

class InfoHanjaStateSelector extends InfoSelector<List<String>?> {
  InfoHanjaStateSelector(Widget Function(List<String>?) builder)
      : super(
      selector: (state) => state.hanja,
      builder: builder
  );
}

class InfoStateSelector extends InfoSelector<InfoState> {
  InfoStateSelector(Widget Function(InfoState) builder)
  : super(
    selector: (state) => state,
    builder: builder
  );
}