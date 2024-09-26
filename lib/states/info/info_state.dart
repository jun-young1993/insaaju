enum InfoMenu {
  name,
  hanja,
  birthDate,
  birthDateAndTime,
  check
}
enum InfoStatus {
  inProgress,
  saving,
  saved
}

enum InfoRemoveStatus {
  queue,
  processing,
  complete
}
class InfoState {
  final String? name;
  final List<String>? hanja;
  final Exception? error;
  final InfoMenu menu;
  final String? date;
  final String? time;
  final InfoStatus status;
  final InfoRemoveStatus removeStatus;
  final List<List<Map<String, dynamic>>>? hanjaList;
  
  InfoState._({
    this.hanjaList,
    this.hanja,
    this.date, 
    this.time,
    this.name,
    this.error,
    this.status = InfoStatus.inProgress,
    this.menu = InfoMenu.name,
    this.removeStatus = InfoRemoveStatus.queue
  });

  InfoState.initialize() : this._();

  InfoState asSetName(String name){

    return copyWith(
      name: name,
      menu: InfoMenu.birthDate
    );
  }

  InfoState asInitialize(){
    return InfoState._();
  }

  InfoState asSetHanjaList(List<List<Map<String, dynamic>>> hanjaList){
    List<String> defaultHanjaArray = List.generate(name!.length, (index){
      return hanjaList[index].isNotEmpty ? hanjaList[index][0]['hanja'] as String : '';
    });
    return copyWith(
        hanjaList: hanjaList,
        hanja: defaultHanjaArray
    );
  }

  InfoState asSetHanja(List<String>? hanja){
    return copyWith(
      hanja: hanja,
      menu: InfoMenu.hanja
    );
  }

  InfoState asSetMenu(InfoMenu menu){
    return copyWith(
      menu: menu
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

  InfoState asChangeStatus(InfoStatus status){
    return copyWith(status: status);
  }

  InfoState asFailer(Exception error){
    return copyWith(error: error);
  }

  InfoState copyWith({
    List<List<Map<String, dynamic>>>? hanjaList,
    String? name,
    List<String>? hanja,
    String? date,
    String? time,
    Exception? error,
    InfoMenu? menu,
    InfoStatus? status,
    InfoRemoveStatus? removeStatus
  }){
    return InfoState._(
      hanjaList: hanjaList ?? this.hanjaList,
      status: status ?? this.status,
      hanja: hanja ?? this.hanja,
      date: date ?? this.date,
      time: time ?? this.time,
      name: name ?? this.name,
      error: error ?? this.error,
      menu: menu ?? this.menu,
      removeStatus: removeStatus ?? this.removeStatus
    );
  }
}