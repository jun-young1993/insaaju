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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // DropdownButton의 크기를 TextField와 맞추기 위해 isExpanded와 Container를 사용
        Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 2.0), // 내부 여백을 추가
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), // TextField와 유사한 테두리 추가
                borderRadius: BorderRadius.circular(5.0), // 둥근 모서리 적용
              ),
              child: Center(
                child: DropdownButton<String>(
                  value: solarAndLunarValue,
                  onChanged: (String? value) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        solarAndLunarValue = value!;
                      });
                    });
                  },
                  // isExpanded: true, // DropdownButton의 크기를 확장
                  underline: SizedBox(), // 밑줄 제거
                  items: solarAndLunar.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
        ),
        SizedBox(width: 20,),
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