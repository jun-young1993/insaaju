import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/states/list/list_bloc.dart';
import 'package:insaaju/states/list/list_state.dart';

class ListSelector<T> extends BlocSelector<ListBloc, ListState, T> {
  ListSelector({
    required T Function(ListState) selector,
    required Widget Function(T) builder,
  }) : super(
    selector: selector,
    builder: (_, value) => builder(value),
  );
}

class AllListSelector extends ListSelector<List<Info>> {
  AllListSelector(Widget Function(List<Info>) builder)
      : super(
    selector: (state) => state.list,
    builder: builder,
  );
}

class ListLoadStatusSelector extends ListSelector<ListLoadStatus> {
  ListLoadStatusSelector(Widget Function(ListLoadStatus) builder)
      : super(
    selector: (state) => state.status,
    builder: builder,
  );
}

class ListErrorSelector extends ListSelector<Exception?> {
  ListErrorSelector(Widget Function(Exception?) builder)
    : super(
      selector: (state) => state.error,
      builder: builder
    );

}


