import 'dart:io';

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
    static String? get rewardAdUnitId {
      if(Platform.isAndroid){
        return 'ca-app-pub-3940256099942544/5224354917';
      }else if(Platform.isIOS){
        return 'ca-app-pub-3940256099942544/1712485313';
      }
      return null;
    }

    static String? get bannerAdUnitId {
      if(Platform.isAndroid){
        return 'ca-app-pub-3940256099942544/6300978111';
      }else if(Platform.isIOS){
        return 'ca-app-pub-3940256099942544/2934735716';
      }
      return null;
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