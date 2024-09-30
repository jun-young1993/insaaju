import 'package:insaaju/domain/entities/chat_session.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_state.dart';
import 'package:insaaju/states/info/info_state.dart';

class Info {
  final String name;
  final String date;
  final String time;
  late  String? mySessionId;
  Info(
      this.name,
      this.date,
      this.time,
      {
        this.mySessionId
      }
  );
  
  void setMySession(ChatSession session){
    mySessionId = session.id;
  }

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

  factory Info.toEmpty(){
    return Info(
      '',
      '',
      ''
    );
  }

}class ExtendedInfo extends Info {

  ExtendedInfo(
  {String? name}
  ) : super(
    name ?? '탭 해서 프로필 생성하기',
    '',
    '',
  );

  @override
  String toString() {
    return '프로필을 생성해주세요';
  }

  @override
  String toStringDateTime(){
    return '프로필을 생성해주세요';
  }
}