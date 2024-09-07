

import 'package:insaaju/domain/entities/chat_complation.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/exceptions/unknown_exception.dart';

enum FourPillarsOfDestinyType {
  fourPillarsOfDestiny,
  daewoon, //  대운(大運)
  yongsinAndGisin, // 용신(用神)과 기신(忌神)
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

  String getTitle(){
    switch(this){
      case FourPillarsOfDestinyType.fourPillarsOfDestiny:
        return '기본 구성';
      case FourPillarsOfDestinyType.yongsinAndGisin:
        return '용신(用神)과 기신(忌神)';
      case FourPillarsOfDestinyType.sipsinAnalysis:
        return '십신(十神) 분석';
      case FourPillarsOfDestinyType.daewoon:
        return '대운(大運)';
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
}

class FourPillarsOfDestinyState {
  final Info? info;
  final Exception? error;
  final FourPillarsOfDestinyType? type;
  final Map<FourPillarsOfDestinyType,ChatComplation?>? fourPillarsOfDestinyData;
  final bool loading;

  FourPillarsOfDestinyState._({
    this.info,
    this.error,
    this.type,
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

  FourPillarsOfDestinyState copyWith({
    Info? info,
    Exception? error,
    FourPillarsOfDestinyType? type,
    Map<FourPillarsOfDestinyType,ChatComplation?>? fourPillarsOfDestinyData,
    bool? loading
  }){
    return FourPillarsOfDestinyState._(
        info: info ?? this.info,
        error: error ?? this.error,
        type: type ?? this.type,
        fourPillarsOfDestinyData: fourPillarsOfDestinyData ?? this.fourPillarsOfDestinyData,
        loading: loading ?? this.loading
    );
  }
}