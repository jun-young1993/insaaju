import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/states/me/me_bloc.dart';
import 'package:insaaju/states/me/me_state.dart';


class MeSelector<T> extends BlocSelector<MeBloc, MeState, T> {
  MeSelector({
    super.key, 
    required T Function(MeState) selector,
    required Widget Function(T) builder,
  }) : super(
    selector: selector,
    builder: (_, value) => builder(value),
  );
}

class MeFindSelector extends MeSelector<Info> {
  MeFindSelector(Widget Function(Info) builder)
      : super(
    selector: (state) => state.info!,
    builder: builder,
  );
}

class MeLoadStatusSelector extends MeSelector<MeLoadStatus> {
  MeLoadStatusSelector(Widget Function(MeLoadStatus) builder)
      : super(
    selector: (state) => state.loadStatus,
    builder: builder,
  );
}

class MeErrorSelector extends MeSelector<Exception?> {
  MeErrorSelector(Widget Function(Exception?) builder)
    : super(
      selector: (state) => state.error,
      builder: builder
    );

}