import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Widget? child;
  final bool? hidden;
  final bool isDisabled;
  final Function()? onPressed;

  const AppButton({
    super.key, 
    this.child, 
    this.onPressed, 
    this.hidden,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return hidden == true 
    ? Container()
    : ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: isDisabled ? Colors.grey : Colors.white,
        backgroundColor: isDisabled ? Colors.grey[400] : Colors.blueAccent,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0), // 버튼 내부 여백
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // 둥근 모서리
        ),
        elevation: isDisabled ? 0 : 5,
      ),
      child: child
    );
  }
}