import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Widget? child;
  final bool? hidden;
  final Function()? onPressed;

  const AppButton({
    super.key, 
    this.child, 
    this.onPressed, 
    this.hidden
  });

  @override
  Widget build(BuildContext context) {
    return hidden == true 
    ? Container()
    : ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,    // 버튼 텍스트 색상
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0), // 버튼 내부 여백
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // 둥근 모서리
        ),
        elevation: 5, // 그림자 높이
      ),
      child: child
    );
  }
}