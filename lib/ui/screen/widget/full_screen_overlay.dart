import 'package:flutter/material.dart';

class FullScreenOverlay extends StatefulWidget {
  final Widget defaultWidget;
  final Widget? child;

  const FullScreenOverlay({
    super.key,
    required this.defaultWidget,
    this.child,
  });

  @override
  _FullScreenOverlayState createState() => _FullScreenOverlayState();
}

class _FullScreenOverlayState extends State<FullScreenOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  bool _isOverlayVisible = false; // 초기 상태에서는 오버레이가 보이지 않음

  @override
  void initState() {
    super.initState();

    // AnimationController 초기화
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // 아래에서 위로 이동하는 애니메이션 설정
    _animation = Tween<Offset>(
      begin: const Offset(0, 1), // 화면 아래에 위치
      end: const Offset(0, 0),   // 화면의 원래 위치
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // 초기에는 오버레이가 없으므로 애니메이션을 실행하지 않음
    if (widget.child != null) {
      _controller.forward();
      _isOverlayVisible = true;
    }
  }

  @override
  void didUpdateWidget(FullScreenOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);

    // child가 null에서 값으로 변경될 때 애니메이션 시작
    if (oldWidget.child == null && widget.child != null) {
      _showOverlay();
    }
    // child가 값에서 null로 변경될 때 애니메이션 종료
    else if (oldWidget.child != null && widget.child == null) {
      _hideOverlay();
    }
  }

  Future<void> _showOverlay() async {
    _controller.forward();
    setState(() {
      _isOverlayVisible = true;
    });
  }

  Future<void> _hideOverlay() async {
    _controller.reverse();
    setState(() {
      _isOverlayVisible = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.defaultWidget, // 기본 화면

        // 오버레이가 있을 때 애니메이션 적용
        if (_isOverlayVisible)
          SlideTransition(
            position: _animation,
            child: widget.child ?? Container(), // 오버레이로 표시될 화면
          ),
      ],
    );
  }
}