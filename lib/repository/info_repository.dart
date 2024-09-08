import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:insaaju/configs/info_constants.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/exceptions/duplicate_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class InfoRepository {
  Future<Map<String, dynamic>> loadHanjaJson();
  Future<List<List<Map<String, dynamic>>>> getHanjaByCharacters(List<String> characters);
  Future<bool> save(Info info);
  Future<bool> check(Info info);
  Future<List<Info>> getAll();
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

    return hanjaList;
  }

  Future<bool> check(Info info) async {
    final prefs = await SharedPreferences.getInstance();
    // 기존에 저장된 정보 리스트 가져오기
    List<String> savedInfoList = prefs.getStringList(InfoConstants.info) ?? [];

    // JSON 문자열을 다시 Info 객체로 변환하여 중복 여부 확인
    List<Info> savedInfos = savedInfoList.map((jsonString) {
      Map<String, dynamic> infoMap = jsonDecode(jsonString);
      return Info(
        infoMap['name'],
        infoMap['hanja'],
        infoMap['date'],
        infoMap['time'],
      );
    }).toList();

    // 중복 여부를 확인: 동일한 name, hanja, date, time 값이 있는지 체크
    bool isDuplicate = savedInfos.any((savedInfo) =>
    savedInfo.name == info.name &&
        savedInfo.hanja == info.hanja &&
        savedInfo.date == info.date &&
        savedInfo.time == info.time);

    // 중복이 있다면 저장하지 않고 false 반환
    if (isDuplicate) {
      throw DuplicateException<String>(info.toString());
    }
    return isDuplicate;
  }

  Future<bool> save(Info info) async {
    final prefs = await SharedPreferences.getInstance();
    // 기존에 저장된 정보 리스트 가져오기
    List<String> savedInfoList = prefs.getStringList(InfoConstants.info) ?? [];

    // 새로운 Info 객체를 JSON으로 변환하여 리스트에 추가
    savedInfoList.add(jsonEncode(info.toJson()));
    final bool result = await prefs.setStringList(InfoConstants.info, savedInfoList);
    
    // 업데이트된 리스트를 다시 SharedPreferences에 저장
    return result;
  }

  Future<List<Info>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    // 저장된 JSON 문자열 리스트 가져오기
    List<String> savedInfoList = prefs.getStringList(InfoConstants.info) ?? [];

    // JSON 문자열 리스트를 Info 객체 리스트로 변환
    List<Info> infoList = savedInfoList.map((jsonString) {
      Map<String, dynamic> infoMap = jsonDecode(jsonString);
      return Info(
        infoMap['name'],
        infoMap['hanja'],
        infoMap['date'],
        infoMap['time'],
      );
    }).toList();

    return infoList;
  }
}