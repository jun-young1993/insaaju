import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:insaaju/exceptions/common_exception.dart';
import 'package:insaaju/states/four_pillars_of_destiny/four_pillars_of_destiny_state.dart';
import 'package:insaaju/utills/aes_crypto.dart';
import 'package:http/http.dart' as http;

abstract class OpenaiRepository {
  
  Future<dynamic> sendMessage(String templateCode, String message);
}

class OpenaiDefaultRepository extends OpenaiRepository {
  final String baseUrl = dotenv.env['API_BASE_URL']!;
  
  OpenaiDefaultRepository();

  
  
  @override
  Future<Response> sendMessage(String templateCode, String message) async {
    
    final url = Uri.parse('$baseUrl/openai/send-message/$templateCode');
    final String secretKey = dotenv.env['SECRET_KEY']!;
    final tokenGenerator = AESCrypto(
      secretKey
    );
      // 현재 시간을 가져오기
    final currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    final xAccessToken = tokenGenerator.encrypt('$secretKey-$currentTime');
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
      return response;
    } else {
      throw CommonException.fromResponse(response);
    }

  }

}