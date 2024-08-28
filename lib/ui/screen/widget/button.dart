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
      child: child
    );
  }
}