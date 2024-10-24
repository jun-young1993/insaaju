import 'package:flutter/material.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/states/info/info_state.dart';
import 'package:insaaju/ui/screen/widget/info/info_profile.dart';

class InfoRow extends StatefulWidget {
  final Info info;
  final double? profileSize;
  const InfoRow({
    super.key, 
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
            const SizedBox(height: 5,),
            Row(
              children: [
                Icon(
                  (widget.info.solarAndLunar != SolarAndLunarType.solar)
                  ? Icons.sunny
                  : Icons.mode_night,
                  color: (widget.info.solarAndLunar != SolarAndLunarType.solar) ? const Color.fromARGB(255, 243, 132, 124) : const Color.fromARGB(255, 150, 141, 140)
                ),
                const SizedBox(width: 10,),
                Text(widget.info.toStringDateTime())
              ],
            ),
            
          ],
        )
      ],
    );
  }
  
  Widget _buildProfile({
    double size = 30
  }){
  
    return InfoProfile(
        size: size,
        info: widget.info,
    );
  }
}