import 'package:flutter/material.dart';
import 'package:insaaju/ui/screen/widget/button.dart';

class BirthdateScreen extends StatelessWidget {
  final Function(DateTime)? onTap;
  final TextEditingController _dateController = TextEditingController();

  BirthdateScreen({Key? key, this.onTap}) : super(key: key);

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    
    if (selectedDate != null) {
      _dateController.text = selectedDate.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your birthdate',
              ),
              readOnly: true,
              onTap: () => _selectDate(context),
            ),
            SizedBox(height: 20),
            AppButton(
              onPressed: () {
                String date = _dateController.text;
                if (date.isNotEmpty) {
                  // 선택된 날짜를 외부에서 전달된 onTap 함수로 넘김
                  if (onTap != null) {
                    onTap!(DateTime.parse(date));
                  }
                } else {
                  // 생년월일이 입력되지 않았을 때의 경고 메시지
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Input Required'),
                        content: Text('Please select your birthdate before proceeding.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
