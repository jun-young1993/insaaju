import 'package:flutter/material.dart';

// 공통적으로 사용할 수 있는 showDialog 함수
Future<void> showAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  String confirmText = 'OK',
  VoidCallback? onPress, // 버튼을 눌렀을 때의 동작을 받을 수 있음
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              // onPress가 제공되면 호출, 아니면 그냥 대화 상자를 닫음
              if (onPress != null) {
                onPress();
              } 
            },
            child: Text(confirmText),
          ),
        ],
      );
    },
  );
}
