import 'package:insaaju/domain/entities/chat_session.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_state.dart';
import 'package:insaaju/states/info/info_state.dart';
import 'package:insaaju/utills/zodiac.dart';

class Info {
  final String name;
  final String date;
  final String time;
  final SolarAndLunarType solarAndLunar;
  late  String sessionId;
  Info( {
      required this.name,
      required this.date,
      required this.time,
      required this.solarAndLunar,
      required this.sessionId
  });
  
  void setMySession(ChatSession session){
    sessionId = session.id;
  }

  String getTypeKey(FourPillarsOfDestinyType type){
    return toString()+type.getValue();
  }



  List<dynamic> getZodiac(){
    final int year = int.parse(date.split('-').first.split(' ').last);

    return getZodiacWithDescription(year);
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
      'mySessionId': sessionId
    };
  }

  static Info fromState(InfoState state){
    if(!state.hasMissingFields()){
      return Info(
        name: state.name!,
        date: state.date!,
        time: state.time!,
        solarAndLunar: state.solarAndLunar!,
        sessionId: state.sessionId!
      );
    }

    throw Exception('InfoState is missing required fields: name, date, or time');
  }

  factory Info.toEmpty(){
    return Info(
      name: '',
      date: '',
      time: '',
      sessionId: '', 
      solarAndLunar: SolarAndLunarType.solar
    );
  }

}class ExtendedInfo extends Info {

  ExtendedInfo({String? name}) : super(
    name: "탭 해서 프로필 생성하기",
    date: '',
    time: '',
    sessionId: '',
    solarAndLunar: SolarAndLunarType.solar
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