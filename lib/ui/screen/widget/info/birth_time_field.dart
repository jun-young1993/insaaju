import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class BirthTimeField extends StatefulWidget {
  final Function(String value) onSubmitted;
  BirthTimeField({
    super.key,
    required this.onSubmitted
  });

  _BirthTimeFieldState createState() => _BirthTimeFieldState();
}
class _BirthTimeFieldState extends State<BirthTimeField> {
  final TextEditingController _timeController = TextEditingController();

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      _timeController.text = "${selectedTime.format(context)}";
      widget.onSubmitted(_timeController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _timeController,
      decoration: const InputDecoration(
        // border: OutlineInputBorder(),
        labelText: 'Enter your birthdate time',
      ),
      readOnly: true,
      onTap: () => _selectTime(context),
    );
  }

}