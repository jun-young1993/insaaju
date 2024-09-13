import 'package:flutter/material.dart';

class FullScreenOverlay extends StatefulWidget {
  final Widget? child;
  final Widget defaultWidget;
  const FullScreenOverlay({super.key, this.child, required this.defaultWidget});
  @override
  _FullScreenOverlayState createState() => _FullScreenOverlayState();
}

class _FullScreenOverlayState extends State<FullScreenOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    
    // AnimationController 초기화
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // 아래에서 위로 이동하는 애니메이션 설정
    _animation = Tween<Offset>(
      begin: const Offset(0, 1), // 화면 아래에 위치
      end: const Offset(0, 0),   // 화면의 원래 위치
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // 애니메이션 곡선 설정
    ));

    // 애니메이션 시작
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // AnimationController 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          widget.defaultWidget,
          if(widget.child != null)
            SlideTransition(
              position: _animation,
              child: widget.child
            )
        ],
      ),
    );
  }
}
