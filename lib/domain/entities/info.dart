import 'package:flutter/material.dart';
import 'package:insaaju/domain/types/gender.dart';
import 'package:insaaju/domain/types/solar_and_lunar.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_state.dart';
import 'package:insaaju/states/info/info_state.dart';
import 'package:insaaju/utills/zodiac.dart';

class Info {
  final String name;
  final DateTime date;
  final TimeOfDay time;
  final SolarAndLunarType solarAndLunar;
  final Gender gender;
  late  String sessionId;
  Info( {
      required this.name,
      required this.date,
      required this.time,
      required this.solarAndLunar,
      required this.gender,
      required this.sessionId
  });
  
  String getTypeKey(FourPillarsOfDestinyType type){
    return toString()+type.getValue();
  }

  List<dynamic> getZodiac(){
    final int year = int.parse(date.toString().split('-').first.split(' ').last);

    return getZodiacWithDescription(year);
  }

  @override
  String toString(){
    return '$name ${toStringDateTime()}';
  }

  @override
  String toStringDateTime(){
    return '${date.year}-${date.month}-${date.day} ${time.hour.toString().padLeft(2,'0')}:${time.minute.toString().padLeft(2,'0')}';
  }

  bool compare(Info info){
    return name == info.name
        && date == info.date
        && time == info.time
        && gender == info.gender
    ;
  }

  // toJson 메서드
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date.toString(),
      'time': {
        'hour': time.hour,
        'minute': time.minute
      },
      'solarAndLunar': solarAndLunar.getValue(),
      'sessionId': sessionId,
      'gender': gender.getValue()
    };
  }

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
        name: json['name'],
        date: DateTime.parse(json['date']),
        time: TimeOfDay(hour: json['time']['hour'], minute: json['time']['minute']),
        sessionId: json['sessionId'],
        gender: GenderExtension.fromValue(json['gender']),
        solarAndLunar: SolarAndLunarTypeExtension.fromValue(json['solarAndLunar'])
    );
  }

  static Info fromState(InfoState state){
    if(!state.hasMissingFields()){
      return Info(
        name: state.name!,
        date: state.date!,
        time: state.time!,
        solarAndLunar: state.solarAndLunar!,
        sessionId: state.sessionId!,
        gender: state.gender!
      );
    }

    throw Exception('InfoState is missing required fields: name, date, or time');
  }

  factory Info.toEmpty(String? name){
    return Info(
      name: name ?? '',
      date: DateTime.now(),
      time: TimeOfDay.now(),
      sessionId: '',
      gender: Gender.male,
      solarAndLunar: SolarAndLunarType.solar
    );
  }

}

class EmptyInfo extends Info {

  EmptyInfo({String? name}) : super(
    name: "탭 해서 프로필 생성하기",
    date: DateTime.now(),
    time: TimeOfDay.now(),
    sessionId: '',
    solarAndLunar: SolarAndLunarType.solar,
    gender: Gender.male
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