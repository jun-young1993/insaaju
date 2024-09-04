

import 'package:insaaju/domain/entities/info.dart';

enum FourPillarsOfDestinyType {
  yongsinAndGisin, // 용신(用神)과 기신(忌神)
  sipsinAnalysis,  // 십신(十神) 분석
  marriageFortune, // 결혼운
  wealthFortune,   // 재물운
  careerFortune,   // 직업운
  healthFortune,   // 건강운
}

class FourPillarsOfDestinyState {
  final Info? info;
  final Exception? error;
  final FourPillarsOfDestinyType? type;

  FourPillarsOfDestinyState._( {
    this.info,
    this.error,
    this.type
  });

  FourPillarsOfDestinyState.initialize() : this._();

  FourPillarsOfDestinyState asSetInfo(Info info){
    return copyWith(info: info);
  }

  FourPillarsOfDestinyState asFailer(Exception error){
    return copyWith(error: error);
  }

  FourPillarsOfDestinyState copyWith({
    Info? info,
    Exception? error
  }){
    return FourPillarsOfDestinyState._(
      info: info ?? this.info,
      error: error ?? this.error
    );
  }
}