import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BirthDateField extends StatefulWidget {
  final Function(String value) onSubmitted;

  const BirthDateField({super.key, required this.onSubmitted});
  @override
  _BirthDateFieldState createState() => _BirthDateFieldState();

}
class _BirthDateFieldState extends State<BirthDateField> {
  final List<String> solarAndLunar = ['양력','음력'];
  late String solarAndLunarValue = solarAndLunar.first;
  final TextEditingController _dateController = TextEditingController();
  


  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      _dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
      widget.onSubmitted("${solarAndLunarValue} ${_dateController.text}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropdownButton<String>(
          value: solarAndLunarValue,
          icon: const Icon(Icons.arrow_downward),
          onChanged: (String? value){
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                solarAndLunarValue = value!;
              });
            });
          },
          items: solarAndLunar.map<DropdownMenuItem<String>>((String value){
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value)
            );
          }).toList()
        ),
        Expanded(
          child: TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                // border: OutlineInputBorder(),
                labelText: 'Enter your birthdate',
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