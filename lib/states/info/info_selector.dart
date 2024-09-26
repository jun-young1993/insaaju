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

class InfoMenuSelector extends InfoSelector<InfoMenu> {
  InfoMenuSelector(Widget Function(InfoMenu) builder)
  : super(
    selector: (state) => state.menu,
    builder:builder
  );
}

class InfoFailSelector extends InfoSelector<Exception?> {
  InfoFailSelector(Widget Function(Exception?) builder)
      : super(
      selector: (state) => state.error,
      builder:builder
  );
}

class InfoStatusSelector extends InfoSelector<InfoStatus> {
  InfoStatusSelector(Widget Function(InfoStatus) builder)
      : super(
      selector: (state) => state.status,
      builder:builder
  );
}

class InfoRemoveSelector extends InfoSelector<InfoRemoveStatus> {
  InfoRemoveSelector(Widget Function(InfoRemoveStatus) builder)
    : super(
      selector: (state) => state.removeStatus,
      builder: builder
    );
}