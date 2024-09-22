import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:insaaju/configs/four_pillars_of_destiny_constants.dart';
import 'package:insaaju/domain/entities/chat_complation.dart';
import 'package:insaaju/domain/entities/chat_room_message.dart';
import 'package:insaaju/domain/entities/chat_session.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/exceptions/common_exception.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_state.dart';
import 'package:insaaju/utills/aes_crypto.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../exceptions/duplicate_exception.dart';

abstract class OpenaiRepository {
  Future<ChatCompletion> sendMessage(String templateCode, String modelCode, String message);
  Future<ChatSession> createSession();
  Future<List<ChatRoomMessage>> findChatCompletion(String sessionId);
}

class OpenaiDefaultRepository extends OpenaiRepository {
  final String baseUrl = dotenv.env['API_BASE_URL']!;
  
  OpenaiDefaultRepository();

  @override
  Future<ChatSession> createSession() async {
    final url = Uri.parse('$baseUrl/openai/session');
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

    final response = await http.post(
        url,
        headers: headers,
    );
    if (response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      return ChatSession.fromJson(data);
    } else {
      throw CommonException.fromResponse(response);
    }

  }

  @override
  Future<List<ChatRoomMessage>> findChatCompletion(String sessionId) async {
    print('$baseUrl/openai/chat-completion/session/$sessionId');
    final url = Uri.parse('$baseUrl/openai/chat-completion/session/$sessionId');
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
      
      final ChatCompletion chatCompletion = ChatCompletion.fromJson(data['completions']);
      final List<ChatRoomMessage> messages = chatCompletion.choices.map((choice) {
        return ChatRoomMessage(
          role: ChatRoomRoleExtension.fromString(choice.message.role),
          content: choice.message.content
        );
      }).toList();
       
      return messages;
    } else {
      throw CommonException.fromResponse(response);
    }

  }
  
  @override
  Future<ChatCompletion> sendMessage(String templateCode, String modelCode, String message) async {
    
    final url = Uri.parse('$baseUrl/openai/send-message/$templateCode/$modelCode');
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
      return ChatCompletion.fromJson(data);
    } else {
      throw CommonException.fromResponse(response);
    }

  }

  Future<bool> compatibilityCheck(
      FourPillarsOfDestinyCompatibilityType type,
      List<Info> info
  ) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedInfoKeyList = prefs.getStringList(type.toString()) ?? [];

    bool isDuplicate = savedInfoKeyList.any((saveKey) => info[0].toString()+info[1].toString() == saveKey);
    if (isDuplicate) {
      throw DuplicateException<String>(info[0].toString()+info[1].toString());
    }
    return isDuplicate;
  }

  Future<bool> saveCompatibility(
      FourPillarsOfDestinyCompatibilityType type,
      List<Info> info,
      ChatCompletion chatComplation
  ) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedInfoKeyList = prefs.getStringList(type.toString()) ?? [];
    compatibilityCheck(
      type,
      info
    );

    savedInfoKeyList.add(info[0].toString()+info[1].toString());
    await prefs.setStringList(type.toString(), savedInfoKeyList);
    final bool result = await prefs.setString(info[0].toString()+info[1].toString(), chatComplation.toString());
    return result;
  }


}

