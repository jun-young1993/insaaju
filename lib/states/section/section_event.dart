import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/states/section/section_state.dart';

abstract class SectionEvent {
  const SectionEvent();
}

class ShowSectionEvent extends SectionEvent {
  final SectionType section;
  final Info? info;
  const ShowSectionEvent({
    required this.section,
    this.info
  });
}

class ShowChildSectionEvent extends SectionEvent {
  final ChildSectionType childSection;
  final Info? info;
  const ShowChildSectionEvent({
    required this.childSection,
    this.info
  }) ;
}