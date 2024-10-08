import 'package:flutter/material.dart';
import 'package:insaaju/domain/entities/info.dart';

class InfoProfile extends StatelessWidget {
  final double? size;
  final Info? info;

  const InfoProfile({
    super.key,
    this.size = 30,
    this.info
  });

  String? profileImagePath(){
    try{
      print('check');
      print(info?.getZodiac());
      // final imagePath = info == null ? null : info?.getZodiac()[5];
      // return imagePath;
      if(info != null){
        if(info?.getZodiac() != null){
          return info?.getZodiac()[5];
        }
      }
    return null;
    }catch(error){
      return null;
    }
    
  }

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
        child: info != null && profileImagePath() != null
        ? Image.asset(
          profileImagePath()!,
          // fit: BoxFit.contain,  // 이미지가 컨테이너 안에 맞도록 설정
          // width: double.infinity,  // 원하는 크기로 설정
          // height: double.infinity,  // 원하는 크기로 설정
          )
        : Icon(
          Icons.person,  // 사람 아이콘
          size: size,  // 아이콘 크기
          color: Colors.white,  // 아이콘 색상
        ),
      ),
    );
  }
  
}