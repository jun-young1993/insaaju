import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:insaaju/configs/four_pillars_of_destiny_constants.dart';
import 'package:insaaju/domain/entities/chat_complation.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/exceptions/common_exception.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_state.dart';
import 'package:insaaju/utills/aes_crypto.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class OpenaiRepository {
  Future<ChatComplation> sendMessage(String templateCode, String modelCode, String message);
  Future<bool> save(FourPillarsOfDestinyType type, ChatComplation chatComplation, Info info);
  Future<Map<FourPillarsOfDestinyType,ChatComplation?>> getAll(Info info);
}

class OpenaiDefaultRepository extends OpenaiRepository {
  final String baseUrl = dotenv.env['API_BASE_URL']!;
  
  OpenaiDefaultRepository();

  
  
  @override
  Future<ChatComplation> sendMessage(String templateCode, String modelCode, String message) async {
    
    final url = Uri.parse('$baseUrl/openai/send-message/$templateCode/$modelCode');
    final String secretKey = dotenv.env['SECRET_KEY']!;

      // 현재 시간을 가져오기
    final currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    final xAccessToken =  encrypt(
      '$secretKey-$currentTime',
      secretKey
    );
    print(xAccessToken);
    final headers = {
          'Content-Type': 'application/json',
          'x-access-token': xAccessToken
    };
    final body = jsonEncode({
      'message': message,
    });

    final response = await http.post(
      url,
      headers: headers,
      body: body
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      return ChatComplation.fromJson(data);
    } else {
      throw CommonException.fromResponse(response);
    }

  }

  Future<bool> save(FourPillarsOfDestinyType type, ChatComplation chatComplation, Info info) async {
    final prefs = await SharedPreferences.getInstance();
    

    final bool result = await prefs.setString(info.toString()+type.getValue(), chatComplation.toString());
    
    return result;
  }

  Future<Map<FourPillarsOfDestinyType,ChatComplation?>> getAll(Info info) async {
    final prefs = await SharedPreferences.getInstance();
    final Map<FourPillarsOfDestinyType,ChatComplation?> results = {};
    for(var type in FourPillarsOfDestinyType.values){
      final chatComplationJsonOrNull = prefs.getString(info.toString()+type.getValue());
      if(chatComplationJsonOrNull == null){
        results[type] = null;
      }else{
        results[type] = ChatComplation.fromJson(jsonDecode(chatComplationJsonOrNull));
      }
    }
    return results;
    // List<String> savedChatComplationList = prefs.getStringList(InfoConstants.info) ?? [];
  }
}

