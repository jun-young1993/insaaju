import 'dart:convert';
import 'package:insaaju/domain/entities/chat_complation.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FourPillarsOfDestinyRepository {
  Future<Map<FourPillarsOfDestinyType,ChatComplation?>> getFourPillarsOfDestinyList(Info info);
  Future<bool> saveFourPillarsOfDestiny(FourPillarsOfDestinyType type, ChatComplation chatComplation, Info info);
}

class FourPillarsOfDestinyDefaultRepository extends FourPillarsOfDestinyRepository {
  FourPillarsOfDestinyDefaultRepository();

  @override
  Future<Map<FourPillarsOfDestinyType,ChatComplation?>> getFourPillarsOfDestinyList(Info info) async {
    final prefs = await SharedPreferences.getInstance();
    final Map<FourPillarsOfDestinyType,ChatComplation?> results = {};

    for(var type in FourPillarsOfDestinyType.values){

      final chatCompilationJsonOrNull = prefs.getString(info.getTypeKey(type));

      if(chatCompilationJsonOrNull == null){
        results[type] = null;
      }else{
        results[type] = ChatComplation.fromJson(jsonDecode(chatCompilationJsonOrNull));
      }
    }

    return results;
  }

  @override
  Future<bool> saveFourPillarsOfDestiny(FourPillarsOfDestinyType type, ChatComplation chatCompilation, Info info) async {
    final prefs = await SharedPreferences.getInstance();


    final bool result = await prefs.setString(info.toString()+type.getValue(), chatCompilation.toString());

    return result;
  }
}