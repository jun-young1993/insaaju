import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NameField extends StatelessWidget {
  final Function(String value) onSubmitted;
  const NameField({
    super.key,
    required this.onSubmitted
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        labelText: '이름',
      ),
      onSubmitted: (String value) {
        onSubmitted(value);
      },
    );
  }

}