import 'package:flutter/material.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/ui/screen/widget/info/info_profile.dart';

class InfoRow extends StatefulWidget {
  final Info info;
  final double? profileSize;
  InfoRow({
    required this.info, this.profileSize
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
        _buildProfile(size: widget.profileSize ?? 30),
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
    return InfoProfile(size: size);
  }
}