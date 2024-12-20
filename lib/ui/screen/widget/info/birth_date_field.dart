import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BirthDateField extends StatefulWidget {
  final Function(DateTime value) onSubmitted;

  const BirthDateField({super.key, required this.onSubmitted});
  @override
  _BirthDateFieldState createState() => _BirthDateFieldState();

}
class _BirthDateFieldState extends State<BirthDateField> {
  final TextEditingController _dateController = TextEditingController();
  


  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      _dateController.text = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
      widget.onSubmitted(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                // border: OutlineInputBorder(),
                labelText: '생년월일',
              ),
              readOnly: true,
              onTap: () => _selectDate(context),
            ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }
}