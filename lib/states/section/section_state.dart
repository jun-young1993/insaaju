import 'package:insaaju/domain/entities/info.dart';

enum SectionType {
  unselected,
  addPeople,
  addMe,
  detailPeople,
}
extension SectionTypeExtension on SectionType {
  String  getTitle(){
    switch(this){
      case SectionType.addPeople:
        return '친구 추가하기';
      case SectionType.addMe:
        return '프로필 생성하기';
      default:
        return 'unknown';
    }
  }
}
enum ChildSectionType {
  unselected,
  chatRoom,
  toDayDestiny
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