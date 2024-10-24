class HeavenlyAndEarthly {
  final String ko;
  final String hanja;
  const HeavenlyAndEarthly({
    required this.ko,
    required this.hanja
  });

  factory HeavenlyAndEarthly.fromJson(Map<String, dynamic> json){
    return HeavenlyAndEarthly(
      ko: json['ko'],
      hanja: json['hanjs']
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