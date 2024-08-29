import 'dart:convert';

import 'package:flutter/services.dart';

abstract class InfoRepository {
  Future<Map<String, dynamic>> loadHanjaJson();

  Future<List<List<Map<String, dynamic>>>> getHanjaByCharacters(List<String> characters);
}
class InfoDefaultRepository extends InfoRepository{
  InfoDefaultRepository();

  Future<Map<String, dynamic>> loadHanjaJson() async {
    String jsonString = await rootBundle.loadString('assets/hanja/hanja.json');
    
    // JSON 문자열을 Map<String, dynamic> 형식으로 디코딩
    Map<String, dynamic> hanjaData = json.decode(jsonString);
    
    // 로드된 데이터를 반환
    return hanjaData;
  }

  Future<List<List<Map<String, dynamic>>>> getHanjaByCharacters(List<String> characters) async {
    Map<String, dynamic> hanjaData = await loadHanjaJson();

      List<List<Map<String, dynamic>>> hanjaList = [];

        for (String char in characters) {
      if (hanjaData.containsKey(char)) {
        List<dynamic> hanjaOptions = hanjaData[char];
        // 각 옵션에서 한자만 추출하여 리스트에 추가
        List<Map<String, dynamic>> hanjas = hanjaOptions.map((option) => {
          "hanja": option['hanja'],
          "meaning": option['meaning'],
          "strokes": option['strokes']
        }).toList();

        hanjaList.add(hanjas);
      } else {
        // 만약 한자가 없는 경우 빈 리스트 추가
        hanjaList.add([]);
      }
    }
    print(hanjaList);
    return hanjaList;
  }
}