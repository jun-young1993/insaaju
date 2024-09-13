import 'package:flutter/material.dart';
import 'package:insaaju/domain/entities/info.dart';

class InfoRow extends StatefulWidget {
  final Info info;

  InfoRow({
    required this.info
  });

  @override
  _InfoRowState createState() => _InfoRowState();
}

class _InfoRowState extends State<InfoRow> {
  

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildProfile(),
        const SizedBox(width: 10,),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.info.name,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(widget.info.toStringDateTime())
          ],
        )
      ],
    );
  }
  
  Widget _buildProfile({
    double size = 30
  }){
    return Container(
      width: size * 2 ,  // 원하는 너비
      height: size * 2,  // 원하는 높이
      decoration: BoxDecoration(
        color: Colors.blue[200],  // 배경 색상
        borderRadius: BorderRadius.circular(16.0),  // 둥근 모서리
      ),
      child: Center(
        child: Icon(
          Icons.person,  // 사람 아이콘
          size: size,  // 아이콘 크기
          color: Colors.white,  // 아이콘 색상
        ),
      ),
    );
  }
}