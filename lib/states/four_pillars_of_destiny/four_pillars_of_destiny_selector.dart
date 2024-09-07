import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/domain/entities/chat_complation.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_bloc.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_state.dart';

class FourPillarsOfDestinySelector<T> extends BlocSelector<FourPillarsOfDestinyBloc, FourPillarsOfDestinyState, T>{
  FourPillarsOfDestinySelector({
    required T Function(FourPillarsOfDestinyState) selector,
    required Widget Function(T) builder,
  }): super(
    selector: selector,
    builder: (_, value) => builder(value)
  );
}

class InfoFourPillarsOfDestinySelector extends FourPillarsOfDestinySelector<Info?> {
  InfoFourPillarsOfDestinySelector(Widget Function(Info?) builder)
    :super(
      selector: (state) => state.info,
      builder: builder
    );
}

class FourPillarsOfDestinyDataSelector extends FourPillarsOfDestinySelector<Map<FourPillarsOfDestinyType,ChatComplation?>?> {
    FourPillarsOfDestinyDataSelector(Widget Function(Map<FourPillarsOfDestinyType,ChatComplation?>?) builder)
    :super(
      selector: (state) => state.fourPillarsOfDestinyData,
      builder: builder
    );
}

class LoadingFourPillarsOfDestinySelector extends FourPillarsOfDestinySelector<bool> {
    LoadingFourPillarsOfDestinySelector(Widget Function(bool) builder)
        :super(
          selector: (state) => state.loading,
          builder: builder
    );
}

