

import 'dart:ui';

import 'package:flutter/material.dart';

String getHeavenlyStem(int year) {
  List<String> heavenlyStems = ['갑', '을', '병', '정', '무', '기', '경', '신', '임', '계'];
  return heavenlyStems[year % 10];  // 10간에 맞춰 나머지로 천간을 구함
}

String getEarthlyBranch(int year) {
  List<String> earthlyBranches = ['자', '축', '인', '묘', '진', '사', '오', '미', '신', '유', '술', '해'];
  int baseYear = 1984;
  int index = (year - baseYear) % 12;

  // 음수 나머지 값 처리
  if (index < 0) {
    index += 12;
  }
  return earthlyBranches[index];  // 12지에 맞춰 나머지로 지지를 구함
}

List<dynamic> getZodiacWithDescription(int year) {

  String heavenlyStem = getHeavenlyStem(year);  // 천간 계산
  String earthlyBranch = getEarthlyBranch(year);  // 지지 계산

  // 천간별로 색상 및 동물 설명을 추가
  Map<String, String> descriptions = {
    '갑': '청',  // 목 (청색)
    '을': '청',  // 목 (청색)
    '병': '적',  // 화 (적색)
    '정': '적',  // 화 (적색)
    '무': '황',  // 토 (황색)
    '기': '황',  // 토 (황색)
    '경': '백',  // 금 (백색)
    '신': '백',  // 금 (백색)
    '임': '흑',  // 수 (흑색)
    '계': '흑',  // 수 (흑색)
  };

  Map<String, Color> descriptionColors = {
    '갑': Colors.blue,    // 목 (청색)
    '을': Colors.blue,    // 목 (청색)
    '병': Colors.red,     // 화 (적색)
    '정': Colors.red,     // 화 (적색)
    '무': Colors.yellow,  // 토 (황색)
    '기': Colors.yellow,  // 토 (황색)
    '경': Colors.white,   // 금 (백색)
    '신': Colors.white,   // 금 (백색)
    '임': Colors.black,   // 수 (흑색)
    '계': Colors.black,   // 수 (흑색)
  };

  // 지지에 따른 동물 이름 추가
  Map<String, String> animals = {
    '자': '쥐',
    '축': '소',
    '인': '호랑이',
    '묘': '토끼',
    '진': '용',
    '사': '뱀',
    '오': '말',
    '미': '양',
    '신': '원숭이',
    '유': '닭',
    '술': '개',
    '해': '돼지',
  };
  final String prefixAssetImage = 'assets/images/zodiacs';
  Map<String, String> animalsImagePaths = {
    '자': '${prefixAssetImage}/rat.png',
    '축': '${prefixAssetImage}/ox.png',
    '인': '${prefixAssetImage}/tiger.png',
    '묘': '${prefixAssetImage}/rabbit.png',
    '진': '${prefixAssetImage}/dragon.png',
    '사': '${prefixAssetImage}/snake.png',
    '오': '${prefixAssetImage}/horse.png',
    '미': '${prefixAssetImage}/sheep.png',
    '신': '${prefixAssetImage}/monkey.png',
    '유': '${prefixAssetImage}/rooster.png',
    '술': '${prefixAssetImage}/dog.png',
    '해': '${prefixAssetImage}/pig.png',
  };

  // 천간과 지지를 결합하여 상세한 설명 생성
  return [
    descriptions[heavenlyStem]!,
    animals[earthlyBranch]!,
    descriptionColors[heavenlyStem]!,
    heavenlyStem,
    earthlyBranch,
    animalsImagePaths[earthlyBranch]!
  ];

}
