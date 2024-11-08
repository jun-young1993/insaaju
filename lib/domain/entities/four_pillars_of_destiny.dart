
import 'dart:ui';

import 'package:insaaju/domain/types/yin_yang.dart';

class HeavenlyAndEarthlyNames {
  final String ko;
  final String hanja;
  const HeavenlyAndEarthlyNames({
    required this.ko,
    required this.hanja
  });

  factory HeavenlyAndEarthlyNames.fromJson(Map<String, dynamic> json){
    
    return HeavenlyAndEarthlyNames(
      ko: json['ko'],
      hanja: json['hanja']
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'ko': ko,
      'hanja': hanja,
    };
  }
}

class HeavenlyAndEarthlyBase extends HeavenlyAndEarthlyNames{
  final String element;
  final YinYang yinyang;
  final Color color;
  final HeavenlyAndEarthlyNames ten;
  const HeavenlyAndEarthlyBase({
    required String ko,
    required String hanja,
    required this.element,
    required this.yinyang,
    required this.color,
    required this.ten
  }): super(
    ko: ko,
    hanja: hanja
  );
  factory HeavenlyAndEarthlyBase.fromJson(Map<String, dynamic> json, Map<String, dynamic> tenJson) {
    return HeavenlyAndEarthlyBase(
      ko: json['ko'],
      hanja: json['hanja'],
      element: json['element'],
      yinyang: json['yinyang'] == 'yin' ? YinYang.yin : YinYang.yang,
      color: Color(int.parse(json['color'].replaceFirst('#', '0xFF'))),
      ten: HeavenlyAndEarthlyNames.fromJson(tenJson)
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'element': element,
      'yinyang': yinyang == YinYang.yin ? 'yin' : 'yang',
      'color': '#${color.value.toRadixString(16).substring(2).toUpperCase()}',
      'ten': ten
    };
  }
}
class HeavenlyAndEarthly {
  final HeavenlyAndEarthlyBase heavenly;
  final HeavenlyAndEarthlyBase earthly;
  const HeavenlyAndEarthly({
    required this.heavenly,
    required this.earthly
  });

  factory HeavenlyAndEarthly.fromJson(Map<String, dynamic> json){
    return HeavenlyAndEarthly(
      heavenly: HeavenlyAndEarthlyBase.fromJson(json['heavenly'], json['ten']['heavenly']),
      earthly: HeavenlyAndEarthlyBase.fromJson(json['earthly'], json['ten']['earthly'])
    );
  }
}

class FourPillarsOfDestinyInfoDate {
  final String lunar;
  final String solar;
  const FourPillarsOfDestinyInfoDate({
    required this.lunar,
    required this.solar
  });
  factory FourPillarsOfDestinyInfoDate.fromJson(Map<String, dynamic> json){
    return FourPillarsOfDestinyInfoDate(
      lunar: json['lunar'],
      solar: json['solar'],
    );
  }
}
class FourPillarsOfDestinyInfo {
  final FourPillarsOfDestinyInfoDate date;
  final String animal;
  final FourPillarsOfDestinyWuXing wuxing;
  const FourPillarsOfDestinyInfo({
    required this.date,
    required this.animal,
    required this.wuxing
  });
  factory FourPillarsOfDestinyInfo.fromJson(Map<String, dynamic> json){

    return FourPillarsOfDestinyInfo(
      date: FourPillarsOfDestinyInfoDate.fromJson(json['date']),
      animal: json['animal'],
      wuxing:FourPillarsOfDestinyWuXing.fromJson(json['wuxing'])
    );
  }
}

class WuXingCount {
  final int wood;
  final int fire;
  final int earth;
  final int metal;
  final int water;
  const WuXingCount({
    required this.wood,
    required this.fire,
    required this.earth,
    required this.metal,
    required this.water
  });
}

class WuXingColor {
  final String wood;
  final String fire;
  final String earth;
  final String metal;
  final String water;
  const WuXingColor({
    required this.wood,
    required this.fire,
    required this.earth,
    required this.metal,
    required this.water
  });
}



class FourPillarsOfDestinyWuXing {
  final WuXingCount count;
  final WuXingColor colors;
  const FourPillarsOfDestinyWuXing({
    required this.count,
    required this.colors
  });

  factory FourPillarsOfDestinyWuXing.fromJson(Map<String, dynamic> json){

    return FourPillarsOfDestinyWuXing(
      count: WuXingCount(
          wood: json['count']['木'],
          fire: json['count']['火'],
          earth: json['count']['土'],
          metal: json['count']['金'],
          water: json['count']['水']
      ),
      colors: WuXingColor(
          wood: json['colors']['木'],
          fire: json['colors']['火'],
          earth: json['colors']['土'],
          metal: json['colors']['金'],
          water: json['colors']['水']
      )
    );
  }
}

class FourPillarsOfDestiny {
  final HeavenlyAndEarthly year;
  final HeavenlyAndEarthly month;
  final HeavenlyAndEarthly day;
  final HeavenlyAndEarthly time;
  final FourPillarsOfDestinyInfo info;

  const FourPillarsOfDestiny({
    required this.year,
    required this.month,
    required this.day,
    required this.time,
    required this.info,
  });

  factory FourPillarsOfDestiny.fromJson(Map<String, dynamic> json){

    return FourPillarsOfDestiny(
      year: HeavenlyAndEarthly.fromJson(json['year']),
      month: HeavenlyAndEarthly.fromJson(json['month']),
      day: HeavenlyAndEarthly.fromJson(json['day']),
      time: HeavenlyAndEarthly.fromJson(json['time']),
      info: FourPillarsOfDestinyInfo.fromJson(json['info']),
    );
  }
}