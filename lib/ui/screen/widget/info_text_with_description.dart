import 'package:flutter/material.dart';

// 커스텀 설명 텍스트 위젯
class InfoTextWithDescription extends StatelessWidget {
  final String title;
  final String description;
  final double titleFontSize;
  final double descriptionFontSize;
  final Color? titleColor;
  final Color? descriptionColor;

  const InfoTextWithDescription({
    Key? key,
    required this.title,
    required this.description,
    this.titleFontSize = 28.0,
    this.descriptionFontSize = 20.0,
    this.titleColor = Colors.black,
    this.descriptionColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold, color: titleColor),
        ),
        SizedBox(height: 4), // 제목과 설명 간격
        Text(
          description,
          style: TextStyle(fontSize: descriptionFontSize, color: descriptionColor),
        ),
      ],
    );
  }
}
