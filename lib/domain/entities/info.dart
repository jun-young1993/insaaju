import 'package:insaaju/exceptions/unknown_exception.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_state.dart';

class Info {
  final String name;
  final String hanja;
  final String date;
  final String time;
  const Info(this.name, this.hanja, this.date, this.time);

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
    return name == info.name && hanja == info.hanja && date == info.date && time == info.time;
  }

  // toJson 메서드
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'hanja': hanja,
      'date': date,
      'time': time,
    };
  }

}