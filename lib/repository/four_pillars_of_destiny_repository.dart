import 'dart:convert';
import 'package:insaaju/domain/entities/chat_complation.dart';
import 'package:insaaju/domain/entities/four_pillars_of_destiny.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FourPillarsOfDestinyRepository {
  Future<Map<FourPillarsOfDestinyType,ChatCompletion?>> getFourPillarsOfDestinyList(Info info);
  Future<bool> saveFourPillarsOfDestiny(FourPillarsOfDestinyType type, ChatCompletion chatComplation, Info info);
  Future<FourPillarsOfDestiny> getFourPillarsOfDestiny();
}

class FourPillarsOfDestinyDefaultRepository extends FourPillarsOfDestinyRepository {
  FourPillarsOfDestinyDefaultRepository();

  @override
  Future<FourPillarsOfDestiny> getFourPillarsOfDestiny(){
    
  }

  @override
  Future<Map<FourPillarsOfDestinyType,ChatCompletion?>> getFourPillarsOfDestinyList(Info info) async {
    final prefs = await SharedPreferences.getInstance();
    final Map<FourPillarsOfDestinyType,ChatCompletion?> results = {};

    for(var type in FourPillarsOfDestinyType.values){

      final chatCompilationJsonOrNull = prefs.getString(info.getTypeKey(type));

      if(chatCompilationJsonOrNull == null){
        results[type] = null;
      }else{
        results[type] = ChatCompletion.fromJson(jsonDecode(chatCompilationJsonOrNull));
      }
    }

    return results;
  }

  @override
  Future<bool> saveFourPillarsOfDestiny(FourPillarsOfDestinyType type, ChatCompletion chatCompilation, Info info) async {
    final prefs = await SharedPreferences.getInstance();


    final bool result = await prefs.setString(info.toString()+type.getValue(), chatCompilation.toString());

    return result;
  }
}