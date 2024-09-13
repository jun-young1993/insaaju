import 'package:insaaju/states/section/section_state.dart';

abstract class SectionEvent {
  const SectionEvent();
}

class ShowSectionEvent extends SectionEvent {
  final SectionType section;
  const ShowSectionEvent({
    required this.section
  });
}