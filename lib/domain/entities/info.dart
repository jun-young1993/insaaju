import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_state.dart';
import 'package:insaaju/states/info/info_state.dart';

class Info {
  final String name;
  final String date;
  final String time;
  final String? mySessionId;
  const Info(
      this.name,
      this.date,
      this.time,
      {
        this.mySessionId
      }
  );

  String getTypeKey(FourPillarsOfDestinyType type){
    return toString()+type.getValue();
  }

  @override
  String toString(){
    return '$name.$date.$time';
  }

  @override
  String toStringDateTime(){
    return '$date $time';
  }

  bool compare(Info info){
    return name == info.name
        && date == info.date
        && time == info.time
    ;
  }

  // toJson 메서드
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date,
      'time': time,
      'mySessionId': mySessionId
    };
  }

  static Info fromState(InfoState state){
    if(
      state.name != null
      && state.date != null
      && state.time != null
    ){
      return Info(
        state.name!,
        state.date!,
        state.time!
      );
    }

    throw Exception('InfoState is missing required fields: name, date, or time');
  }

}