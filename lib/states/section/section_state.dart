import 'package:insaaju/domain/entities/info.dart';

enum SectionType {
  unselected,
  addPeople,
  detailPeople
}
class SectionState {
  final SectionType section;
  final Exception? error;
  final Info? info;

  SectionState.initialize() : this._();

  SectionState._({
    this.error,
    this.section = SectionType.unselected,
    this.info
  });

  SectionState copyWith({
    SectionType? section,
    Exception? error,
    Info? info
  }){
    return SectionState._(
      section: section ?? this.section,
      error: error ?? this.error,
      info: info
    );
  }
}