import 'package:flutter/material.dart';

class InfoProfile extends StatelessWidget {
  final double? size;

  const InfoProfile({
    super.key,
    this.size = 30
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: size! * 2 ,  // 원하는 너비
      height: size! * 2,  // 원하는 높이
      decoration: BoxDecoration(
        color: Colors.blue[200],  // 배경 색상
        borderRadius: BorderRadius.circular(16.0),  // 둥근 모서리
      ),
      child: Center(
        child: Icon(
          Icons.person,  // 사람 아이콘
          size: size,  // 아이콘 크기
          color: Colors.white,  // 아이콘 색상
        ),
      ),
    );
  }
  
}