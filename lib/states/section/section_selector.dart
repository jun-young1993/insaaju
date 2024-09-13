import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/states/section/section_bloc.dart';
import 'package:insaaju/states/section/section_state.dart';

class SectionSelector<T> extends BlocSelector<SectionBloc, SectionState, T>{
    SectionSelector({
      super.key,
      required T Function(SectionState) selector,
      required Widget Function(T) builder
    }) : super(
      selector: selector,
      builder: (_, value) => builder(value)
    );
}

class ShowSectionSelector extends SectionSelector<SectionType> {
    ShowSectionSelector(Widget Function(SectionType) builder)
      : super(
          selector: (state) => state.section,
          builder: builder
      );
}