import 'package:insaaju/exceptions/unknown_exception.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_state.dart';

class Info {
  final String name;
  final String hanja;
  final String date;
  final String time;
  const Info(this.name, this.hanja, this.date, this.time);

  @override
  String toString(){
    return '$name.$date.$time';
  }

  String toMessage(FourPillarsOfDestinyType type){
    switch(type){
      case FourPillarsOfDestinyType.fourPillarsOfDestiny:
        return '''
          Please analyze the Four Pillars (Saju).
          The person's birth date is $date $time.
          Based on this birth information, please calculate the Four Pillars:
          - Year Pillar
          - Month Pillar
          - Day Pillar
          - Hour Pillar
        
          After calculating the Four Pillars, please identify and explain the Yongshin (용신) and Gishin (기신).
          - Yongshin (용신) is the most essential element in the Saju, playing a crucial role in balancing the Four Pillars.
          - Gishin (기신) refers to the excessive elements that may have a negative impact on the person's fortune.
          
          By analyzing the Yongshin and Gishin in this person's Saju, please provide insights into how these elements influence their destiny and how they can be used to adjust and balance their life.
        
          Respond in Korean.
          ''';
      case FourPillarsOfDestinyType.yongsinAndGisin:
        return  '''
          Please analyze the Four Pillars (Saju) for $name .
          The person's birth date is $date $time.
          Based on this birth information, please calculate the Four Pillars:
        
          Once you have calculated the Four Pillars, please identify and explain the Yongshin (용신), which is the most important element that balances the person's Four Pillars. Focus on determining the most beneficial element (Five Elements) and how it affects the person's overall fortune and life.
        
          Respond in Korean.
          ''';
      case FourPillarsOfDestinyType.daewoon:
        return  '''
          Please analyze the Four Pillars (Saju).
          The person's birth date is $date $time.
          Based on this birth information, please calculate the Four Pillars:
        
          After calculating the Four Pillars, please analyze the Daewun (대운), which refers to the 10-year cycle that influences the person’s fortune. Daewun analysis helps understand when the person's luck is rising or when caution is needed. Please provide insights on which periods are favorable for major decisions such as marriage, starting a business, or changing jobs, as well as periods that require more attention or care.
        
          Respond in Korean.
          ''';
      case FourPillarsOfDestinyType.sipsinAnalysis:
        return '''
          Please analyze the Four Pillars (Saju).
          The person's birth date is $date $time.
          Based on this birth information, please calculate the Four Pillars:
        
          After calculating the Four Pillars, please analyze the Sipshin (십신).
          - The Sipshin (십신) represents different people or situations in each pillar, such as Jeongjae (정재), Pyeonjae (편재), Siksin (식신), and Sangkwan (상관).
          
          By analyzing the Sipshin, provide insights into the person's family relationships, financial luck, and social connections. Please explain how these elements manifest in the person's life and their influence on their overall fortune.
        
          Respond in Korean.
          ''';
      default:
        throw UnknownException(FourPillarsOfDestinyType);
    }

  }

  // toJson 메서드
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'hanja': hanja,
      'date': date,
      'time': time,
    };
  }

}