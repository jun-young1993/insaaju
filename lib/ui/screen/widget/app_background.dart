import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insaaju/routes.dart';
import 'package:insaaju/ui/screen/widget/loading_box.dart';

class AppBackground extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPress;
  final bool isLoading; // 로딩 상태를 받는 매개변수
  final String? loadingText;
  final bool showBackIcon;
  final bool isBackground;
  final AppBar? appBar;

  const AppBackground({
    super.key,
    required this.child,
    this.onPress,
    this.isLoading = false,
    this.loadingText,
    this.showBackIcon = true,
    this.isBackground = false, 
    this.appBar,
  });

  @override
  _AppBackgroundState createState() => _AppBackgroundState();
}

class _AppBackgroundState extends State<AppBackground> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar != null
      ? PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: Container(
            margin: const EdgeInsets.all(20),
            child: widget.appBar,
          )
        )
      : null,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // if(widget.isBackground)
          //   Image.asset(
          //     'assets/images/background.jpeg',
          //     fit: BoxFit.cover,
          //   ),
          widget.child,
          if (widget.isLoading) // 로딩 상태가 true일 때 로딩 위젯을 표시
            _LoadingOverlay(
              loadingText: widget.loadingText,
            ), // 로딩 오버레이 위젯 추가
        ],
      ),
    );
  }
}

// 로딩 오버레이 위젯
class _LoadingOverlay extends StatelessWidget {
  final String? loadingText;
  const _LoadingOverlay({
    super.key,
    this.loadingText
  });

  @override
  Widget build(BuildContext context) {
    return LoadingBox(
      loadingText: loadingText,
    );
  }
}