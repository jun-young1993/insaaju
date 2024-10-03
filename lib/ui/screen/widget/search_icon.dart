import 'package:flutter/material.dart';

class SearchIcon extends StatefulWidget {
  final Function(String) onSubmitted;
  final Function(bool)? onExpanded;

  const SearchIcon({super.key, required this.onSubmitted, this.onExpanded});
  @override
  _SearchIconState createState() => _SearchIconState();
}

class _SearchIconState extends State<SearchIcon> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // AnimatedContainer로 검색 바 확장/축소 구현
        AnimatedContainer(
          duration: Duration(milliseconds: 300), // 애니메이션 지속 시간
          width: _isExpanded ? 100 : 0, // 확장된 너비와 축소된 너비
          curve: Curves.easeInOut, // 애니메이션 효과
          child: _isExpanded
              ? TextField(
                  decoration: InputDecoration(
                    hintText: '검색어 입력',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                onSubmitted: (value){
                  widget.onSubmitted(value);
                },
          )
              : null, // 축소 시 텍스트 필드 숨김
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            setState(() {
              _isExpanded = !_isExpanded; // 버튼 클릭 시 확장/축소 상태 토글
              widget.onExpanded!(_isExpanded);
            });
          },
        ),
      ],
    );
  }
}