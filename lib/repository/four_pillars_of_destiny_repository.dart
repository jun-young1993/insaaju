import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:insaaju/domain/entities/chat_complation.dart';
import 'package:insaaju/domain/entities/four_pillars_of_destiny.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/domain/types/solar_and_lunar.dart';
import 'package:insaaju/exceptions/common_exception.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_state.dart';
import 'package:insaaju/utills/aes_crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class FourPillarsOfDestinyRepository {
  Future<Map<FourPillarsOfDestinyType,ChatCompletion?>> getFourPillarsOfDestinyList(Info info);
  Future<bool> saveFourPillarsOfDestiny(FourPillarsOfDestinyType type, ChatCompletion chatComplation, Info info);
  Future<FourPillarsOfDestiny> getFourPillarsOfDestiny(Info info);
}

class FourPillarsOfDestinyDefaultRepository extends FourPillarsOfDestinyRepository {
  FourPillarsOfDestinyDefaultRepository();
  final String baseUrl = dotenv.env['API_BASE_URL']!;
  
  @override
  Future<FourPillarsOfDestiny> getFourPillarsOfDestiny(Info info) async {
    final year = info.date.year;
    final month = info.date.month;
    final day = info.date.day;
    final hour = info.time.hour;
    final minute = info.time.minute;
    final isLunar = info.solarAndLunar == SolarAndLunarType.lunar;
    final url = Uri.parse('$baseUrl/four-pillars?year=${year}&month=${month}&day=${day}&hour=${hour}&minute=${minute}&isLunar=${isLunar}');
    print(url);
    final String secretKey = dotenv.env['SECRET_KEY']!;

    // 현재 시간을 가져오기
    final currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    final xAccessToken =  encrypt(
        '$secretKey-$currentTime',
        secretKey
    );

    final headers = {
      'Content-Type': 'application/json',
      'x-access-token': xAccessToken
    };

    final response = await http.get(
        url,
        headers: headers,
    );
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print(data);
      return FourPillarsOfDestiny.fromJson(data);
    }else{
      throw CommonException.fromResponse(response);
    }

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