import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// #  Android
// # 앱 오프닝 광고	ca-app-pub-3940256099942544/9257395921
// # 적응형 배너	ca-app-pub-3940256099942544/9214589741
// # 고정 크기 배너	ca-app-pub-3940256099942544/6300978111
// # 전면 광고	ca-app-pub-3940256099942544/1033173712
// # 보상형 광고	ca-app-pub-3940256099942544/5224354917
// # 보상형 전면 광고	ca-app-pub-3940256099942544/5354046379
// # 네이티브	ca-app-pub-3940256099942544/2247696110
// # 네이티브 동영상	ca-app-pub-3940256099942544/1044960115

// IOS
// 배너 광고	ca-app-pub-3940256099942544/2934735716
// 전면 광고	ca-app-pub-3940256099942544/4411468910
// 보상형 동영상 광고	ca-app-pub-3940256099942544/1712485313
// 네이티브 광고 고급형	ca-app-pub-3940256099942544/3986624511
/**
 * link - https://zzingonglog.tistory.com/43
 */
class AdMobConstant {
  // 보상형 광고 ID 분기
  static String? get rewardAdUnitId {
    if (Platform.isAndroid) {
      return kReleaseMode
          ? 'ca-app-pub-4656262305566191/2401968566' // 실제 광고 ID
          : 'ca-app-pub-3940256099942544/5224354917'; // 테스트 광고 ID
    } else if (Platform.isIOS) {
      return kReleaseMode
          ? 'ca-app-pub-4656262305566191/6832868863' // 실제 광고 ID
          : 'ca-app-pub-3940256099942544/1712485313'; // 테스트 광고 ID
    } 
    throw UnsupportedError('Unsupported platform');
  }

  // 배너 광고 ID 분기
  static String? get bannerAdUnitId {
    if (Platform.isAndroid) {
      return kReleaseMode
          ? 'ca-app-pub-4656262305566191/6413365760' // 실제 광고 ID
          : 'ca-app-pub-3940256099942544/6300978111'; // 테스트 광고 ID
    } else if (Platform.isIOS) {
      return kReleaseMode
          ? 'ca-app-pub-4656262305566191/7726447433' // 실제 광고 ID
          : 'ca-app-pub-3940256099942544/2934735716'; // 테스트 광고 ID
    }
    throw UnsupportedError('Unsupported platform');
  }

    static final BannerAdListener bannerAdListener = BannerAdListener(
      onAdLoaded: (ad) => debugPrint('Ad loaded'),
      onAdFailedToLoad: (ad, error) {
        ad.dispose();
        debugPrint('Ad fail to load: $error');
      },
      onAdOpened: (ad) => debugPrint('Ad opened'),
      onAdClosed: (ad) => debugPrint('Ad closed'),
    );
}