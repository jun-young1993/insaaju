

import 'package:flutter/material.dart';
import 'package:insaaju/domain/entities/chat_complation.dart';
import 'package:insaaju/domain/entities/four_pillars_of_destiny.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/exceptions/unknown_exception.dart';

enum FourPillarsOfDestinyType {
  fourPillarsOfDestiny,
  daewoon, //  대운(大運)
  yongsin,
  gishin,
  // yongsinAndGisin, // 용신(用神)과 기신(忌神)
  sipsinAnalysis,  // 십신(十神) 분석
  // marriageFortune, // 결혼운
  // wealthFortune,   // 재물운
  // careerFortune,   // 직업운
  // healthFortune,   // 건강운
}

extension FourPillarsOfDestinyTypeExtension on FourPillarsOfDestinyType {
  String getValue() {
    return this.toString().split('.').last;
  }

  bool isBase(){
    if(this == FourPillarsOfDestinyType.fourPillarsOfDestiny){
      return true;
    }
    return false;
  }

  IconData getIcon(){
    switch(this){
      case FourPillarsOfDestinyType.fourPillarsOfDestiny:
        return Icons.dashboard;
      case FourPillarsOfDestinyType.yongsin:
        return Icons.start;
      case FourPillarsOfDestinyType.gishin:
        return Icons.warning;
      case FourPillarsOfDestinyType.sipsinAnalysis:
        return Icons.insights;
      case FourPillarsOfDestinyType.daewoon:
        return Icons.timeline;
      default:
        throw UnknownException<FourPillarsOfDestinyType>(this);
    }
  }

  String getTitle(){
    switch(this){
      case FourPillarsOfDestinyType.fourPillarsOfDestiny:
        return '기본 구성';
      // case FourPillarsOfDestinyType.yongsinAndGisin:
      //   return '용신(用神)과 기신(忌神)';
      case FourPillarsOfDestinyType.yongsin:
        return '용신(用神) 분석';
      case FourPillarsOfDestinyType.gishin:
        return '기신(忌神) 분석';
      case FourPillarsOfDestinyType.sipsinAnalysis:
        return '십신(十神) 분석';
      case FourPillarsOfDestinyType.daewoon:
        return '대운(大運) 분석';
    // case FourPillarsOfDestinyType.marriageFortune:
    //   return '결혼운';
    // case FourPillarsOfDestinyType.wealthFortune:
    //   return '재물운';
    // case FourPillarsOfDestinyType.careerFortune:
    //   return '직업운';
    // case FourPillarsOfDestinyType.healthFortune:
    //   return '건강운';
      default:
        throw UnknownException<FourPillarsOfDestinyType>(this);
    }
  }

  bool hasSameValue(String value){
    return this.getValue() == value;
  }
  
    // 문자열을 기반으로 enum 값 찾기
  static FourPillarsOfDestinyType? fromValue(String value) {
    for (var type in FourPillarsOfDestinyType.values) {
      if (type.getValue() == value) {
        return type;
      }
    }
    return null; // 일치하는 값이 없을 경우 null 반환
  }
}

enum FourPillarsOfDestinyCompatibilityType {
  personalityCompatibility,     // 성격 궁합
  destinyCompatibility,         // 운명 궁합
  marriageCompatibility,        // 결혼 생활 궁합
  // wealthCompatibility,          // 재물 궁합
  childrenCompatibility,        // 자녀 궁합
  // healthCompatibility,          // 건강 궁합
  // socialStatusCompatibility,    // 사회적 지위와 명예 궁합
  sexualCompatibility,          // 성적 궁합
  // psychologicalCompatibility,   // 심리적 궁합
  // luckFlowCompatibility,        // 대운 흐름 궁합
  // unionCompatibility,           // 합(合)의 궁합
  // conflictCompatibility,        // 충(沖), 형(刑), 파(破), 해(害)의 궁합
  // spousePalaceCompatibility,    // 배우자궁(일지) 궁합
}

extension FourPillarsOfDestinyCompatibilityTypeExtension on FourPillarsOfDestinyCompatibilityType {
  String getValue() {
    return this
        .toString()
        .split('.')
        .last;
  }

  String getTitle(){
    switch(this){
      case FourPillarsOfDestinyCompatibilityType.personalityCompatibility:
        return '성격 궁합';
      case FourPillarsOfDestinyCompatibilityType.destinyCompatibility:
        return '운명 궁합';
      case FourPillarsOfDestinyCompatibilityType.marriageCompatibility:
        return '경혼 생활 궁합';
      case FourPillarsOfDestinyCompatibilityType.childrenCompatibility:
        return '자녀 궁합';
      case FourPillarsOfDestinyCompatibilityType.sexualCompatibility:
        return '성적 궁합';
      default:
        throw UnknownException<FourPillarsOfDestinyCompatibilityType>(this);
    }

  }
}



class FourPillarsOfDestinyState {
  final Info? info;
  final Exception? error;
  final FourPillarsOfDestinyType? type;
  final Map<FourPillarsOfDestinyType,ChatCompletion?>? fourPillarsOfDestinyData;
  final FourPillarsOfDestiny? fourPillarsOfDestinyStructure;
  final bool loading;

  FourPillarsOfDestinyState._({
    this.info,
    this.error,
    this.type,
    this.fourPillarsOfDestinyStructure,
    this.fourPillarsOfDestinyData,
    this.loading = false
  });

  FourPillarsOfDestinyState.initialize() : this._();

  FourPillarsOfDestinyState asSetInfo(Info info){
    return copyWith(info: info);
  }

  FourPillarsOfDestinyState asFailer(Exception error){
    return copyWith(error: error, loading: false);
  }

  FourPillarsOfDestinyState asInitialize(){
    return FourPillarsOfDestinyState._();
  }

  FourPillarsOfDestinyState asLoading(bool isLoading){
    return copyWith(loading: isLoading);
  }

  FourPillarsOfDestinyState asFourPillarsOfDestinyStrcture(FourPillarsOfDestiny fourPillarsOfDestinyStructure){
    return copyWith(fourPillarsOfDestinyStructure: fourPillarsOfDestinyStructure);
  }

  FourPillarsOfDestinyState copyWith({
    Info? info,
    Exception? error,
    FourPillarsOfDestinyType? type,
    FourPillarsOfDestiny? fourPillarsOfDestinyStructure,
    Map<FourPillarsOfDestinyType,ChatCompletion?>? fourPillarsOfDestinyData,
    bool? loading
  }){
    return FourPillarsOfDestinyState._(
        fourPillarsOfDestinyStructure: fourPillarsOfDestinyStructure ?? this.fourPillarsOfDestinyStructure,
        info: info ?? this.info,
        error: error ?? this.error,
        type: type ?? this.type,
        fourPillarsOfDestinyData: fourPillarsOfDestinyData ?? this.fourPillarsOfDestinyData,
        loading: loading ?? this.loading
    );
  }
}