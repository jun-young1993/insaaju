enum Gender { male, female }

extension GenderExtension on Gender {
  String getValue(){
    return this.toString().split('.').last;
  }

  static Gender fromValue(String value){
    for(var type in Gender.values){
      if(type.getValue() == value){
        return type;
      }
    }
    throw Exception('has gender');
  }
}