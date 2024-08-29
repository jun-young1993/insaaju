enum InfoMenu {
  name,
  hanja,
  birthDate,
  birthDateAndTime,
  check
}

class InfoState {
  final String? name;
  final String? hanja;
  final Exception? error;
  final InfoMenu? menu;
  final String? date;
  final String? time;
  final List<List<Map<String, dynamic>>>? hanjaList;
  
  InfoState._({
    this.hanjaList,
    this.hanja,
    this.date, 
    this.time,
    this.name,
    this.error,
    this.menu = InfoMenu.name
  });

  InfoState.initialize() : this._();

  InfoState asSetName(String name, List<List<Map<String, dynamic>>> hanjaList){
    return copyWith(
      hanjaList: hanjaList,
      name: name,
      menu: InfoMenu.hanja
    );
  }

  InfoState asSetHanja(String hanja){
    return copyWith(
      hanja: hanja,
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
    List<List<Map<String, dynamic>>>? hanjaList,
    String? name,
    String? hanja,
    String? date,
    String? time,
    Exception? error,
    InfoMenu? menu
  }){
    return InfoState._(
      hanjaList: hanjaList ?? this.hanjaList,
      hanja: hanja ?? this.hanja,
      date: date ?? this.date,
      time: time ?? this.time,
      name: name ?? this.name,
      error: error ?? this.error,
      menu: menu ?? this.menu
    );
  }
}