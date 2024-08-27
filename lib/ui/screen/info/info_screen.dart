import 'package:flutter/material.dart';
import 'package:insaaju/states/info/info_selector.dart';
import 'package:insaaju/ui/screen/info/name_screen.dart';


class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  _InfoScreenState createState() => _InfoScreenState();
}
class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: InfoStateSelector((info){
          return Column(
            children: [
              Expanded(child: NameScreen())
            ]
          );
        })
      )
    );
  }
}