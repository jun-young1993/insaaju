import 'package:flutter/material.dart';

class CheckScreen extends StatelessWidget {
  final String? name;
  final String? date;
  final String? time;

  const CheckScreen({
    super.key, 
    this.name, 
    this.date, 
    this.time
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('${name} ${date} ${time} 이 맞습니까?'),
    );
  }
}