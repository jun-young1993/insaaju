// Repository 인터페이스 정의
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:insaaju/domain/entities/code_item.dart';
import 'package:insaaju/exceptions/common_exception.dart';

abstract class CodeItemRepository {
  Future<CodeItem> fetchCodeItem(String code, String key);
}

// Default Repository 구현체
class CodeItemDefaultRepository implements CodeItemRepository {
  final String baseUrl = dotenv.env['API_BASE_URL']!;

  @override
  Future<CodeItem> fetchCodeItem(String code, String key) async {
    final String url = '$baseUrl/code-item/$code/$key';
    final http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return CodeItem.fromJson(data);
    } else {
      throw CommonException.fromResponse(response);
    }
  }
}