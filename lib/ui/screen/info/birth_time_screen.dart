import 'package:flutter/material.dart';



class BirthTimeScreen extends StatelessWidget {
  final Function(String)? onTap;
  final TextEditingController _timeController = TextEditingController();

 BirthTimeScreen({
    super.key, 
    this.onTap
  });

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
        final now = DateTime.now();
        final DateTime selectedDateTime = DateTime(now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
        _timeController.text = "${selectedTime.format(context)}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Birthdate and Time'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _timeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your birth time',
                ),
                readOnly: true, // 텍스트 필드를 클릭할 수 없도록 설정
                onTap: () => _selectTime(context), // 필드를 탭하면 시간 선택기가 열림
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final String time = _timeController.text;
                  if (time.isNotEmpty) {
                    onTap!(time);
                  } else {
                    // 생년월일 또는 출생시간이 입력되지 않았을 때의 경고 메시지
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Input Required'),
                          content: Text('Please select both your birthdate and time before proceeding.'),
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
      ),
    );
  }
}