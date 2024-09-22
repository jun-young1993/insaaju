import 'package:insaaju/domain/entities/info.dart';

enum SectionType {
  unselected,
  addPeople,
  detailPeople,
}
enum ChildSectionType {
  unselected,
  chatRoom
}
class SectionState {
  final SectionType section;
  final ChildSectionType? childSection;
  final Exception? error;
  final Info? info;

  SectionState.initialize() : this._();

  SectionState._({
    this.childSection = ChildSectionType.unselected,
    this.error,
    this.section = SectionType.unselected,
    this.info
  });

  SectionState copyWith({
    SectionType? section,
    ChildSectionType? childSection,
    Exception? error,
    Info? info
  }){
    return SectionState._(
      section: section ?? this.section,
      error: error ?? this.error,
      childSection: childSection ?? this.childSection,
      info: info
    );
  }
}