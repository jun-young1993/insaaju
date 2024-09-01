import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insaaju/routes.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  const AppBackground({
    super.key,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('insaaju'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // 뒤로가기 버튼을 눌렀을 때만 Navigator.pop 호출
              AppNavigator.pop();
            },
          ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          child
        ],
      )
    );
  }
}
