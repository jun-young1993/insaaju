import 'package:flutter/material.dart';

class BigMenuButton extends StatelessWidget{
  final BuildContext? context;
  final VoidCallback? onPress;
  final Widget? child;
  final double height;
  final double fontSize;

  const BigMenuButton({
    super.key, 
    this.context, 
    this.onPress, 
    this.child,
    this.height = 60,
    this.fontSize = 16
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // 버튼의 너비를 부모의 너비로 설정
      height: height, // 버튼의 높이를 설정
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.0),
          textStyle: TextStyle(fontSize: fontSize), // 버튼 텍스트의 크기를 설정
        ),
        onPressed: () {
          if(onPress != null){
            onPress!();
          }
          
        },
        child: child,
      ),
    );
  }

}