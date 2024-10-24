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