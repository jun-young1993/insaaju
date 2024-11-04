import 'package:flutter/material.dart';

enum WuXing { wood, fire, earth, metal, water }

extension WuXingExtension on WuXing {
  String getValue(){
    return this.toString().split('.').last;
  }

  static WuXing fromValue(String value){
    for(var type in WuXing.values){
      if(type.getValue() == value){
        return type;
      }
    }
    throw Exception('has WuXing');
  }

  String getTitle(){
    switch(this){
      case WuXing.wood:
        return '목';
      case WuXing.fire:
        return '화';
      case WuXing.earth:
        return '토';
      case WuXing.metal:
        return '금';
      case WuXing.water:
        return '수';
      default:
        throw Exception('unknown');
    }
  }

  Color getColor(){
    switch(this){
      case WuXing.wood:
        return const Color(0xFF228B22); // 초록색
      case WuXing.fire:
        return const Color(0xFFFF4500);// 빨간색
      case WuXing.earth:
        return const Color(0xFFD2691E); // 갈색
      case WuXing.metal:
        return const Color(0xFFC0C0C0); // 은색
      case WuXing.water:
        return const Color(0xFF1E90FF); // 파란색
      default:
        throw Exception('unknown');
    }

  }
}