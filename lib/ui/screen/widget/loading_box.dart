import 'package:flutter/material.dart';

enum LoadingBoxDirection {
  row,
  column
}

class LoadingBox extends StatelessWidget {
  final String? loadingText;
  final Color? backgroundColor;
  final LoadingBoxDirection? direction;
  final MainAxisAlignment? mainAxisAlignment;
  final double? betweenTextBoxSize;
  const LoadingBox({
    super.key,
    this.loadingText, 
    this.backgroundColor, 
    this.direction, this.mainAxisAlignment, this.betweenTextBoxSize
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Colors.white.withOpacity(0.0),
      child: Center(
        child: _buildCircularProgress()
      ),
    );
  }

  Widget _buildCircularProgress(){
    switch(direction){
      case LoadingBoxDirection.row:
        return _buildRowMode();
      default:
        return _buildColumnMode();
    }
  }

  Widget _buildColumnMode(){
    return Column(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      children:_buildTextCircular()
    );
  }

  Widget _buildRowMode(){
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      children: _buildTextCircular()
    );
  }

  Widget _buildCircularProgressTextBetweenBox(){    
    final double betweenSize = betweenTextBoxSize ?? 8; 
    switch(direction){
      case LoadingBoxDirection.row:
        return SizedBox(width: betweenSize,);
      default:
        return SizedBox(height: betweenSize,);
    }
  }

  List<Widget> _buildTextCircular(){
    return [
        const CircularProgressIndicator(
          color: Colors.grey, // 로딩 인디케이터 색상
        ),
        _buildCircularProgressTextBetweenBox(),
        SizedBox(width: 10,),
        if (loadingText != null) // loadingText가 null이 아닐 때만 텍스트 표시
          Text(
            loadingText!,
            style: const TextStyle(
              color: Colors.grey, // 텍스트 색상
              fontSize: 16, // 텍스트 크기
            ),
          ),
    ];
  }
}