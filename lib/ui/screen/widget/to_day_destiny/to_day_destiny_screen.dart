import 'package:flutter/material.dart';
import 'package:insaaju/domain/entities/info.dart';
import 'package:insaaju/ui/screen/widget/app_background.dart';
import 'package:insaaju/ui/screen/widget/app_bar_close_leading_button.dart';
import 'package:insaaju/ui/screen/widget/info/info_profile.dart';

class ToDayDestinyScreen extends StatefulWidget {
  final Info info;
  final VoidCallback onPressed;
  const ToDayDestinyScreen({
      super.key,
      required this.info,
      required this.onPressed,
  });

  @override
  _ToDayDestinyState createState() => _ToDayDestinyState();
}

class _ToDayDestinyState extends State<ToDayDestinyScreen> {
  
  @override
  Widget build(BuildContext context) {
    return AppBackground(
      appBar: _buildAppBar(),
      child: _buildTODayDestiny()
    );
  }

  Widget _buildAppBarTitle(){
    return const Text(
          "오늘의 운세",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
       );
    
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: _buildAppBarTitle(),
      leading: AppBarCloseLeadingButton(
        onPressed: () {
          widget.onPressed();
        },
      ),
    );
  }

  Widget _buildTODayDestiny(){
    return Text('toDayDestiny');
  }

  

}