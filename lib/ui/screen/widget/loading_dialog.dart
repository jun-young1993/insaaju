import 'package:flutter/material.dart';

// 로딩 다이얼로그 함수
void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // 다이얼로그 외부를 클릭해도 닫히지 않도록 설정
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(), // 로딩 표시기
              SizedBox(height: 15),
              Text('Loading...', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      );
    },
  );
}

// 로딩 다이얼로그 닫기 함수
void hideLoadingDialog(BuildContext context) {
  Navigator.of(context).pop();
}