class InfoState {
  final String? name;
  final Exception? error;
  InfoState._({
    this.name,
    this.error
  });

  InfoState.initialize() : this._();

  InfoState asSetName(String name){
    return copyWith(name: name);
  }

  InfoState asFailer(Exception error){
    return copyWith(error: error);
  }

  InfoState copyWith({
    String? name,
    Exception? error
  }){
    return InfoState._(
      name: name ?? this.name,
      error: error ?? this.error
    );
  }
}