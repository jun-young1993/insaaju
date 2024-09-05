import 'package:http/http.dart' as http;
import 'dart:convert';

class CommonException implements Exception {
  final int statusCode;
  final String error;
  final String message;

  CommonException({
    required this.statusCode,
    required this.error,
    required this.message,
  });

  // 에러 메시지 형식 정의
  @override
  String toString() {
    return '$statusCode: [$error] $message';
  }

  // Response를 받아서 CommonException을 만드는 팩토리 메소드
  factory CommonException.fromResponse(http.Response response) {
    final errorBody = jsonDecode(response.body);

    if (errorBody is Map<String, dynamic>) {
      final error = errorBody['error'] ?? 'Unknown error';
      final message = errorBody['message'] ?? 'No message provided';

      return CommonException(
        statusCode: response.statusCode,
        error: error,
        message: message,
      );
    } else {
      // 만약 JSON 파싱이 실패하면 기본 에러 메시지
      return CommonException(
        statusCode: response.statusCode,
        error: 'Invalid Response',
        message: 'Failed to parse error body',
      );
    }
  }
}
