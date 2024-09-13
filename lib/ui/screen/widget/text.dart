import 'package:flutter/material.dart';

// 공통 부모 클래스
abstract class BaseText extends StatelessWidget {
  final String text;

  const BaseText({super.key, required this.text});

  // 자식 클래스에서 스타일을 구현하게 할 메서드
  TextStyle getTextStyle();

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextStyle(), // 스타일은 자식 클래스에서 정의
    );
  }
}

// TitleText 클래스
class TitleText extends BaseText {
  const TitleText({super.key, required String text}) : super(text: text);

  @override
  TextStyle getTextStyle() {
    return const TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );
  }
}

// CaptionText 클래스
class CaptionText extends BaseText {
  const CaptionText({super.key, required String text}) : super(text: text);

  @override
  TextStyle getTextStyle() {
    return const TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: Colors.grey,
    );
  }
}

class ErrorText extends BaseText {
  const ErrorText({super.key, String? text}) : super(text: text ?? 'unkwon');

  @override
  TextStyle getTextStyle() {
    return const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      color: Colors.red, // 에러 텍스트는 빨간색으로 설정
    );
  }
}