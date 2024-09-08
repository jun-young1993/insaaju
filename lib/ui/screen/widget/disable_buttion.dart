import 'package:flutter/material.dart';

class DisableButton extends StatelessWidget {
  final String text;
  final bool isDisabled;
  final VoidCallback? onPressed;

  const DisableButton({
    super.key,
    required this.text,
    this.isDisabled = false, // 기본값은 활성 상태
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed, // isDisabled가 true이면 onPressed를 null로 설정하여 비활성화
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (isDisabled) {
              return Colors.grey; // 비활성화된 상태의 배경색
            }
            return Colors.blue; // 기본 배경색
          },
        ),
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
            return isDisabled ? Colors.black38 : Colors.white; // 비활성화 상태의 텍스트 색상
          },
        ),
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0)),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        )),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}