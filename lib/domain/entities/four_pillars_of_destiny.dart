
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
}
class HeavenlyAndEarthly {
  final HeavenlyAndEarthlyNames heavenly;
  final HeavenlyAndEarthlyNames earthly;
  const HeavenlyAndEarthly({
    required this.heavenly,
    required this.earthly
  });

  factory HeavenlyAndEarthly.fromJson(Map<String, dynamic> json){
    return HeavenlyAndEarthly(
      heavenly: HeavenlyAndEarthlyNames.fromJson(json['heavenly']),
      earthly: HeavenlyAndEarthlyNames.fromJson(json['earthly'])
    );
  }
}

class FourPillarsOfDestiny {
  final HeavenlyAndEarthly year;
  final HeavenlyAndEarthly month;
  final HeavenlyAndEarthly day;
  final HeavenlyAndEarthly time;

  const FourPillarsOfDestiny({
    required this.year,
    required this.month,
    required this.day,
    required this.time,
  });

  factory FourPillarsOfDestiny.fromJson(Map<String, dynamic> json){
    return FourPillarsOfDestiny(
      year: HeavenlyAndEarthly.fromJson(json['year']),
      month: HeavenlyAndEarthly.fromJson(json['month']),
      day: HeavenlyAndEarthly.fromJson(json['day']),
      time: HeavenlyAndEarthly.fromJson(json['time']),
    );
  }
}