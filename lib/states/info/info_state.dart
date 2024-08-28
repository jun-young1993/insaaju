enum InfoMenu {
  name,
  birthDate,
  birthDateAndTime,
  check
}

class InfoState {
  final String? name;
  final Exception? error;
  final InfoMenu? menu;
  final String? date;
  final String? time;
  
  InfoState._({
    this.date, 
    this.time,
    this.name,
    this.error,
    this.menu = InfoMenu.name
  });

  InfoState.initialize() : this._();

  InfoState asSetName(String name){
    return copyWith(
      name: name,
      menu: InfoMenu.birthDate
    );
  }
  
  InfoState asSetDate(String date){
    return copyWith(
      date: date,
      menu: InfoMenu.birthDateAndTime
    );
  }

  InfoState asSetTime(String time){
    return copyWith(
      time: time,
      menu: InfoMenu.check
    );
  }

  InfoState asFailer(Exception error){
    return copyWith(error: error);
  }

  InfoState copyWith({
    String? name,
    String? date,
    String? time,
    Exception? error,
    InfoMenu? menu
  }){
    return InfoState._(
      date: date ?? this.date,
      time: time ?? this.time,
      name: name ?? this.name,
      error: error ?? this.error,
      menu: menu ?? this.menu
    );
  }
}