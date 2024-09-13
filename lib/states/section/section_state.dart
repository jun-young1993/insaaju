enum SectionType {
 unselected,
 addPeople
}
class SectionState {
  final SectionType section;
  final Exception? error;

  SectionState.initialize() : this._();

  SectionState._({
    this.error,
    this.section = SectionType.unselected
  });

  SectionState copyWith({
    SectionType? section,
    Exception? error
  }){
    return SectionState._(
      section: section ?? this.section,
      error: error ?? this.error
    );
  }
}