import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insaaju/routes.dart';

class AppBackground extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPress;
  final bool isLoading; // 로딩 상태를 받는 매개변수
  final String? loadingText;
  final bool showBackIcon;
  final bool isBackground;

  const AppBackground({
    super.key,
    required this.child,
    this.onPress,
    this.isLoading = false,
    this.loadingText,
    this.showBackIcon = true,
    this.isBackground = false, // 기본값은 로딩하지 않는 상태로 설정
  });

  @override
  _AppBackgroundState createState() => _AppBackgroundState();
}

class _AppBackgroundState extends State<AppBackground> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: (widget.showBackIcon)
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                  if(widget.isLoading == false){
                    if (widget.onPress != null) {
                      widget.onPress!();
                    } else {
                      AppNavigator.pop();
                    }
                  }

              },
            )
          : Container()
      ),
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
    return Container(
      color: Colors.black.withOpacity(0.5), // 배경 어둡게
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: Colors.white, // 로딩 인디케이터 색상
            ),
            const SizedBox(height: 8),
            if (loadingText != null) // loadingText가 null이 아닐 때만 텍스트 표시
              Text(
                loadingText!,
                style: const TextStyle(
                  color: Colors.white, // 텍스트 색상
                  fontSize: 16, // 텍스트 크기
                ),
              ),
          ],
        )
      ),
    );
  }
}