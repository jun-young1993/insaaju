import 'package:flutter/material.dart';

class DropBoxField extends StatelessWidget {
  final List<Map<String, String>> items;
  final String? selectedValue;
  final Function(String?) onChanged;

  const DropBoxField({
    Key? key,
    required this.items,
    this.selectedValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item['value'],
          child: Text(item['name']!),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Select an option',
      ),
    );
  }
}
