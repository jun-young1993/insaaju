import 'package:flutter/material.dart';
import 'package:insaaju/exceptions/unknown_exception.dart';

enum InfoMenu {
  name,
  hanja,
  birthDate,
  birthDateAndTime,
  check
}
enum InfoStatus {
  queue,
  saving,
  saved
}
enum SolarAndLunarType {
  solar,
  lunar
}
extension SolarAndLunarTypeExtension on SolarAndLunarType {
  bool isLunar(){
    return this == SolarAndLunarType.lunar;
  }

  String getValue(){
    return this.toString().split('.').last;
  }

  bool hasSameValue(String value){
    return this.getValue() == value;
  }

  static SolarAndLunarType fromValue(String value){
    for(var type in SolarAndLunarType.values){
      if(type.getValue() == value){
        return type;
      }
    }
    throw Exception('has solar and lunar');
  }
}
extension InfoStatusExtension on InfoStatus {
  String getTitle(){
    switch(this){
      case InfoStatus.queue:
        return '대기';
      case InfoStatus.saving:
        return '저장중입니다...';
      case InfoStatus.saved:
        return '저장되었습니다.';
      default:
        throw UnknownException<InfoStatus>(this);
    }
  }
}

enum InfoRemoveStatus {
  queue,
  processing,
  complete
}
class InfoState {
  final String? name;
  final Exception? error;
  final InfoMenu menu;
  final DateTime? date;
  final TimeOfDay? time;
  final String? sessionId;
  final SolarAndLunarType? solarAndLunar;
  final InfoStatus status;
  final InfoRemoveStatus removeStatus;
  
  InfoState._({
    this.date, 
    this.time,
    this.name,
    this.error,
    this.solarAndLunar,
    this.sessionId,
    this.status = InfoStatus.queue,
    this.menu = InfoMenu.name,
    this.removeStatus = InfoRemoveStatus.queue
  });

  InfoState.initialize() : this._();

  bool hasMissingFields(){
    return (date == null) || (time == null) || (name == null) || (solarAndLunar == null) || (sessionId == null);
  }

  InfoState asSetName(String name){

    return copyWith(
      name: name,
      menu: InfoMenu.birthDate
    );
  }

  InfoState asSetSessionId(String sessionId){

    return copyWith(
      sessionId: sessionId,
    );
  }

  InfoState asInitialize(){
    return InfoState._();
  }

  InfoState asSetSolarAndLunar(SolarAndLunarType solarAndLunar){
    return copyWith(
      solarAndLunar: solarAndLunar
    );
  }

  InfoState asSetMenu(InfoMenu menu){
    return copyWith(
      menu: menu
    );
  }
  
  InfoState asSetDate(DateTime date){
    return copyWith(
      date: date,
      menu: InfoMenu.birthDateAndTime
    );
  }

  InfoState asSetTime(TimeOfDay time){
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
    String? name,
    DateTime? date,
    TimeOfDay? time,
    String? sessionId,
    Exception? error,
    SolarAndLunarType? solarAndLunar,
    InfoMenu? menu,
    InfoStatus? status,
    InfoRemoveStatus? removeStatus
  }){
    return InfoState._(
      solarAndLunar: solarAndLunar ?? this.solarAndLunar,
      sessionId: sessionId ?? this.sessionId,
      status: status ?? this.status,
      date: date ?? this.date,
      time: time ?? this.time,
      name: name ?? this.name,
      error: error ?? this.error,
      menu: menu ?? this.menu,
      removeStatus: removeStatus ?? this.removeStatus
    );
  }
}