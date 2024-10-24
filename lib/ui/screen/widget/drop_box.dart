import 'package:flutter/material.dart';

class DropBoxField<T> extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final T? selectedValue;
  final Function(T?) onChanged;
  final String? labelString;

  const DropBoxField({
    Key? key,
    required this.items,
    this.selectedValue,
    required this.onChanged,
    this.labelString
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: selectedValue,
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item['value'],
          child: Text(item['name']!),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: labelString,
      ),
    );
  }
}
