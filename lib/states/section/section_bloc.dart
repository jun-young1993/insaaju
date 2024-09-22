import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/states/section/section_event.dart';
import 'package:insaaju/states/section/section_state.dart';

class SectionBloc extends Bloc<SectionEvent, SectionState>{
    SectionBloc()
      : super(SectionState.initialize())
      {
        on(_onChangeSection);
        on(_onChangeChildSection);
      }

    Future<void> _onChangeSection(
        ShowSectionEvent event,
        Emitter<SectionState> emit
    ) async {
      try {
          emit(state.copyWith(
              section: event.section,
              info: event.info
          ));
      } on Exception catch( error ) {
          emit(state.copyWith(error: error));
      }
    }

    Future<void> _onChangeChildSection(
        ShowChildSectionEvent event,
        Emitter<SectionState> emit
    ) async {
      try {
          emit(state.copyWith(
              childSection: event.childSection,
              info: event.info
          ));
          
      } on Exception catch( error ) {
          emit(state.copyWith(error: error));
      }
    }
    
}