import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insaaju/states/section/section_event.dart';
import 'package:insaaju/states/section/section_state.dart';

class SectionBloc extends Bloc<SectionEvent, SectionState>{
    SectionBloc()
      : super(SectionState.initialize())
      {
        on(_onChangeSection);
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
}